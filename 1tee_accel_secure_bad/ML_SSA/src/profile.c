#include "profile.h"
#include <xil_printf.h>

#define MAX_ENTRIES 32

static inline uint32_t rdcycle(void) {
    uint32_t c;
    asm volatile("csrr %0, mcycle" : "=r"(c));
    return c;
}

static uint32_t start_tick;

static struct {
    const char *label;
    uint32_t    cycles;
} entries[MAX_ENTRIES];
static int n_entries;

void profile_start(void) {
    start_tick = rdcycle();
}

uint32_t profile_stop(const char *label) {
    uint32_t elapsed = rdcycle() - start_tick;
    if (label && n_entries < MAX_ENTRIES) {
        entries[n_entries].label  = label;
        entries[n_entries].cycles = elapsed;
        n_entries++;
    }
    return elapsed;
}

void profile_dump(void) {
    uint32_t total = 0;
    xil_printf("--- profile ---\r\n");
    for (int i = 0; i < n_entries; i++) {
        xil_printf("  %-20s %u cycles\r\n", entries[i].label, entries[i].cycles);
        total += entries[i].cycles;
    }
    xil_printf("  %-20s %u cycles\r\n", "TOTAL", total);
    xil_printf("---------------\r\n");
}

void profile_clear(void) {
    n_entries = 0;
}
