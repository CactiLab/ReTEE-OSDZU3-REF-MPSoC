# Plan: input/output attestation for ML_SSA_secure with verifiable streaming through linux_ml_secure

## Context

`byotee_riscv/1tee_accel_secure/` is the RISC-V port of the BYOTEE TEE pattern. Today the pipeline runs:

camera → `linux_ml_secure` (untrusted APU host) → OCM shared memory → `ML_SSA_secure` (RISC-V soft-core TEE) → inference (TFLite-Micro w/ HW conv accel) → result back through OCM → TCP socket on port 8080 → remote client.

`riscv_firmware_secure` is the PEL2 loader (HMAC-SHA512 + AES-128-CTR verifies/decrypts the ML_SSA_secure ELF before jumping into it), so the trust root for "ML_SSA_secure is authentic" is already established at load. What is missing is any *runtime* binding between (a) the input the TEE saw, (b) the output the TEE produced, (c) a freshness challenge, and (d) the identity of the running code — and a way to carry that binding to a remote verifier without `linux_ml_secure` being able to forge or tamper.

The reference BYOTEE attestation (`app1-hw-att/mb/Attestation_software/src/main.c`) builds a chained, unkeyed BLAKE2s digest over `ro_data → data → text ∥ challenge → SSA_input → SSA_output`. The chain by itself only protects integrity inside the SoC — the digest is forgeable by anything holding the SSC code+data+input+output+challenge, so once it crosses Linux + the network, a man-in-the-middle can rewrite all four. We are going to mirror that chain layout but make the *final step keyed*, so a remote verifier with the shared key can detect tampering or substitution in transit.

## Architecture

### Trust model

- **Trusted**: `riscv_firmware_secure` (loader, verifies PEL2 bundle); `ML_SSA_secure` once loaded; the remote verifier; the shared symmetric key `K`.
- **Untrusted**: `linux_ml_secure` (passes bytes through OCM and the TCP socket — it can drop, reorder, or substitute, but cannot forge a valid tag without `K`); the camera-to-Linux path; the TCP socket.
- **Provisioned out-of-band**: shared `K[32]`; expected model binary (so the verifier can recompute `M1..M3`); preprocessing algorithm.

### Attestation chain (faithful to BYOTEE, plus a keyed envelope)

Computed inside `ML_SSA_secure` on every `CMD_INFER`, after the input is copied in and after `Invoke()` returns:

```
M1 = blake2s( .rodata bytes )                                    // includes the TFLite model
M2 = blake2s( .data bytes  ∥ M1 )
M3 = blake2s( .text bytes  ∥ challenge(8)  ∥ M2 )
M4 = blake2s( input_bytes(9216)  ∥ M3 )                          // pre-execution digest
M5 = blake2s( output_bytes(2)    ∥ M4 )                          // post-execution digest
tag = blake2s_keyed( K, M5 )                                     // RFC 7693 keyed BLAKE2s
```

`input_bytes` is the 96×96 int8 preprocessed image the TEE actually consumed (copied from `ml->data[]` into the input tensor). `output_bytes = [no_person_score, person_score]` int8 pair, in that order. `challenge` is 8 random bytes supplied by Linux per inference.

The verifier holds `K`, the model binary, and the preprocessing spec; it receives `(challenge, input_bytes, output_bytes, tag)` from the wire. It recomputes M1..M5 from public data and the values it received, then checks `blake2s_keyed(K, M5) == tag`. A mismatch means *something* — code, challenge, input, output, or tag — was tampered between the TEE and the verifier.

`M4` and `M5` are also emitted (next to the tag) for diagnostics: a successful tag check is the security gate, but the intermediate digests let the verifier pinpoint where a mismatch occurred during development.

### Code measurement timing

Match the BYOTEE reference: re-hash `.text` and `.rodata` on every inference. Note: `.rodata` contains `g_person_detect_model_data` (~475 KB flatbuffer in `person_detect_model_data.cc`). On a small soft-core this is non-trivial per-frame work. If profiling shows this dominates latency, the fallback is a one-shot `boot_measurement = blake2s(.text ∥ .rodata ∥ .data)` cached at module init and substituted for `M1..M3` in the chain — this changes only `ML_SSA_secure/src/main.cpp`, not the wire format or the verifier protocol structure.

## File-by-file changes

### 1. `ML_SSA_secure/src/blake2s.c` and `blake2s.h` — add keyed mode

