#ifndef COMM_H
#define COMM_H

#include <stdbool.h>
#include <stdint.h>

typedef struct __attribute__((__packed__)) {
    volatile bool mb_to_arm_flag;
    volatile bool arm_to_mb_flag;
    volatile bool ready;
    volatile bool executing;
    volatile uint32_t command;
    volatile uint32_t data[];
} shared_ocm_t;

// must match ml_data_t in ML_SSA
typedef struct __attribute__((__packed__)) {
    volatile bool ready;
    volatile bool err;
    volatile bool complete;
    volatile uint32_t command;
    volatile uint32_t data_sz;
    volatile uint8_t confidence;      /* output: person confidence 0-255 */
    volatile int8_t person_score;     /* output: raw model score */
    volatile int8_t no_person_score;  /* output: raw model score */
    volatile uint32_t model_id;       /* set at init — identifies loaded model */
    volatile int8_t data[];           /* input: preprocessed int8 96x96 */
} ml_data_t;

enum ml_command {
    CMD_NONE  = 0,
    CMD_INFER = 1,
};

#define CMD_LOAD_ELF        0x44414F4C  /* "LOAD" — ELF in OCM data[] */
#define CMD_LOAD_ELF_DRAM   0x44524D4C  /* "DRML" — ELF in DRAM, pointer in OCM */
#define CMD_LOAD_SEG        0x4C534547  /* "LSEG" — load one PT_LOAD segment */
#define CMD_EXEC            0x45584543  /* "EXEC" — jump to entry point */
#define INTR_ADDR    "0x80010000"

/*
 * CMD_LOAD_ELF_DRAM protocol:
 *   data[0] = DRAM address of ELF
 *   data[1] = ELF size in bytes
 */

/* Model IDs — each SSA sets one of these at init so the host can identify it */
#define MODEL_ID_PERSON_DETECT  0x50445431  /* "PDT1" — person detection v1 */

#define MODEL_WIDTH  96
#define MODEL_HEIGHT 96
#define MODEL_INPUT_SZ (MODEL_WIDTH * MODEL_HEIGHT)

#endif
