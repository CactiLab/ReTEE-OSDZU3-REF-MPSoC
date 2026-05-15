/* Embench support header for BYOTEE loadable benchmarks.
   Replaces the original embench-iot support.h with bare-metal equivalents. */

#ifndef SUPPORT_H
#define SUPPORT_H

#include <stdlib.h>
#include <stddef.h>
#include <math.h>

/* CPU_MHZ = 1 so LOCAL_SCALE_FACTOR * CPU_MHZ == LOCAL_SCALE_FACTOR */
#define CPU_MHZ 1

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
