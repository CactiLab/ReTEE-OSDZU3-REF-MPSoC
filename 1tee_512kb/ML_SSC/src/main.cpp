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

#define MODEL_WIDTH  96
#define MODEL_HEIGHT 96

/*
 * Tensor arena sized to minimum needed (136KB).
 * Placed in DDR since it exceeds BRAM capacity alongside the model.
 */
constexpr int kTensorArenaSize = 136 * 1024;
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
 * ARM side writes command and preprocessed int8 image (96x96 = 9216 bytes).
 * MicroBlaze writes back confidence and scores.
 */
typedef struct __attribute__((__packed__)) {
    volatile bool ready;
    volatile bool err;
    volatile bool complete;
    volatile uint32_t command;
    volatile uint32_t data_sz;
    volatile uint8_t confidence;      /* output: person confidence 0-255 */
    volatile int8_t person_score;     /* output: raw model score */
    volatile int8_t no_person_score;  /* output: raw model score */
    volatile int8_t data[];           /* input: preprocessed int8 96x96 */
} ml_data_t;

static shared_ocm_t* const ocm = (shared_ocm_t*)0xFFFC0000;

extern "C" int module_main() {
    xil_printf("ML_SSC> Init\r\n");

    const tflite::Model* model = tflite::GetModel(g_person_detect_model_data);
    if (!model || model->version() != TFLITE_SCHEMA_VERSION) {
        xil_printf("ML_SSC> Model error\r\n");
        return 1;
    }

    /*
     * Register INT8-only kernel variants to reduce code size.
     * Generic Add*() pulls in float+int8+int16 paths; the INT8 variants
     * link only the quantized path needed by person_detect.
     * See: tensorflow/lite/micro/examples/memory_footprint/README.md
     */
    using PersonDetectResolver = tflite::MicroMutableOpResolver<5>;
    uint8_t resolver_buf[sizeof(PersonDetectResolver)];
    PersonDetectResolver* resolver =
        new (resolver_buf) PersonDetectResolver();
    resolver->AddConv2D(tflite::Register_CONV_2D_INT8());
    resolver->AddDepthwiseConv2D(tflite::Register_DEPTHWISE_CONV_2D_INT8());
    resolver->AddReshape();
    resolver->AddSoftmax(tflite::Register_SOFTMAX_INT8());
    resolver->AddAveragePool2D(tflite::Register_AVERAGE_POOL_2D_INT8());

    /* Use placement new for interpreter to avoid heap allocation */
    uint8_t interp_buf[sizeof(tflite::MicroInterpreter)];
    tflite::MicroInterpreter* interp =
        new (interp_buf) tflite::MicroInterpreter(
            model, *resolver, tensor_arena, kTensorArenaSize);
    if (interp->AllocateTensors() != kTfLiteOk) {
        xil_printf("ML_SSC> AllocateTensors failed\r\n");
        return 1;
    }

    TfLiteTensor* input  = interp->input(0);
    TfLiteTensor* output = interp->output(0);
    if (!input || !output) {
        xil_printf("ML_SSC> Tensor error\r\n");
        return 1;
    }

    volatile ml_data_t* ml = (volatile ml_data_t*)ocm->data;
    ml->command = CMD_NONE;
    ml->ready = true;
    xil_printf("ML_SSC> Ready\r\n");

    while (1) {
        if (ml->command == CMD_NONE)
            continue;

        ml->ready = false;
        ml->complete = false;
        ml->err = false;

        switch (ml->command) {
        case CMD_INFER: {
            /* Copy preprocessed int8 data from OCM to input tensor */
            memcpy(input->data.int8, (const void*)ml->data,
                   MODEL_WIDTH * MODEL_HEIGHT);

            if (interp->Invoke() != kTfLiteOk) {
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
