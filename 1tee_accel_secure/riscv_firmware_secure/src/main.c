/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <xil_printf.h>
#include <elf.h>

#include "platform.h"
#include "aes.h"
#include "sha512.h"
#include "micro_time.h"

extern char _MODULE_BASE;
extern char _MODULE_SIZE;

/* AES-128 key. Placeholder bytes are patched post-build by pack_elf.py.
 * Non-zero initializer forces it into .data (loaded) rather than .bss (NOLOAD)
 * so the section is present in the firmware ELF and can be patched. */
__attribute__((used))
volatile uint8_t aes_key[AES_KEYLEN] = {
    0xAE, 0x5C, 0x00, 0xDE, 0xCA, 0xFE, 0xBA, 0xD0,
    0xA1, 0x12, 0xDE, 0xCA, 0xFE, 0xC0, 0xFF, 0xEE,
};

typedef struct __attribute__((__packed__)) {
    volatile bool mb_to_arm_flag;
    volatile bool arm_to_mb_flag;
    volatile bool ready;
    volatile bool executing;
    volatile uint32_t command;
    volatile uint32_t data[];
} shared_ocm_t;

#define SHARED_ADDR 0xFFFC0000
#define SHARED_OCM ((shared_ocm_t*) SHARED_ADDR)

#define CMD_LOAD_ELF        0x44414F4C
#define CMD_LOAD_ELF_DRAM   0x44524D4C

/* PEL2 packed-ELF format. See pack_elf.py for the bundle layout and the
 * authoritative description; this code is the firmware-side parser. */

#define PEL2_MAGIC          0x324C4550U      /* "PEL2" little-endian */
#define PEL2_IV_LEN         AES_BLOCKLEN     /* 16 */
#define PEL2_MAC_LEN        64               /* SHA-512 */
#define PEL2_OUTER_HDR      88               /* magic+manifest_sz+iv+mac */
#define PEL2_SEG_ENTRY      88               /* one per segment in the manifest */
#define PEL2_MAX_SEGS       16
#define PEL2_MANIFEST_MAX   (8 + PEL2_SEG_ENTRY * PEL2_MAX_SEGS)

typedef struct __attribute__((__packed__)) {
    uint32_t magic;                       /* == PEL2_MAGIC */
    uint32_t manifest_sz;                 /* CTR preserves size; plain == cipher */
    uint8_t  manifest_iv[PEL2_IV_LEN];
    uint8_t  manifest_hmac[PEL2_MAC_LEN];
    uint8_t  manifest_ciphertext[];       /* AES-128-CTR */
} pel2_outer_t;

typedef struct __attribute__((__packed__)) {
    uint32_t paddr;                       /* p_paddr — load address */
    uint32_t size;                        /* p_filesz — plain == cipher size */
    uint8_t  iv[PEL2_IV_LEN];             /* per-segment CTR initial counter */
    uint8_t  hmac[PEL2_MAC_LEN];          /* HMAC over (idx||paddr||size||iv||ct) */
} pel2_seg_entry_t;                       /* sizeof == 88 */

typedef struct __attribute__((__packed__)) {
    uint32_t entry_point;                 /* ehdr.e_entry */
    uint32_t num_segments;
    pel2_seg_entry_t segments[];
} pel2_manifest_t;

/* Per-segment MAC binding prefix: fed into HMAC before the ciphertext.
 * Sealing (idx, paddr, size, iv) prevents segment swap and length tampering. */
typedef struct __attribute__((__packed__)) {
    uint32_t idx;
    uint32_t paddr;
    uint32_t size;
    uint8_t  iv[PEL2_IV_LEN];
} pel2_seg_macblob_t;                     /* sizeof == 28 */

volatile bool intr_triggered = false;

/* HMAC-SHA512 over (head || tail) using the streaming SHA-512 API, so the
 * caller doesn't need a contiguous message buffer. `key64` is the 64-byte
 * pre-derived HMAC key. Pass length 0 to skip a chunk. */
static void hmac_sha512_2chunk(const uint8_t key64[64],
                               const uint8_t *head, uint32_t head_sz,
                               const uint8_t *tail, uint32_t tail_sz,
                               uint8_t out[64]) {
    /* SHA-512 block is 128 bytes; the 64-byte key is zero-padded to 128. */
    uint8_t k_ipad[128], k_opad[128];
    for (int i = 0; i < 128; i++) {
        uint8_t kb = (i < 64) ? key64[i] : 0;
        k_ipad[i] = kb ^ 0x36;
        k_opad[i] = kb ^ 0x5C;
    }

    SHA512_State ss;
    uint8_t inner[64];

    SHA512_Init(&ss);
    SHA512_Bytes(&ss, k_ipad, 128);
    if (head_sz) SHA512_Bytes(&ss, head, (int)head_sz);
    if (tail_sz) SHA512_Bytes(&ss, tail, (int)tail_sz);
    SHA512_Final(&ss, inner);

    SHA512_Init(&ss);
    SHA512_Bytes(&ss, k_opad, 128);
    SHA512_Bytes(&ss, inner, 64);
    SHA512_Final(&ss, out);
}