Extend the existing implementation with RFC 7693 keyed init. The current `blake2s_init` (blake2s.c:135-145) sets `h[0] ^= (1UL << 24) | (1UL << 16) | BLAKE2S_OUTLEN` — i.e. depth=1, fanout=1, keylen=0, outlen=32. The keyed variant adds `(keylen << 8)` and feeds one 64-byte key block before user data.

Add:

```c
// blake2s.h
int blake2s_keyed(void *out,
                  const void *in, size_t inlen,
                  const void *key, size_t keylen);
```

Implementation: new static `blake2s_init_key(state, key, keylen)` that mirrors `blake2s_init` but XORs `(keylen << 8)` into `h[0]` and then runs one `blake2s_update`/`blake2s_compress` over the key padded to 64 bytes; then public `blake2s_keyed` driving init_key → update → final. Keep the unkeyed `blake2s()` entry point exactly as it is (M1..M5 all use it).

### 2. `ML_SSA_secure/src/lscript.ld` — export `.text` bounds

The script (lscript.ld:78-106) already exports `__rodata_start`/`__rodata_end`, `__data_start`/`_edata`. Add matching `__text_start`/`__text_end` symbols inside the `.text` block (lscript.ld:37-42):

```
.text : {
   . = ALIGN(2048);
   __text_start = .;
   *(.text)
   *(.text.*)
   *(.gnu.linkonce.t.*)
   __text_end = .;
} > dlmb_bram_if_cntlr_memory_0
```

The chain needs byte-exact `.text` start/end. `.text.init`, `.init`, `.fini`, `.ctors`, `.dtors` live outside the measured region — acceptable, matches the BYOTEE reference's "code section" semantics. Document this in a comment near the export.

### 3. `linux_ml_secure/src/comm.h` — extend the shared struct

The verifier needs `challenge`, `preExe_digest`, `postExe_digest`, `tag` available in OCM. Linux writes `challenge`; the TEE writes the rest. Insert before `data[]` (comm.h:29-38):

```c
#define ATT_DIGEST_SIZE     32
#define ATT_CHALLENGE_SIZE  8
#define ATT_KEY_SIZE        32   /* shared with verifier OOB */

typedef struct __attribute__((__packed__)) {
    volatile uint8_t status;
    volatile uint8_t confidence;
    volatile int8_t person_score;
    volatile int8_t no_person_score;
    volatile uint32_t command;
    volatile uint32_t model_id;
    volatile uint32_t data_sz;
    volatile uint8_t challenge[ATT_CHALLENGE_SIZE];        // ARM → RISC-V, per inference
    volatile uint8_t preExe_digest[ATT_DIGEST_SIZE];       // RISC-V → ARM
    volatile uint8_t postExe_digest[ATT_DIGEST_SIZE];      // RISC-V → ARM
    volatile uint8_t tag[ATT_DIGEST_SIZE];                 // RISC-V → ARM (keyed envelope)
    volatile int8_t data[];                                // unchanged role
} ml_data_t;
```

This shifts `data[]` offset from 16 → 16 + 8 + 96 = 120 bytes. **Both** `linux_ml_secure` and `ML_SSA_secure` carry this header verbatim — `ML_SSA_secure/src/main.cpp:55-64` has an independent copy of `ml_data_t`. Update both in lockstep; flag this in a comment in each.

### 4. `ML_SSA_secure/src/main.cpp` — compute the chain per inference

In `module_main()`:

