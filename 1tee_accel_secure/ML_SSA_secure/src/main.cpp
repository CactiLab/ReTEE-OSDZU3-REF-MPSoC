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
    CMD_NONE   = 0,
    CMD_INFER  = 1,
    CMD_UNLOAD = 2,
};

typedef struct __attribute__((__packed__)) {
    volatile uint8_t status;
    volatile uint8_t confidence;
    volatile int8_t person_score;
    volatile int8_t no_person_score;
    volatile uint32_t command;
    volatile uint32_t model_id;
    volatile uint32_t data_sz;
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

            if (g_infer_count % 400 == 0) {
                xil_printf("ML_SSA> inference #%u [%d,%d] conf=%d%%\r\n",
                           g_infer_count,
                           (int)output->data.int8[0], (int)output->data.int8[1],
                           (int)(ml->confidence) * 100 / 255);
            }
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
