#ifndef PROFILE_H
#define PROFILE_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void     profile_start(void);
uint32_t profile_stop(const char *label);  /* returns elapsed cycles */

/* Print all recorded entries */
void     profile_dump(void);
void     profile_clear(void);

#ifdef __cplusplus
}
#endif

#endif
