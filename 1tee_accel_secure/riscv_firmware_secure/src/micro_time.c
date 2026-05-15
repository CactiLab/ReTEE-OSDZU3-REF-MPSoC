#include "micro_time.h"

uint32_t mcycle_now(void) {
    uint32_t cycles;
    __asm__ volatile("csrr %0, mcycle" : "=r"(cycles));
    return cycles;
}
