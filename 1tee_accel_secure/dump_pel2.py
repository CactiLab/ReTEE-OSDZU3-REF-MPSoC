#!/usr/bin/env python3
"""
Parse a PEL2 bundle and print its metadata.

PEL2 layout (see pack_elf.py for the authoritative spec):

    outer:
      off  size  field
      0    4     magic         "PEL2"  (LE u32 = 0x324C4550)
      4    4     manifest_sz   (u32 LE; CTR preserves size)
      8    16    manifest_iv
      24   64    manifest_hmac (HMAC-SHA512)
      88   M     manifest_ciphertext       (AES-128-CTR over plaintext below)
      88+M ...   segment ciphertexts, back-to-back

    manifest plaintext:
      0    4     entry_point
      4    4     num_segments
      8    88*N  segments[]: { u32 paddr; u32 size; u8 iv[16]; u8 hmac[64] }

Without --key: only the outer header is decoded (the manifest is encrypted),
but N is inferred from manifest_sz so segment count / segment-ciphertext
layout can still be reported. HMACs cannot be verified without the key
because they are computed over plaintext (matching the firmware's
LOAD->DECRYPT->VERIFY order).

With --key: the manifest is decrypted, per-segment entries are printed,
and all HMACs (manifest + per-segment) are verified against the recovered
plaintext.

Usage:
  dump_pel2.py BUNDLE.pel2 [--key KEYFILE] [--hex]
"""

import argparse
import hashlib
import hmac
import struct
import sys


MAGIC = b"PEL2"
IV_LEN = 16
HMAC_LEN = 64
OUTER_HDR_LEN = 4 + 4 + IV_LEN + HMAC_LEN          # 88
SEG_ENTRY_LEN = 4 + 4 + IV_LEN + HMAC_LEN          # 88
AES_KEYLEN = 16
MAX_SEGS = 16


def aes_ctr_xcrypt(key, iv, data):
    """AES-128-CTR with the 16-byte IV as a 128-bit big-endian counter
    (matches tiny-AES `AES_CTR_xcrypt_buffer` semantics used by the firmware)."""
    try:
        from Crypto.Cipher import AES
        from Crypto.Util import Counter
    except ImportError:
        sys.exit("missing dependency for --key: pip install pycryptodome")
    ctr = Counter.new(128, initial_value=int.from_bytes(iv, "big"))
    return AES.new(key, AES.MODE_CTR, counter=ctr).encrypt(data)


def fmt_hex(b, group=0):
    h = b.hex()
    if group <= 0:
        return h
    return " ".join(h[i:i + group * 2] for i in range(0, len(h), group * 2))


def hex_preview(b, head=16):
    if len(b) <= head:
        return fmt_hex(b)
    return f"{fmt_hex(b[:head])}... ({len(b)} bytes)"


