#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <xil_printf.h>

#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/micro/micro_mutable_op_resolver.h"
#include "tensorflow/lite/schema/schema_generated.h"
#include "tensorflow/lite/micro/models/person_detect_model_data.h"

#define MODEL_WIDTH  96
#define MODEL_HEIGHT 96

constexpr int kTensorArenaSize = 300 * 1024;

/*
 * Tensor arena in DDR — 300KB far exceeds 128KB BRAM.
 * Requires .ddr_bss section mapped to psu_ddr_0 in lscript.ld.
 */
alignas(16) static uint8_t tensor_arena[kTensorArenaSize]
    __attribute__((section(".ddr_bss")));

/* Shared OCM structure — must match firmware definition */
typedef struct __attribute__((__packed__)) {
    volatile bool mb_to_arm_flag;
    volatile bool arm_to_mb_flag;
    volatile bool ready;
    volatile bool executing;
    volatile uint32_t command;
    volatile uint32_t data[50000];
} shared_ocm_t;

enum ml_command : uint32_t {
    CMD_NONE  = 0,
    CMD_INFER = 1,
};

/*
 * ML request/response — overlaid on ocm_memory->data[].
 * ARM side writes command, image dimensions, and YUYV data.
 * MicroBlaze writes back confidence and scores.
 *
 * Max image size ~195KB (limited by data[50000] = 200KB minus header).
 * 640x480 YUYV (614KB) won't fit — ARM side must downscale first
 * (e.g. 320x240 YUYV = 154KB fits).
 */
typedef struct __attribute__((__packed__)) {
    volatile bool ready;
    volatile bool err;
    volatile bool complete;
    volatile uint32_t command;
    volatile uint32_t input_width;
    volatile uint32_t input_height;
    volatile uint32_t data_sz;
    volatile uint8_t confidence;      /* output: person confidence 0-255 */
    volatile int8_t person_score;     /* output: raw model score */
    volatile int8_t no_person_score;  /* output: raw model score */
    volatile uint8_t data[];          /* input: YUYV image */
} ml_data_t;

static shared_ocm_t* const ocm = (shared_ocm_t*)0xFFFC0000;

/*
 * Downsample YUYV to int8 grayscale for model input.
 * Extracts Y (luminance) channel and shifts to [-128, 127].
 */
static void preprocess_yuyv(const volatile uint8_t* yuyv, int8_t* out,
                            int src_w, int src_h, int dst_w, int dst_h) {
    const float sx = (float)src_w / dst_w;
    const float sy = (float)src_h / dst_h;
    for (int y = 0; y < dst_h; y++) {
        for (int x = 0; x < dst_w; x++) {
            int si = ((int)(y * sy) * src_w + (int)(x * sx)) * 2;
            out[y * dst_w + x] = (int8_t)(yuyv[si] - 128);
        }
    }
}

extern "C" int module_main() {
    xil_printf("ML_SSC> Init\r\n");

    const tflite::Model* model = tflite::GetModel(g_person_detect_model_data);
    if (!model || model->version() != TFLITE_SCHEMA_VERSION) {
        xil_printf("ML_SSC> Model error\r\n");
        return 1;
    }

    tflite::MicroMutableOpResolver<5> resolver;
    resolver.AddConv2D();
    resolver.AddDepthwiseConv2D();
    resolver.AddReshape();
    resolver.AddSoftmax();
    resolver.AddAveragePool2D();

    tflite::MicroInterpreter interp(model, resolver, tensor_arena,
                                     kTensorArenaSize);
    if (interp.AllocateTensors() != kTfLiteOk) {
        xil_printf("ML_SSC> AllocateTensors failed\r\n");
        return 1;
    }

    TfLiteTensor* input  = interp.input(0);
    TfLiteTensor* output = interp.output(0);
    if (!input || !output) {
        xil_printf("ML_SSC> Tensor error\r\n");
        return 1;
    }

    xil_printf("ML_SSC> Ready\r\n");

    volatile ml_data_t* ml = (volatile ml_data_t*)ocm->data;

    while (1) {
        if (ml->command == CMD_NONE)
            continue;

        ml->ready = false;
        ml->complete = false;
        ml->err = false;

        switch (ml->command) {
        case CMD_INFER: {
            preprocess_yuyv(ml->data, input->data.int8,
                            ml->input_width, ml->input_height,
                            MODEL_WIDTH, MODEL_HEIGHT);

            if (interp.Invoke() != kTfLiteOk) {
                xil_printf("ML_SSC> Invoke failed\r\n");
                ml->err = true;
                break;
            }

            ml->no_person_score = output->data.int8[0];
            ml->person_score    = output->data.int8[1];
            ml->confidence      = (uint8_t)(output->data.int8[1] + 128);

            xil_printf("ML_SSC> conf=%d%%\r\n",
                       (int)(ml->confidence) * 100 / 255);
            break;
        }
        default:
            xil_printf("ML_SSC> Unknown cmd\r\n");
            break;
        }

        ml->command = CMD_NONE;
        ml->complete = true;
    }

    return 0;
}