- Declare the keyed-tag key as a compiled-in 32-byte constant placed in `.rodata`. Mirror the BYOTEE reference style (`AES_CBC_key` in `constants.h`); cite the same caveat that for production it must come from a HW-rooted derivation, not source.
- Extern the linker symbols: `extern uint8_t __text_start[], __text_end[], __rodata_start[], __rodata_end[], __data_start[], _edata[];`.
- Inside the `CMD_INFER` case, after `memcpy(input->data.int8, (const void*)ml->data, 9216)` (main.cpp:136-137) and before `interp->Invoke()` (main.cpp:141), compute the pre-exe chain into a local `uint8_t m[32]`:

  ```cpp
  static uint8_t m[ATT_DIGEST_SIZE];
  uint8_t challenge_local[ATT_CHALLENGE_SIZE];
  memcpy(challenge_local, (const void*)ml->challenge, ATT_CHALLENGE_SIZE);

  blake2s(m, __rodata_start, __rodata_end - __rodata_start);                              // M1
  // chain: re-hash {data ∥ M1} into m
  hash_concat_two(m, __data_start, _edata - __data_start, m, ATT_DIGEST_SIZE);            // M2
  // chain: {text ∥ challenge ∥ M2}
  hash_concat_three(m, __text_start, __text_end - __text_start,
                       challenge_local, ATT_CHALLENGE_SIZE,
                       m, ATT_DIGEST_SIZE);                                                // M3
  hash_concat_two(m, input->data.int8, 9216, m, ATT_DIGEST_SIZE);                          // M4
  memcpy((void*)ml->preExe_digest, m, ATT_DIGEST_SIZE);
  ```

  `hash_concat_two`/`hash_concat_three` are tiny static helpers: copy parts into a scratch `static uint8_t scratch[…]` then call `blake2s`. Keep the scratch buffer sized for the worst-case `.text ∥ challenge ∥ M2` concat — for a 128 KB BRAM that's ~130 KB scratch, well within the `dlmb_bram_if_cntlr_memory_0` budget (LENGTH 0x80000). If scratch budget is tight, switch the helpers to use a streaming blake2s (set `BLAKE2S_STREAM` to 1 in `blake2s.h` and use the existing `blake2s_update`/`final`); this avoids the copy entirely. **Recommend setting `BLAKE2S_STREAM=1` and writing helpers as init → update → update → update → final — avoids large scratch buffers and matches how the rodata-sized hashes will actually run.**

- After `interp->Invoke()` succeeds and `ml->no_person_score`/`ml->person_score` have been written (main.cpp:147-148), compute:

  ```cpp
  int8_t out_bytes[2] = { ml->no_person_score, ml->person_score };
  hash_concat_two(m, out_bytes, 2, m, ATT_DIGEST_SIZE);                                    // M5
  memcpy((void*)ml->postExe_digest, m, ATT_DIGEST_SIZE);
  uint8_t tag[ATT_DIGEST_SIZE];
  blake2s_keyed(tag, m, ATT_DIGEST_SIZE, att_key, ATT_KEY_SIZE);
  memcpy((void*)ml->tag, tag, ATT_DIGEST_SIZE);
  ```

- All this happens before `ml->status = STATUS_COMPLETE | STATUS_READY` (main.cpp:165) so Linux only observes the digests after they're complete.

### 5. `linux_ml_secure/src/main.c` — generate challenge, ship attestation in packet

- Add `#include <sys/random.h>` for `getrandom()`.
- Just before `ml->command = CMD_INFER` (main.c:352), fill the challenge:

  ```c
  if (getrandom((void*)ml->challenge, ATT_CHALLENGE_SIZE, 0) != ATT_CHALLENGE_SIZE) {
      /* fall back to a counter if /dev/urandom is unavailable in the image */
      static uint64_t ctr = 0; ctr++;
      memcpy((void*)ml->challenge, &ctr, ATT_CHALLENGE_SIZE);
  }
  ```

