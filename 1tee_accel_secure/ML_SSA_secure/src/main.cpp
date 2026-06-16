#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <xil_printf.h>

#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/micro/micro_mutable_op_resolver.h"
#include "tensorflow/lite/schema/schema_generated.h"
#include "tensorflow/lite/micro/models/person_detect_model_data.h"

/* INT8-only kernel headers — smaller code than generic registrations */
#include "tensorflow/lite/micro/kernels/conv.h"
#include "tensorflow/lite/micro/kernels/depthwise_conv.h"
#include "tensorflow/lite/micro/kernels/pooling.h"
#include "tensorflow/lite/micro/kernels/softmax.h"

/* HW-accelerated Conv2D / DepthwiseConv2D kernels */
#include "custom_ops.h"

#include "blake2s.h"

/* Attestation field sizes — keep in sync with linux_ml_secure/src/comm.h */
#define ATT_DIGEST_SIZE     32
#define ATT_CHALLENGE_SIZE  8
#define ATT_KEY_SIZE        32

/* Linker-defined bounds of the measured sections. The linker script pads
 * each section's size to a multiple of 64 so blake2s() (non-streaming,
 * requires inlen % BLAKE2S_BLOCKBYTES == 0) can hash them in place. */
extern "C" {
extern uint8_t __text_start[];
extern uint8_t __text_end[];
extern uint8_t __rodata_start[];
extern uint8_t __rodata_end[];
extern uint8_t __data_start[];
extern uint8_t _edata[];
}

/* Attestation key. Placeholder — production must derive from a HW-rooted
 * secret (e.g., reuse the PEL2 key-ladder path in riscv_firmware_secure). */
alignas(4) static const uint8_t att_key[ATT_KEY_SIZE] = {
    0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
    0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
    0x10, 0x21, 0x32, 0x43, 0x54, 0x65, 0x76, 0x87,
    0x98, 0xa9, 0xba, 0xcb, 0xdc, 0xed, 0xfe, 0x0f,
};

/* Scratch for chain concatenations. The largest concat is M3 (32+8+32=72,
 * padded to 128). Sized to 128 — keep all callers within that. */
alignas(4) static uint8_t att_scratch[128];

/* Hash (a || b || c), zero-padded to the next multiple of BLAKE2S_BLOCKBYTES.
 * The verifier must mirror this padding scheme. Pass nullptr/0 for unused
 * segments. */
static void att_hash(uint8_t out[ATT_DIGEST_SIZE],
                     const void *a, size_t la,
                     const void *b, size_t lb,
                     const void *c, size_t lc) {
    size_t off = 0;
    if (la) { memcpy(att_scratch + off, a, la); off += la; }
    if (lb) { memcpy(att_scratch + off, b, lb); off += lb; }
    if (lc) { memcpy(att_scratch + off, c, lc); off += lc; }
    size_t padded = (off + (BLAKE2S_BLOCKBYTES - 1)) & ~((size_t)BLAKE2S_BLOCKBYTES - 1);
    memset(att_scratch + off, 0, padded - off);
    blake2s(out, att_scratch, padded);
}

/* Cycle counter for attestation benchmarks. Mirrors mcycle_now() from
 * riscv_firmware_secure/src/micro_time.c. mcycle is 32-bit on RV32 and
 * wraps every ~43s at 100 MHz — fine for a single inference's
 * pre/post-attestation deltas. */
#define MCYCLES_PER_US 100U   /* 100 MHz core clock -> 1 us = 100 cycles */
static inline uint32_t att_rdcycle(void) {
    uint32_t v;
    __asm__ volatile("csrr %0, mcycle" : "=r"(v));
    return v;
}

extern uint32_t g_layer_idx;
static uint32_t g_infer_count;

#define MODEL_WIDTH  96
#define MODEL_HEIGHT 96

/*
 * Tensor arena sized to minimum needed (96KB).
 */
constexpr int kTensorArenaSize = 126 * 1024;
alignas(16) static uint8_t tensor_arena[kTensorArenaSize];

/* Shared OCM structure — must match firmware definition */
typedef struct __attribute__((__packed__)) {
    volatile bool mb_to_arm_flag;
    volatile bool arm_to_mb_flag;
    volatile bool ready;
    volatile bool executing;
    volatile uint32_t command;
    volatile uint32_t data[];
} shared_ocm_t;

typedef enum : uint8_t {
    STATUS_BUSY     = 0b0000,
    STATUS_READY    = 0b0001,
    STATUS_COMPLETE = 0b0010,
    STATUS_ERR      = 0b1000,
} ml_status_t;

enum ml_command {
    CMD_NONE           = 0,
    CMD_INFER          = 1,
    CMD_UNLOAD         = 2,
    CMD_ATT_CACHE_CODE = 3,   /* payload in ml->data_sz: 0=off, 1=on */
};

/* Code attestation cache. .text and .rodata are immutable after load, so
 * their digests can be computed once and reused. Toggled by the host via
 * CMD_ATT_CACHE_CODE. .data is *not* cached — it holds mutable globals. */
