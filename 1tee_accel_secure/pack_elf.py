#!/usr/bin/env python3
"""
Pack an ELF for the riscv_firmware_secure PEL2 loader, or inject the AES key
into the firmware ELF.

Two modes, auto-detected from the input ELF:

  INJECT mode (input ELF defines the 'aes_key' symbol):
    Patches the 16-byte AES key from --key into the symbol's bytes.
    Output is a modified firmware ELF.

  PACK mode (any other ELF):
    Parses PT_LOAD segments. Each segment is independently AES-128-CTR
    encrypted and HMAC-SHA512 authenticated. A small encrypted+MACed
    manifest carries entry_point and per-segment metadata (paddr, size,
    IV, HMAC). Layout:

        outer:
          off  size  field
          0    4     magic         "PEL2"  (LE u32 = 0x324C4550)
          4    4     manifest_sz   (u32 LE; no padding under CTR)
          8    16    manifest_iv
          24   64    manifest_hmac (HMAC-SHA512)
          88   M     manifest_ciphertext
          88+M ...   segment ciphertexts, back-to-back

        manifest plaintext:
          0    4     entry_point
          4    4     num_segments
          8    88*N  segments[]: { u32 paddr; u32 size; u8 iv[16]; u8 hmac[64] }

    HMAC bindings:
      manifest: HMAC(hmac_key, magic||manifest_sz||manifest_iv||manifest_ct)
      segment i: HMAC(hmac_key, u32_LE(i)||u32_LE(paddr)||u32_LE(size)||iv||ct)

    Total bundle size = 88 + manifest_sz + sum(p_filesz for PT_LOAD).
    No encryption expansion.

Usage:
  pack_elf.py --key KEYFILE INPUT OUTPUT

KEYFILE is a 16-byte raw binary AES-128 key. HMAC key = SHA-512(AES key),
matching the firmware.

Dependencies: pyelftools, pycryptodome
  pip install pyelftools pycryptodome
"""

import argparse
import hashlib
import hmac
import os
import struct
import sys
from io import BytesIO

try:
    from elftools.elf.elffile import ELFFile
    from elftools.elf.sections import SymbolTableSection
except ImportError:
    sys.exit("missing dependency: pip install pyelftools")

try:
    from Crypto.Cipher import AES
    from Crypto.Util import Counter
except ImportError:
    sys.exit("missing dependency: pip install pycryptodome")


MAGIC = b"PEL2"
AES_KEYLEN = 16
IV_LEN = 16
HMAC_LEN = 64
OUTER_HDR_LEN = 4 + 4 + IV_LEN + HMAC_LEN          # 88
SEG_ENTRY_LEN = 4 + 4 + IV_LEN + HMAC_LEN          # 88
MAX_SEGS = 16
KEY_SYMBOL = "aes_key"


def derive_hmac_key(aes_key):
    """Firmware derives the same: HMAC key = SHA-512(AES key), 64 bytes."""
    return hashlib.sha512(aes_key).digest()


def aes_ctr_xcrypt(key, iv, data):
    """AES-128-CTR with the 16-byte IV treated as a 128-bit big-endian
    counter. Matches the tiny-AES `AES_CTR_xcrypt_buffer` semantics used
    by the firmware (counter is the whole 16-byte IV, incremented MSB-last)."""
    ctr = Counter.new(128, initial_value=int.from_bytes(iv, "big"))
    return AES.new(key, AES.MODE_CTR, counter=ctr).encrypt(data)


# --- inject mode (unchanged from PELF version) ---

def find_symbol(elf, name):
    for section in elf.iter_sections():
        if not isinstance(section, SymbolTableSection):
            continue
        for sym in section.iter_symbols():
            if sym.name != name:
                continue
            size = sym.entry["st_size"]
            if size == 0:
                continue
            addr = sym.entry["st_value"]
            for s in elf.iter_sections():
                sh_addr = s["sh_addr"]
                sh_size = s["sh_size"]
                if sh_addr <= addr < sh_addr + sh_size:
                    if s["sh_type"] == "SHT_NOBITS":
                        sys.exit(
                            f"symbol '{name}' is in NOBITS section "
                            f"({s.name}); give it a non-zero initializer "
                            "so it lands in a loaded section."
                        )
                    return s["sh_offset"] + (addr - sh_addr), size
    return None


def has_symbol(elf_path, name):
    with open(elf_path, "rb") as f:
        try:
            return find_symbol(ELFFile(f), name) is not None
        except Exception:
            return False