- After the `STATUS_COMPLETE` wait (main.c:355-356), read attestation fields out into local buffers (same volatile word-at-a-time pattern as the input copy at main.c:344-349; do not `memcpy` straight from OCM since it's mapped O_SYNC Device memory).
- Extend the packet layout. Current is `[confidence(1) | pscore(1) | npscore(1) | reserved(1) | YUYV(614400)]` (main.c:303-305, 367-371). New:

  ```
  offset  size       field
  0       1          confidence
  1       1          person_score (int8 reinterpreted as uint8)
  2       1          no_person_score
  3       1          reserved
  4       8          challenge
  12      32         preExe_digest
  44      32         postExe_digest
  76      32         tag
  108     9216       preprocessed_input (the bytes the TEE actually saw)
  9324    614400     YUYV frame (for display only; not attested)
  total   623724
  ```

  Bandwidth: +9316 bytes/frame (~1.5%). At 60 fps that's +560 KB/s — negligible alongside the 36 MB/s YUYV.

  Rationale for sending preprocessed bytes on the wire: the chain binds to *what the TEE saw*, not to YUYV. Without the preprocessed bytes the verifier would have to reimplement `preprocess_yuyv` bit-exactly to reconstruct the input — fragile. Sending the preprocessed bytes lets the verifier check both (i) tag-over-attested-input is correct, and (ii) preprocessed_input is consistent with the YUYV frame (optional cross-check).

  Update the packet comment at main.c:303 to document the new layout.

- Update `pkt_sz` and the `memcpy(&packet[4], frame, frame_sz)` chunk to write the new fields at the right offsets.

### 6. Verifier-side protocol (informational; no code in this repo)

For completeness, the verifier holding `K` and the model binary does, per packet:

```
1. Parse fields at fixed offsets.
2. Recompute M1..M5 from {model rodata, model data, model text, challenge,
   preprocessed_input, output_bytes}.
3. tag' = blake2s_keyed(K, M5)
4. constant_time_compare(tag', received_tag) — accept/reject.
5. (Optional) compare received preExe_digest/postExe_digest to local M4/M5 to
   localize failure during debugging.
```

A reference Python verifier using `pyblake2` or `hashlib.blake2s(..., key=K)` should fit in ~80 lines. Out of scope for this change.

## Critical files to modify

- `byotee_riscv/1tee_accel_secure/ML_SSA_secure/src/blake2s.h` — declare `blake2s_keyed`.
- `byotee_riscv/1tee_accel_secure/ML_SSA_secure/src/blake2s.c` — implement keyed init + `blake2s_keyed`; flip `BLAKE2S_STREAM` to 1 so the chain helpers can stream without large scratch buffers.
- `byotee_riscv/1tee_accel_secure/ML_SSA_secure/src/lscript.ld` — add `__text_start`/`__text_end`.
- `byotee_riscv/1tee_accel_secure/ML_SSA_secure/src/main.cpp` — extern linker symbols, hardcoded `att_key[32]`, chain in `CMD_INFER` handler, mirror the new `ml_data_t` layout (kept in sync with comm.h).
- `byotee_riscv/1tee_accel_secure/linux_ml_secure/src/comm.h` — extend `ml_data_t`, add `ATT_*` size macros.
- `byotee_riscv/1tee_accel_secure/linux_ml_secure/src/main.c` — `getrandom` for challenge, read digests/tag back, new packet layout.

## Reused utilities

- `blake2s(out, in, inlen)` — `ML_SSA_secure/src/blake2s.c:264`. Used for M1..M5. Already supports a single non-aligned-length input via streaming once `BLAKE2S_STREAM=1`.
- Existing OCM mmap path via UIO — `linux_ml_secure/src/main.c:76-121`. No changes needed; the extra fields land in the same mapped page.
- Linker symbol exports — `ML_SSA_secure/src/lscript.ld:78-106` already shows the pattern for `__rodata_start/end` and `__data_start`. Add `__text_*` in the same style.

The HMAC-SHA512 implementation in `riscv_firmware_secure/src/main.c:99-127` is **not** reused: this design intentionally stays with BLAKE2s end-to-end (one primitive, smaller code, matches the existing `blake2s.c` already sitting in `ML_SSA_secure/src/`).

## Verification

End-to-end test:

1. Build the modified `ML_SSA_secure` ELF, re-pack with `pack_elf.py` (PEL2 + AES + HMAC), boot via existing Makefile flow.
2. On the board, start `linux_ml_secure`; confirm it streams on :8080 and per-packet `pkt_sz == 623724`.
3. Run a Python verifier client that connects to :8080 and validates the tag for each frame. Confirm:
   - **Happy path**: all frames pass.
   - **In-transit tamper**: a `socat`/`tc` shim that flips a single output byte → verifier rejects all subsequent frames touched by the flip.
   - **Replay**: replaying yesterday's packet with today's connection — verifier rejects because the `challenge` won't match a freshly-issued one (this needs a verifier-side "remember last N challenges" or "verifier issues the challenge"; for this round, document as a follow-up since the challenge is currently host-generated, not verifier-generated).
4. Sanity: print `preExe_digest` and `postExe_digest` from both sides (TEE-emitted vs. verifier-recomputed) and confirm byte-for-byte agreement.
5. Performance: log preproc / infer / send latencies (main.c:380-385 already does this). The expected new cost is the chain hash on a ~475 KB rodata + 130 KB text per inference. If this pushes infer latency above the target frame budget, switch to once-at-boot measurement (see "Code measurement timing" above) — single-file change in `main.cpp`, no wire format change.

## Open follow-ups (not in scope)

- Verifier-issued challenge for true freshness (currently host-issued, so a colluding Linux + replay attacker could pin the challenge for a window).
- Move `att_key` out of source into a HW-rooted derivation (e.g., re-use the PEL2 `aes_key` path or derive via SHA-512 like `riscv_firmware_secure/src/main.c:174-177`).
- Constant-time tag compare on the verifier side.