static bool att_use_code_cache = false;
alignas(4) static uint8_t att_m_text_cached[ATT_DIGEST_SIZE];
alignas(4) static uint8_t att_m_rodata_cached[ATT_DIGEST_SIZE];

/* ATT_* sizes defined above (kept in sync with linux_ml_secure/src/comm.h). */

typedef struct __attribute__((__packed__)) {
    volatile uint8_t status;
    volatile uint8_t confidence;
    volatile int8_t person_score;
    volatile int8_t no_person_score;
    volatile uint32_t command;
    volatile uint32_t model_id;
    volatile uint32_t data_sz;
    volatile uint8_t challenge[ATT_CHALLENGE_SIZE];        /* ARM -> RISC-V */
    volatile uint8_t preExe_digest[ATT_DIGEST_SIZE];       /* RISC-V -> ARM (M4) */
    volatile uint8_t postExe_digest[ATT_DIGEST_SIZE];      /* RISC-V -> ARM (M5) */
    volatile uint8_t tag[ATT_DIGEST_SIZE];                 /* RISC-V -> ARM (prefix-MAC) */
    volatile int8_t data[];
} ml_data_t;

#define MODEL_ID_PERSON_DETECT  0x50445431  /* "PDT1" */

static shared_ocm_t* const ocm = (shared_ocm_t*)0xFFFC0000;

