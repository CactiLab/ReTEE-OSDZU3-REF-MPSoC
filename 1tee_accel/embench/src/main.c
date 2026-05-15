#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <xil_printf.h>
#include "profile.h"

/* ---------- per-benchmark declarations (renamed via #define) ---------- */

#define DECLARE_BENCH(prefix)                              \
    extern void prefix##_initialise_benchmark(void);       \
    extern void prefix##_warm_caches(int);                 \
    extern int  prefix##_benchmark(void);                  \
    extern int  prefix##_verify_benchmark(int);

DECLARE_BENCH(aha_mont64)
DECLARE_BENCH(crc32)
DECLARE_BENCH(huffbench)
DECLARE_BENCH(minver)
DECLARE_BENCH(nettle_aes)
DECLARE_BENCH(nsichneu)
DECLARE_BENCH(sglib_combined)
DECLARE_BENCH(slre)
DECLARE_BENCH(statemate)

/* ---------- benchmark table ---------- */

typedef struct {
    const char *name;
    void (*initialise)(void);
    void (*warm_caches)(int);
    int  (*run)(void);
    int  (*verify)(int);
} bench_entry_t;

#define BENCH_ENTRY(tag, prefix) {                         \
    tag,                                                   \
    prefix##_initialise_benchmark,                         \
    prefix##_warm_caches,                                  \
    prefix##_benchmark,                                    \
    prefix##_verify_benchmark                              \
}

static const bench_entry_t benchmarks[] = {
    BENCH_ENTRY("aha-mont64",      aha_mont64),
    BENCH_ENTRY("crc32",           crc32),
    BENCH_ENTRY("huffbench",       huffbench),
    BENCH_ENTRY("minver",          minver),
    BENCH_ENTRY("nettle-aes",      nettle_aes),
    BENCH_ENTRY("nsichneu",        nsichneu),
    BENCH_ENTRY("sglib-combined",  sglib_combined),
    BENCH_ENTRY("slre",            slre),
    BENCH_ENTRY("statemate",       statemate),
};

#define NUM_BENCHMARKS (sizeof(benchmarks) / sizeof(benchmarks[0]))

/* ---------- OCM IPC (matches firmware) ---------- */

typedef struct __attribute__((__packed__)) {
    volatile bool     mb_to_arm_flag;
    volatile bool     arm_to_mb_flag;
    volatile bool     ready;
    volatile bool     executing;
    volatile uint32_t command;
    volatile uint32_t data[];
} shared_ocm_t;

enum {
    CMD_NONE   = 0,
    CMD_RUN    = 1,
    CMD_UNLOAD = 2,
};

typedef struct __attribute__((__packed__)) {
    volatile uint8_t  status;
    volatile uint8_t  passed;
    volatile uint8_t  total;
    volatile uint8_t  _pad;
    volatile uint32_t command;
    volatile uint32_t bench_id;
    volatile uint32_t total_cycles;
    volatile uint32_t cycles[9];   /* per-benchmark */
} bench_data_t;

#define STATUS_BUSY     0x00
#define STATUS_READY    0x01
#define STATUS_COMPLETE 0x02
#define STATUS_ERR      0x08

#define BENCH_ID_EMBENCH 0x454D4243  /* "EMBC" */

static shared_ocm_t *const ocm = (shared_ocm_t *)0xFFFC0000;

/* ---------- entry point ---------- */

int module_main(void)
{
    xil_printf("embench> Init\r\n");

    volatile bench_data_t *bd = (volatile bench_data_t *)ocm->data;
    bd->bench_id    = BENCH_ID_EMBENCH;
    bd->command     = CMD_NONE;
    bd->total       = NUM_BENCHMARKS;
    bd->status      = STATUS_READY;

    xil_printf("embench> Ready (%d benchmarks)\r\n", NUM_BENCHMARKS);
    ocm->ready = true;

    while (1) {
        if (bd->command == CMD_NONE)
            continue;

        if (bd->command == CMD_UNLOAD) {
            xil_printf("embench> Unloading\r\n");
            bd->command  = CMD_NONE;
            bd->status   = STATUS_BUSY;
            bd->bench_id = 0;
            break;
        }

        bd->status = STATUS_BUSY;

        switch (bd->command) {
        case CMD_RUN: {
            uint32_t total_cycles = 0;
            int      passed      = 0;

            xil_printf("\r\n");
            xil_printf("  %-16s %-6s %s\r\n", "BENCHMARK", "RESULT", "CYCLES");
            xil_printf("  %-16s %-6s %s\r\n", "----------------", "------", "----------");

            for (unsigned i = 0; i < NUM_BENCHMARKS; i++) {
                benchmarks[i].initialise();
                benchmarks[i].warm_caches(1);

                profile_start();
                int result = benchmarks[i].run();
                uint32_t elapsed = profile_stop(benchmarks[i].name);

                int ok = benchmarks[i].verify(result);
                if (ok) passed++;
                total_cycles += elapsed;
                bd->cycles[i] = elapsed;

                xil_printf("  %-16s %-6s %u\r\n",
                           benchmarks[i].name,
                           ok ? "PASS" : "FAIL",
                           elapsed);
            }

            xil_printf("  %-16s %-6s %s\r\n", "----------------", "------", "----------");
            xil_printf("  %-16s %d/%-3d %u\r\n",
                       "TOTAL", passed, (int)NUM_BENCHMARKS, total_cycles);
            xil_printf("\r\n");

            bd->passed       = passed;
            bd->total_cycles = total_cycles;
            break;
        }
        default:
            xil_printf("embench> Unknown cmd\r\n");
            break;
        }

        bd->command = CMD_NONE;
        bd->status  = STATUS_COMPLETE | STATUS_READY;
    }

    return 0;
}