def inject(elf_path, out_path, key):
    with open(elf_path, "rb") as f:
        blob = bytearray(f.read())
    res = find_symbol(ELFFile(BytesIO(bytes(blob))), KEY_SYMBOL)
    if res is None:
        sys.exit(f"symbol '{KEY_SYMBOL}' not found in {elf_path}")
    offset, size = res
    if size != len(key):
        sys.exit(f"symbol size {size} != key size {len(key)}")
    blob[offset:offset + size] = key
    with open(out_path, "wb") as f:
        f.write(blob)
    print(f"injected {len(key)}-byte AES key at file offset 0x{offset:x} "
          f"-> {out_path}")


# --- pack mode (PEL2) ---

def _collect_pt_loads(elf_path):
    """Return [{paddr, size, data}] for each PT_LOAD with non-zero p_filesz,
    plus the ELF entry point."""
    with open(elf_path, "rb") as f:
        elf = ELFFile(f)
        entry = elf.header["e_entry"]
        loads = []
        for seg in elf.iter_segments():
            if seg["p_type"] != "PT_LOAD":
                continue
            filesz = seg["p_filesz"]
            if filesz == 0:
                continue
            loads.append({
                "paddr": seg["p_paddr"],
                "size":  filesz,
                "data":  seg.data(),
            })
    return entry, loads


def pack(elf_path, out_path, key):
    entry, loads = _collect_pt_loads(elf_path)
    if not loads:
        sys.exit("no PT_LOAD segments with data found")
    if len(loads) > MAX_SEGS:
        sys.exit(f"too many PT_LOAD segments: {len(loads)} > {MAX_SEGS}")

    hmac_key = derive_hmac_key(key)

    # Encrypt each segment and compute its MAC (binding: idx||paddr||size).
    seg_ciphertexts = []
    seg_entries = []  # one 88-byte entry per segment in the manifest
    for i, seg in enumerate(loads):
        iv = os.urandom(IV_LEN)
        ct = aes_ctr_xcrypt(key, iv, seg["data"])
        assert len(ct) == seg["size"]
        bind = struct.pack("<III", i, seg["paddr"], seg["size"])
        mac = hmac.new(hmac_key, bind + iv + ct, hashlib.sha512).digest()
        seg_ciphertexts.append(ct)
        seg_entries.append(
            struct.pack("<II", seg["paddr"], seg["size"]) + iv + mac
        )

    # Build manifest plaintext: { entry, num_segments, seg_entries[...] }.
    manifest_pt = struct.pack("<II", entry, len(loads)) + b"".join(seg_entries)
    manifest_sz = len(manifest_pt)
    assert manifest_sz == 8 + SEG_ENTRY_LEN * len(loads)

    # Encrypt manifest with its own IV.
    manifest_iv = os.urandom(IV_LEN)
    manifest_ct = aes_ctr_xcrypt(key, manifest_iv, manifest_pt)
    assert len(manifest_ct) == manifest_sz

    # Manifest MAC over (magic || manifest_sz || manifest_iv || ciphertext).
    outer_prefix = MAGIC + struct.pack("<I", manifest_sz) + manifest_iv
    manifest_mac = hmac.new(
        hmac_key, outer_prefix + manifest_ct, hashlib.sha512
    ).digest()

    with open(out_path, "wb") as f:
        f.write(outer_prefix)
        f.write(manifest_mac)
        f.write(manifest_ct)
        for ct in seg_ciphertexts:
            f.write(ct)

    total = OUTER_HDR_LEN + manifest_sz + sum(len(b) for b in seg_ciphertexts)
    print(f"PEL2 packed: entry=0x{entry:08x} num_segments={len(loads)}")
    for i, seg in enumerate(loads):
        print(f"  seg[{i}] paddr=0x{seg['paddr']:08x} size={seg['size']}")
    print(f"  manifest_sz={manifest_sz} total={total} bytes -> {out_path}")


def main():
    p = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    p.add_argument("--key", required=True,
                   help="path to 16-byte AES-128 key file")
    p.add_argument("input", help="input ELF")
    p.add_argument("output", help="output file")
    p.add_argument("--force", choices=("pack", "inject"),
                   help="override auto-detected mode")
    args = p.parse_args()

    with open(args.key, "rb") as f:
        key = f.read()
    if len(key) != AES_KEYLEN:
        sys.exit(f"key must be {AES_KEYLEN} bytes (got {len(key)})")

    mode = args.force
    if mode is None:
        mode = "inject" if has_symbol(args.input, KEY_SYMBOL) else "pack"

    if mode == "inject":
        inject(args.input, args.output, key)
    else:
        pack(args.input, args.output, key)


if __name__ == "__main__":
    main()