extern "C" int module_main() {
    xil_printf("ML_SSA> Init\r\n");

    const tflite::Model* model = tflite::GetModel(g_person_detect_model_data);
    if (!model || model->version() != TFLITE_SCHEMA_VERSION) {
        xil_printf("ML_SSA> Model error\r\n");
        return 1;
    }

    /*
     * Register accelerated Conv2D / DepthwiseConv2D kernels.
     * Layers that fit the HW constraints run on the BRAM-based
     * convolution accelerator; others fall back to INT8 software.
     * Remaining ops (Reshape, Softmax, AvgPool) use stock INT8 kernels.
     */
    using PersonDetectResolver = tflite::MicroMutableOpResolver<5>;
    uint8_t resolver_buf[sizeof(PersonDetectResolver)];
    PersonDetectResolver* resolver =
        new (resolver_buf) PersonDetectResolver();
    resolver->AddConv2D(Register_CONV_2D_ACCEL());
    resolver->AddDepthwiseConv2D(Register_DEPTHWISE_CONV_2D_ACCEL());
    resolver->AddReshape();
    resolver->AddSoftmax(tflite::Register_SOFTMAX_INT8());
    resolver->AddAveragePool2D(tflite::Register_AVERAGE_POOL_2D_INT8());

    /* Use placement new for interpreter to avoid heap allocation */
    uint8_t interp_buf[sizeof(tflite::MicroInterpreter)];
    tflite::MicroInterpreter* interp =
        new (interp_buf) tflite::MicroInterpreter(
            model, *resolver, tensor_arena, kTensorArenaSize);
    if (interp->AllocateTensors() != kTfLiteOk) {
        xil_printf("ML_SSA> AllocateTensors failed\r\n");
        return 1;
    }

    TfLiteTensor* input  = interp->input(0);
    TfLiteTensor* output = interp->output(0);
    if (!input || !output) {
        xil_printf("ML_SSA> Tensor error\r\n");
        return 1;
    }

    volatile ml_data_t* ml = (volatile ml_data_t*)ocm->data;
    ml->model_id = MODEL_ID_PERSON_DETECT;
    ml->command = CMD_NONE;
    ml->status = STATUS_READY;
    xil_printf("ML_SSA> Ready\r\n");

    ocm->ready = true;
    while (1) {
        if (ml->command == CMD_NONE) {
            continue;
        }

        if (ml->command == CMD_UNLOAD) {
            xil_printf("ML_SSA> Unloading\r\n");
            ml->command = CMD_NONE;
            ml->status = STATUS_BUSY;
            ml->model_id = 0;
            break;
        }

        ml->status = STATUS_BUSY;

        switch (ml->command) {
        case CMD_INFER: {
            memcpy(input->data.int8, (const void*)ml->data,
                   MODEL_WIDTH * MODEL_HEIGHT);

            /* Snapshot the host-supplied challenge before computing M3. */
            alignas(4) uint8_t challenge_local[ATT_CHALLENGE_SIZE];
            for (size_t i = 0; i < ATT_CHALLENGE_SIZE; i++)
                challenge_local[i] = ml->challenge[i];

            /* Per-inference BYOTEE-style attestation chain. Sections are
             * pre-hashed to 32 bytes so we never need a section-sized
             * scratch buffer (BRAM is tight):
             *   M_text   = blake2s(.text)
             *   M_rodata = blake2s(.rodata)   ( == M1 )
             *   M_data   = blake2s(.data)
             *   M_input  = blake2s(input)     (9216 bytes, already 64-aligned)
             *   M2 = blake2s(M_data    || M_rodata)            // 64 bytes
             *   M3 = blake2s(M_text    || challenge   || M2)   // 72 -> pad 128
             *   M4 = blake2s(M_input   || M3)                  // preExe_digest
             *   --- Invoke() ---
             *   M5 = blake2s(output    || M4)                  // postExe_digest
             *   tag = blake2s(att_key  || M5)                  // 64 exact (prefix-MAC)
             *
             * Each chain step zero-pads its concatenation to the next
             * multiple of 64; the verifier must mirror this padding.
             */
            alignas(4) uint8_t m_text[ATT_DIGEST_SIZE];
            alignas(4) uint8_t m_rodata[ATT_DIGEST_SIZE];
            alignas(4) uint8_t m_data[ATT_DIGEST_SIZE];
            alignas(4) uint8_t m_input[ATT_DIGEST_SIZE];
            alignas(4) uint8_t m[ATT_DIGEST_SIZE];

            uint32_t att_pre_t0 = att_rdcycle();
            if (att_use_code_cache) {
                memcpy(m_text,   att_m_text_cached,   ATT_DIGEST_SIZE);
                memcpy(m_rodata, att_m_rodata_cached, ATT_DIGEST_SIZE);
            } else {
                blake2s(m_text,   __text_start,   (size_t)(__text_end   - __text_start));
                blake2s(m_rodata, __rodata_start, (size_t)(__rodata_end - __rodata_start));
            }
            blake2s(m_data,   __data_start,   (size_t)(_edata       - __data_start));
            blake2s(m_input,  input->data.int8, (size_t)(MODEL_WIDTH * MODEL_HEIGHT));

            att_hash(m, m_data,  ATT_DIGEST_SIZE,
                        m_rodata,ATT_DIGEST_SIZE,
                        nullptr, 0);                                          // M2
            att_hash(m, m_text,        ATT_DIGEST_SIZE,
                        challenge_local, ATT_CHALLENGE_SIZE,
                        m,               ATT_DIGEST_SIZE);                    // M3
            att_hash(m, m_input, ATT_DIGEST_SIZE,
                        m,       ATT_DIGEST_SIZE,
                        nullptr, 0);                                          // M4 = preExe_digest
            for (size_t i = 0; i < ATT_DIGEST_SIZE; i++)
                ml->preExe_digest[i] = m[i];
            uint32_t att_pre_cycles = att_rdcycle() - att_pre_t0;

            g_layer_idx = 0;
            ++g_infer_count;
            if (interp->Invoke() != kTfLiteOk) {
                xil_printf("ML_SSC> Invoke failed\r\n");
                ml->status = STATUS_ERR;
                break;
            }

            ml->no_person_score = output->data.int8[0];
            ml->person_score    = output->data.int8[1];
            ml->confidence      = (uint8_t)(output->data.int8[1] + 128);

            /* output_bytes = [no_person_score, person_score], int8 pair. */
            alignas(4) uint8_t out_bytes[2] = {
                (uint8_t)output->data.int8[0],
                (uint8_t)output->data.int8[1],
            };
            uint32_t att_post_t0 = att_rdcycle();
            att_hash(m, out_bytes, sizeof(out_bytes),
                        m,         ATT_DIGEST_SIZE,
                        nullptr,   0);                                        // M5 = postExe_digest
            for (size_t i = 0; i < ATT_DIGEST_SIZE; i++)
                ml->postExe_digest[i] = m[i];

            att_hash(m, att_key, ATT_KEY_SIZE,
                        m,       ATT_DIGEST_SIZE,
                        nullptr, 0);                                          // tag
            for (size_t i = 0; i < ATT_DIGEST_SIZE; i++)
                ml->tag[i] = m[i];
            uint32_t att_post_cycles = att_rdcycle() - att_post_t0;

            if (g_infer_count % 10 == 0) {
                xil_printf("ML_SSA> inference #%u [%d,%d] conf=%d%%  "
                           "att pre=%u cyc (%u us)  post=%u cyc (%u us)\r\n",
                           g_infer_count,
                           (int)output->data.int8[0], (int)output->data.int8[1],
                           (int)(ml->confidence) * 100 / 255,
                           (unsigned)att_pre_cycles,
                           (unsigned)(att_pre_cycles  / MCYCLES_PER_US),
                           (unsigned)att_post_cycles,
                           (unsigned)(att_post_cycles / MCYCLES_PER_US));
            }
            break;
        }
        case CMD_ATT_CACHE_CODE: {
            bool want = (ml->data_sz != 0);
            if (want) {
                blake2s(att_m_text_cached,   __text_start,
                        (size_t)(__text_end   - __text_start));
                blake2s(att_m_rodata_cached, __rodata_start,
                        (size_t)(__rodata_end - __rodata_start));
            }
            att_use_code_cache = want;
            xil_printf("ML_SSA> att code cache %s\r\n", want ? "on" : "off");
            break;
        }
        default:
            xil_printf("ML_SSC> Unknown cmd\r\n");
            break;
        }

        ml->command = CMD_NONE;
        ml->status = STATUS_COMPLETE | STATUS_READY;
    }

    return 0;
}