def parse(path, key=None, full_hex=False):
    with open(path, "rb") as f:
        blob = f.read()

    print(f"file: {path}")
    print(f"  size: {len(blob)} bytes")

    if len(blob) < OUTER_HDR_LEN:
        sys.exit(f"file too small: {len(blob)} < {OUTER_HDR_LEN} (outer header)")

    magic = blob[0:4]
    manifest_sz, = struct.unpack("<I", blob[4:8])
    manifest_iv = blob[8:24]
    manifest_hmac = blob[24:88]

    print("\n[outer]")
    print(f"  magic         : {magic!r} ({'OK' if magic == MAGIC else 'BAD'})")
    print(f"  manifest_sz   : {manifest_sz}")
    print(f"  manifest_iv   : {fmt_hex(manifest_iv)}")
    if full_hex:
        print(f"  manifest_hmac : {fmt_hex(manifest_hmac)}")
    else:
        print(f"  manifest_hmac : {hex_preview(manifest_hmac, head=16)}")

    if magic != MAGIC:
        sys.exit("bad magic — not a PEL2 bundle")

    if manifest_sz < 8 or (manifest_sz - 8) % SEG_ENTRY_LEN != 0:
        sys.exit(f"malformed manifest_sz {manifest_sz}")
    inferred_segs = (manifest_sz - 8) // SEG_ENTRY_LEN
    if inferred_segs == 0 or inferred_segs > MAX_SEGS:
        sys.exit(f"implausible segment count from manifest_sz: {inferred_segs}")

    body_off = OUTER_HDR_LEN + manifest_sz
    if body_off > len(blob):
        sys.exit(f"file truncated: need {body_off}, have {len(blob)}")

    manifest_ct = blob[OUTER_HDR_LEN:body_off]
    segments_blob = blob[body_off:]

    print(f"  -> inferred num_segments (from manifest_sz): {inferred_segs}")
    print(f"  -> segment-ciphertext region: {len(segments_blob)} bytes "
          f"(starts at offset {body_off})")

    if key is None:
        print("\n[manifest] encrypted; pass --key KEYFILE to decode")
        return

    # --- key path: derive HMAC key, decrypt manifest, verify manifest MAC
    # over plaintext (matches firmware: LOAD -> DECRYPT -> VERIFY) ---

    if len(key) != AES_KEYLEN:
        sys.exit(f"key must be {AES_KEYLEN} bytes (got {len(key)})")
    hmac_key = hashlib.sha512(key).digest()

    manifest_pt = aes_ctr_xcrypt(key, manifest_iv, manifest_ct)

    outer_prefix = blob[0:24]            # magic || manifest_sz || manifest_iv
    expect_mac = hmac.new(
        hmac_key, outer_prefix + manifest_pt, hashlib.sha512
    ).digest()
    manifest_ok = hmac.compare_digest(expect_mac, manifest_hmac)
    print(f"\n[manifest hmac] {'OK' if manifest_ok else 'MISMATCH'}")
    if not manifest_ok:
        print(f"  expected: {fmt_hex(expect_mac)}")
        print(f"  stored  : {fmt_hex(manifest_hmac)}")
        # Continue anyway — caller still wants to see what the bundle claims.

    entry_point, num_segments = struct.unpack("<II", manifest_pt[0:8])
    print("\n[manifest]")
    print(f"  entry_point  : 0x{entry_point:08x}")
    print(f"  num_segments : {num_segments}")

    if num_segments != inferred_segs:
        print(f"  ! mismatch with inferred ({inferred_segs}) — bundle is "
              "malformed or key is wrong")

    if num_segments == 0 or num_segments > MAX_SEGS:
        sys.exit(f"bad num_segments {num_segments}")

    expected_manifest_sz = 8 + SEG_ENTRY_LEN * num_segments
    if expected_manifest_sz != manifest_sz:
        sys.exit(f"manifest_sz {manifest_sz} != 8+88*num_segments "
                 f"{expected_manifest_sz}")

    # Walk segment entries from the decrypted manifest; walk segment
    # ciphertexts back-to-back from the body, decrypt each, and verify
    # per-segment MAC over plaintext.
    cursor = 0
    total_segment_bytes = 0
    for i in range(num_segments):
        off = 8 + i * SEG_ENTRY_LEN
        paddr, size = struct.unpack("<II", manifest_pt[off:off + 8])
        iv = manifest_pt[off + 8:off + 24]
        stored_mac = manifest_pt[off + 24:off + 88]

        if cursor + size > len(segments_blob):
            print(f"  seg[{i}] truncated: need {size} at body+{cursor}, "
                  f"have {len(segments_blob) - cursor}")
            break
        seg_ct = segments_blob[cursor:cursor + size]
        cursor += size
        total_segment_bytes += size

        seg_pt = aes_ctr_xcrypt(key, iv, seg_ct)
        bind = struct.pack("<III", i, paddr, size)
        calc_mac = hmac.new(
            hmac_key, bind + iv + seg_pt, hashlib.sha512
        ).digest()
        mac_ok = hmac.compare_digest(calc_mac, stored_mac)

        print(f"\n  seg[{i}]")
        print(f"    paddr : 0x{paddr:08x}")
        print(f"    size  : {size} bytes")
        print(f"    iv    : {fmt_hex(iv)}")
        if full_hex:
            print(f"    hmac  : {fmt_hex(stored_mac)}")
        else:
            print(f"    hmac  : {hex_preview(stored_mac, head=16)}")
        print(f"    hmac check : {'OK' if mac_ok else 'MISMATCH'}")

    trailing = len(segments_blob) - cursor
    if trailing != 0:
        print(f"\n! {trailing} trailing bytes after last segment ciphertext")

    expected_total = OUTER_HDR_LEN + manifest_sz + total_segment_bytes
    print(f"\n[summary]")
    print(f"  outer header     : {OUTER_HDR_LEN} bytes")
    print(f"  manifest         : {manifest_sz} bytes")
    print(f"  segment payload  : {total_segment_bytes} bytes")
    print(f"  expected total   : {expected_total} bytes "
          f"({'matches' if expected_total == len(blob) else 'MISMATCH'} file size)")


def main():
    p = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    p.add_argument("bundle", help="path to .pel2 file")
    p.add_argument("--key",
                   help="path to 16-byte AES-128 key (enables manifest decode + HMAC verify)")
    p.add_argument("--hex", action="store_true",
                   help="print full HMACs instead of truncated previews")
    args = p.parse_args()

    key = None
    if args.key:
        with open(args.key, "rb") as f:
            key = f.read()

    parse(args.bundle, key=key, full_hex=args.hex)


if __name__ == "__main__":
    main()
