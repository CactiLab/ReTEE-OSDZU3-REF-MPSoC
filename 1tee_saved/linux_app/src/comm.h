#include <stdbool.h>
#include <stdint.h>

typedef struct __attribute__((__packed__)) {
    volatile bool mb_to_arm_flag;
    volatile bool arm_to_mb_flag;
    volatile bool ready;
    volatile bool executing;
    volatile uint32_t command;
    volatile uint32_t data[50000];
} shared_ocm_t;