static inline int ct_memcmp64(const uint8_t a[64], const uint8_t b[64]) {
    uint8_t diff = 0;
    for (int i = 0; i < 64; i++) diff |= a[i] ^ b[i];
    return diff;  /* 0 == equal */
}

/* Verify+decrypt+load a PEL2 bundle starting at `bundle`, then jump to
 * the embedded entry point. Returns -1 on validation failure (bundle is
 * not run); returns 0 only after the module has returned. */
static int load_elf_from_buf_pel2(uint8_t *bundle) {
    /* Latency accumulators. "decrypt" covers AES-CTR + HMAC-SHA512 work
     * (manifest + per-segment). "load" covers memcpy into the module
     * region. mcycle is 32-bit and wraps every ~43s at 100MHz; values
     * below are deltas across short critical sections so wrap is safe. */
    uint32_t decrypt_cycles = 0;
    uint32_t load_cycles    = 0;
    uint32_t total_start    = mcycle_now();
    uint32_t t0;

    pel2_outer_t *o = (pel2_outer_t *)bundle;

    if (o->magic != PEL2_MAGIC) {
        xil_printf("[m] PEL2: bad magic 0x%08X (want 0x%08X)\r\n",
                   o->magic, PEL2_MAGIC);
        return -1;
    }
    if (o->manifest_sz < 8
        || o->manifest_sz > PEL2_MANIFEST_MAX
        || ((o->manifest_sz - 8) % PEL2_SEG_ENTRY) != 0) {
        xil_printf("[m] PEL2: bad manifest_sz %u\r\n", o->manifest_sz);
        return -1;
    }

    /* Derive HMAC key = SHA-512(aes_key) — matches the packer. */
    SHA512_State ss;
    uint8_t hmac_key[64];
    SHA512_Init(&ss);
    SHA512_Bytes(&ss, (const void *)aes_key, AES_KEYLEN);
    SHA512_Final(&ss, hmac_key);

    /* Verify manifest HMAC: head = first 24 bytes of bundle
     * (magic || manifest_sz || manifest_iv); tail = manifest ciphertext. */
    uint8_t mac[64];
    t0 = mcycle_now();
    hmac_sha512_2chunk(hmac_key, bundle, 24,
                       o->manifest_ciphertext, o->manifest_sz, mac);
    decrypt_cycles += mcycle_now() - t0;
    if (ct_memcmp64(mac, o->manifest_hmac) != 0) {
        xil_printf("[m] PEL2: manifest HMAC mismatch\r\n");
        return -1;
    }

    /* Decrypt the manifest in place (CTR is symmetric). */
    struct AES_ctx ctx;
    t0 = mcycle_now();
    AES_init_ctx_iv(&ctx, (const uint8_t *)aes_key, o->manifest_iv);
    AES_CTR_xcrypt_buffer(&ctx, o->manifest_ciphertext, o->manifest_sz);
    decrypt_cycles += mcycle_now() - t0;

    pel2_manifest_t *m = (pel2_manifest_t *)o->manifest_ciphertext;
    if (m->num_segments == 0 || m->num_segments > PEL2_MAX_SEGS) {
        xil_printf("[m] PEL2: bad num_segments %u\r\n", m->num_segments);
        return -1;
    }
    if (8u + (uint32_t)PEL2_SEG_ENTRY * m->num_segments != o->manifest_sz) {
        xil_printf("[m] PEL2: manifest_sz/num_segments mismatch\r\n");
        return -1;
    }

    /* Bounds-check every segment against the module region defined by the
     * linker. Prevents a tampered (but authenticated under another key?)
     * manifest from overwriting the firmware itself. */
    uintptr_t module_lo = (uintptr_t)&_MODULE_BASE;
    uintptr_t module_sz = (uintptr_t)&_MODULE_SIZE;
    uintptr_t module_hi = module_lo + module_sz;
    for (uint32_t i = 0; i < m->num_segments; i++) {
        uintptr_t p = (uintptr_t)m->segments[i].paddr;
        uintptr_t s = (uintptr_t)m->segments[i].size;
        if (p < module_lo || p >= module_hi || s > module_hi - p) {
            xil_printf("[m] PEL2: seg[%u] 0x%08X+%u out of module "
                       "[0x%08X..0x%08X)\r\n",
                       i, (uint32_t)p, (uint32_t)s,
                       (uint32_t)module_lo, (uint32_t)module_hi);
            return -1;
        }
    }

    /* Zero the module region before loading anything into it. */
    memset(&_MODULE_BASE, 0, (size_t)&_MODULE_SIZE);

    /* Walk segment ciphertexts back-to-back (no per-segment header bytes). */
    uint8_t *cursor = bundle + PEL2_OUTER_HDR + o->manifest_sz;
    for (uint32_t i = 0; i < m->num_segments; i++) {
        uint32_t paddr = m->segments[i].paddr;
        uint32_t size  = m->segments[i].size;
        uint8_t *seg_ct = cursor;

        /* Compute per-segment MAC binding (idx, paddr, size, iv), then MAC
         * over (binding || ciphertext). */
        pel2_seg_macblob_t bind;
        bind.idx   = i;
        bind.paddr = paddr;
        bind.size  = size;
        memcpy(bind.iv, m->segments[i].iv, PEL2_IV_LEN);

        t0 = mcycle_now();
        hmac_sha512_2chunk(hmac_key,
                           (const uint8_t *)&bind, sizeof(bind),
                           seg_ct, size, mac);
        decrypt_cycles += mcycle_now() - t0;
        if (ct_memcmp64(mac, m->segments[i].hmac) != 0) {
            xil_printf("[m] PEL2: seg[%u] HMAC mismatch\r\n", i);
            return -1;
        }

        /* Decrypt the segment ciphertext in place. */
        t0 = mcycle_now();
        AES_init_ctx_iv(&ctx, (const uint8_t *)aes_key, m->segments[i].iv);
        AES_CTR_xcrypt_buffer(&ctx, seg_ct, size);
        decrypt_cycles += mcycle_now() - t0;

        xil_printf("[m] seg[%u] -> 0x%08X (%u bytes)\r\n", i, paddr, size);
        t0 = mcycle_now();
        memcpy((void *)(uintptr_t)paddr, seg_ct, size);
        load_cycles += mcycle_now() - t0;

        cursor += size;
    }

    uint32_t total_cycles = mcycle_now() - total_start;
    xil_printf("[m] PEL2: latency  decrypt=%u cyc (%u us)  load=%u cyc (%u us)"
               "  total=%u cyc (%u us)\r\n",
               decrypt_cycles, decrypt_cycles / (MCYCLES_PER_SEC / 1000000U),
               load_cycles,    load_cycles    / (MCYCLES_PER_SEC / 1000000U),
               total_cycles,   total_cycles   / (MCYCLES_PER_SEC / 1000000U));
    xil_printf("[m] PEL2: jumping to 0x%08X\r\n", m->entry_point);
    void *entrypoint = (void *)(uintptr_t)m->entry_point;

    /* Signal ready before jumping — the module may loop forever */
    SHARED_OCM->executing = 0;
    SHARED_OCM->ready = 1;

    ((void (*)(void))entrypoint)();

    memset(&_MODULE_BASE, 0, (size_t)&_MODULE_SIZE);
    return 0;
}

