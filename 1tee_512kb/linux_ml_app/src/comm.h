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
    volatile uint32_t data[50000];
} shared_ocm_t;

/* Must match ML_SSC ml_data_t — overlaid on shared_ocm_t.data[] */
typedef struct __attribute__((__packed__)) {
    volatile bool ready;
    volatile bool err;
    volatile bool complete;
    volatile uint32_t command;
    volatile uint32_t data_sz;
    volatile uint8_t confidence;
    volatile int8_t person_score;
    volatile int8_t no_person_score;
    volatile int8_t data[];           /* preprocessed int8 96x96 */
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
 *
 * CMD_LOAD_SEG / CMD_EXEC chunked protocol:
 *   1) For each PT_LOAD segment, host sends CMD_LOAD_SEG:
 *        data[0] = destination physical address (p_paddr)
 *        data[1] = segment size in bytes (p_filesz)
 *        data[2..] = segment data
 *      Firmware copies data to p_paddr, sets ready=1.
 *   2) After all segments, host sends CMD_EXEC:
 *        data[0] = entry point address
 *      Firmware jumps to entry point. Sets ready=1 when execution returns.
 */

#define MODEL_WIDTH  96
#define MODEL_HEIGHT 96
#define MODEL_INPUT_SZ (MODEL_WIDTH * MODEL_HEIGHT)

/* Max bytes per chunk in OCM data[] (leave room for 2 header words) */
#define CHUNK_DATA_MAX ((50000 - 2) * sizeof(uint32_t))

#endif
