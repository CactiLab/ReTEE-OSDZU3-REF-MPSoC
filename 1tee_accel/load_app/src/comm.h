#ifndef COMM_H
#define COMM_H

#include <stdbool.h>
#include <stdint.h>

/* ---------- shared OCM structure (firmware <-> ARM) ---------- */

typedef struct __attribute__((__packed__)) {
    volatile bool     mb_to_arm_flag;
    volatile bool     arm_to_mb_flag;
    volatile bool     ready;
    volatile bool     executing;
    volatile uint32_t command;
    volatile uint32_t data[];
} shared_ocm_t;

/* ---------- firmware loading commands ---------- */

#define CMD_LOAD_ELF_DRAM   0x44524D4C  /* "DRML" — ELF in DRAM, pointer in OCM */
/*
 * CMD_LOAD_ELF_DRAM protocol:
 *   data[0] = DRAM address of ELF
 *   data[1] = ELF size in bytes
 */

#define INTR_ADDR           "0x80010000"

/* ---------- module commands (sent via data overlay) ---------- */

enum {
    CMD_NONE   = 0,
    CMD_RUN    = 1,
    CMD_UNLOAD = 2,
};

#define STATUS_BUSY     0x00
#define STATUS_READY    0x01
#define STATUS_COMPLETE 0x02
#define STATUS_ERR      0x08

/* Generic module-data overlay — matches embench/src/main.c bench_data_t */
typedef struct __attribute__((__packed__)) {
    volatile uint8_t  status;
    volatile uint8_t  passed;
    volatile uint8_t  total;
    volatile uint8_t  _pad;
    volatile uint32_t command;
    volatile uint32_t bench_id;
    volatile uint32_t total_cycles;
    volatile uint32_t cycles[];   /* per-benchmark, variable length */
} bench_data_t;

#endif