/* Shim keeps the existing CMD_LOAD_ELF / CMD_LOAD_ELF_DRAM call sites. */
static void load_elf_from_buf(char *data_buf) {
    (void)load_elf_from_buf_pel2((uint8_t *)data_buf);
}

int main() {
    init_platform();

    xil_printf("[riscv] Initialized.\n\r");

    int c = 0;

    while (1) {
        if (intr_triggered) {
            xil_printf("[riscv] Handling IRQ: 0x%08X.\n\r", SHARED_OCM->command);
            SHARED_OCM->executing = 1;

            uint32_t cmd = SHARED_OCM->command;

            if (cmd == CMD_LOAD_ELF) {
                /* Original: ELF in OCM data[] */
                xil_printf("[m] LOADING ELF from OCM\r\n");
                load_elf_from_buf((char*)SHARED_OCM->data);

            } else if (cmd == CMD_LOAD_ELF_DRAM) {
                /* DRAM pointer mode: data[0]=addr, data[1]=size */
                uint32_t dram_addr = SHARED_OCM->data[0];
                uint32_t elf_size  = SHARED_OCM->data[1];
                xil_printf("[m] LOADING ELF from DRAM @ 0x%08X (%d bytes)\r\n",
                           dram_addr, elf_size);
                load_elf_from_buf((char*) dram_addr);

            } else {
                xil_printf("[m] unknown cmd: 0x%08X\r\n", cmd);
            }

            intr_triggered = false;
            SHARED_OCM->executing = 0;
            SHARED_OCM->ready = 1;
        }
        msleep(10);
        if (c % 100 == 0) xil_printf("[riscv] cycle: %d\n\r", c);
        ++c;
    }

    cleanup_platform();
    return 0;
}