#ifndef MICRO_TIME_H
#define MICRO_TIME_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define MCYCLES_PER_SEC 100000000U  /* 100 MHz core clock */

uint32_t mcycle_now(void);

#ifdef __cplusplus
}
#endif

#endif
