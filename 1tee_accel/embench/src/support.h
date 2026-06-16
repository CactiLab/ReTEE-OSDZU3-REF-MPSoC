/* Embench support header for BYOTEE loadable benchmarks.
   Replaces the original embench-iot support.h with bare-metal equivalents. */

#ifndef SUPPORT_H
#define SUPPORT_H

#include <stdlib.h>
#include <stddef.h>
#include <math.h>

/* CPU_MHZ scales each benchmark's repeat count (LOCAL_SCALE_FACTOR * CPU_MHZ)
 * to the actual core clock so wall-clock runtime matches Embench calibration.
 * The soft-core runs at ~100 MHz (firmware reports 100 mcycle/us), so a full
 * suite run is ~3.9e9 cycles (~39 s). Note: profile.c reads mcycle as 32-bit,
 * which wraps at 2^32 (~42.9 s @100MHz); raising this much higher needs a
 * 64-bit counter (mcycleh) to avoid overflow. */
#define CPU_MHZ 100

/* Benchmarks must implement verify_benchmark */
int verify_benchmark (int result);

/* One-off data initialization */
void initialise_benchmark (void);

/* Cache warm up */
void warm_caches (int temperature);

/* Benchmark entry point */
int benchmark (void) __attribute__ ((noinline));

/* Local simplified versions of library functions */
#include "beebsc.h"

#endif /* SUPPORT_H */
