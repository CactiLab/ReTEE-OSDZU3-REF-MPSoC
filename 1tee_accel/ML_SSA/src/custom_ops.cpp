/*
 * custom_ops.cpp — TFLite Micro Conv2D / DepthwiseConv2D kernels that
 * offload to the BRAM-based HLS convolution accelerator.
 *
 * Layers that fit the accelerator constraints are dispatched to hardware;
 * everything else falls through to the stock TFLM INT8 reference kernels.
 *
 * Weight BRAM (48 KB) is loaded per-layer in Eval, not preloaded at init.
 *
 * Accelerator constraints (from accel.h):
 *   - INT8 quantised (per-channel)
 *   - Conv2D: 1x1 (pointwise) only
 *   - DepthwiseConv2D: 3x3, depth_multiplier=1
 *   - Max spatial: 48x48, max channels: 256
 *   - Activation buffer: 64 KB each (input / output)
 *   - Weight buffer: 48 KB (largest layer ~36 KB)
 */

#include <stdint.h>
#include <string.h>
#include <xil_printf.h>

#include "conv_accel_driver.h"
#include "profile.h"

#include "tensorflow/lite/c/builtin_op_data.h"
#include "tensorflow/lite/c/common.h"
#include "tensorflow/lite/kernels/kernel_util.h"
#include "tensorflow/lite/micro/kernels/conv.h"
#include "tensorflow/lite/micro/kernels/depthwise_conv.h"
#include "tensorflow/lite/micro/kernels/kernel_util.h"
#include "tensorflow/lite/micro/micro_log.h"

namespace {

/* Stock TFLM registrations — used for software fallback without
 * duplicating the reference_integer_ops template instantiations. */
static TFLMRegistration g_stock_conv;
static TFLMRegistration g_stock_dwconv;
static bool g_stock_inited = false;

static void init_stock_registrations() {
    if (!g_stock_inited) {
        g_stock_conv   = tflite::Register_CONV_2D();
        g_stock_dwconv = tflite::Register_DEPTHWISE_CONV_2D();
        g_stock_inited = true;
    }
}

/* ================================================================
 *  Extended op data: standard OpDataConv + accelerator flag
 * ================================================================ */
struct AccelOpData {
    tflite::OpDataConv base;  /* stock TFLM conv data */
    bool use_hw;
};

/* ================================================================
 *  Helpers
 * ================================================================ */

static bool conv_can_accel(const TfLiteTensor *input,
                           const TfLiteTensor *filter,
                           const TfLiteTensor *output) {
    if (input->type != kTfLiteInt8) return false;

    int filt_h = filter->dims->data[1];
    int filt_w = filter->dims->data[2];
    if (filt_h != 1 || filt_w != 1) return false;

    int in_h  = input->dims->data[1];
    int in_w  = input->dims->data[2];
    int in_c  = input->dims->data[3];
    int out_c = filter->dims->data[0];
    int out_h = output->dims->data[1];
    int out_w = output->dims->data[2];

    if (in_h > 48 || in_w > 48) return false;
    if (in_c > 256 || out_c > 256) return false;
    if (in_h * in_w * in_c > (int)ACCEL_ACT_A_SIZE) return false;
    if (out_h * out_w * out_c > (int)ACCEL_ACT_B_SIZE) return false;

    /* Check weight buffer fit */
    int weight_bytes = out_c * in_c + out_c * 4 + out_c * 8;
    if (weight_bytes > (int)ACCEL_WEIGHT_SIZE) return false;

    return true;
}

static bool dwconv_can_accel(const TfLiteTensor *input,
                             const TfLiteTensor *filter,
                             const TfLiteTensor *output,
                             const TfLiteDepthwiseConvParams *params) {
    if (input->type != kTfLiteInt8) return false;
    if (params->depth_multiplier != 1) return false;

    int filt_h = filter->dims->data[1];
    int filt_w = filter->dims->data[2];
    if (filt_h != 3 || filt_w != 3) return false;

    int in_h = input->dims->data[1];
    int in_w = input->dims->data[2];
    int in_c = input->dims->data[3];
    int out_h = output->dims->data[1];
    int out_w = output->dims->data[2];

    if (in_h > 48 || in_w > 48) return false;
    if (in_c > 256) return false;
    if (in_h * in_w * in_c > (int)ACCEL_ACT_A_SIZE) return false;
    if (out_h * out_w * in_c > (int)ACCEL_ACT_B_SIZE) return false;

    int weight_bytes = 9 * in_c + in_c * 4 + in_c * 8;
    if (weight_bytes > (int)ACCEL_WEIGHT_SIZE) return false;

    return true;
}

/* ================================================================
 *  Conv2D — Init / Prepare / Eval
 * ================================================================ */

static void *AccelConvInit(TfLiteContext *context, const char *buffer,
                           size_t length) {
    (void)buffer; (void)length;
    init_stock_registrations();
    return context->AllocatePersistentBuffer(context, sizeof(AccelOpData));
}

static TfLiteStatus AccelConvPrepare(TfLiteContext *context,
                                     TfLiteNode *node) {
    auto *adata = static_cast<AccelOpData *>(node->user_data);
    auto *data = &adata->base;
    adata->use_hw = false;

    const auto &params =
        *static_cast<const TfLiteConvParams *>(node->builtin_data);
    tflite::MicroContext *micro_ctx = tflite::GetMicroContext(context);

    TfLiteTensor *output = micro_ctx->AllocateTempOutputTensor(
        node, tflite::kConvOutputTensor);
    TF_LITE_ENSURE(context, output != nullptr);
    TfLiteTensor *input = micro_ctx->AllocateTempInputTensor(
        node, tflite::kConvInputTensor);
    TF_LITE_ENSURE(context, input != nullptr);
    TfLiteTensor *filter = micro_ctx->AllocateTempInputTensor(
        node, tflite::kConvWeightsTensor);
    TF_LITE_ENSURE(context, filter != nullptr);

    const int num_channels =
        filter->dims->data[tflite::kConvQuantizedDimension];

    data->per_channel_output_multiplier = static_cast<int32_t *>(
        context->AllocatePersistentBuffer(context,
                                          num_channels * sizeof(int32_t)));
    data->per_channel_output_shift = static_cast<int32_t *>(
        context->AllocatePersistentBuffer(context,
                                          num_channels * sizeof(int32_t)));

    TF_LITE_ENSURE_STATUS(tflite::CalculateOpDataConv(
        context, node, params,
        input->dims->data[2],
        input->dims->data[1],
        filter->dims->data[2],
        filter->dims->data[1],
        output->dims->data[2],
        output->dims->data[1],
        input->type, data));

    if (conv_can_accel(input, filter, output)) {
        adata->use_hw = true;
        xil_printf("ML_SSA> Conv2D HW: %dx%dx%d->%d\r\n",
                   (int)input->dims->data[1], (int)input->dims->data[2],
                   (int)filter->dims->data[3], num_channels);
    }

    micro_ctx->DeallocateTempTfLiteTensor(filter);
    micro_ctx->DeallocateTempTfLiteTensor(input);
    micro_ctx->DeallocateTempTfLiteTensor(output);
    return kTfLiteOk;
}

static TfLiteStatus AccelConvEval(TfLiteContext *context, TfLiteNode *node) {
    const auto &params =
        *reinterpret_cast<const TfLiteConvParams *>(node->builtin_data);
    const auto *adata = static_cast<const AccelOpData *>(node->user_data);
    const auto &data = adata->base;

    if (!adata->use_hw) {
        return g_stock_conv.invoke(context, node);
    }

    /* ---- Hardware path ---- */
    const TfLiteEvalTensor *input =
        tflite::micro::GetEvalInput(context, node, tflite::kConvInputTensor);
    const TfLiteEvalTensor *filter =
        tflite::micro::GetEvalInput(context, node, tflite::kConvWeightsTensor);
    const TfLiteEvalTensor *bias =
        tflite::micro::GetEvalInput(context, node, tflite::kConvBiasTensor);
    TfLiteEvalTensor *output =
        tflite::micro::GetEvalOutput(context, node, tflite::kConvOutputTensor);

    const int8_t *in_data  = tflite::micro::GetTensorData<int8_t>(input);
    int8_t *out_data       = tflite::micro::GetTensorData<int8_t>(output);

    int in_h  = input->dims->data[1];
    int in_w  = input->dims->data[2];
    int in_c  = input->dims->data[3];
    int out_h = output->dims->data[1];
    int out_w = output->dims->data[2];
    int out_c = output->dims->data[3];

    profile_start();

    /* Pack this layer's weights into weight BRAM (reused each layer) */
    accel_weight_layout_t wl = accel_pack_layer(
        tflite::micro::GetTensorData<int8_t>(filter), out_c * in_c,
        tflite::micro::GetOptionalTensorData<int32_t>(bias), out_c,
        data.per_channel_output_multiplier,
        data.per_channel_output_shift,
        (int8_t)data.output_activation_min,
        (int8_t)data.output_activation_max);

    /* Copy input activations to act BRAM A */
    accel_load_input(in_data, 0, in_h * in_w * in_c);

    accel_layer_desc_t desc = {};
    desc.in_h  = (uint8_t)in_h;
    desc.in_w  = (uint8_t)in_w;
    desc.in_c  = (uint16_t)in_c;
    desc.out_h = (uint8_t)out_h;
    desc.out_w = (uint8_t)out_w;
    desc.out_c = (uint16_t)out_c;
    desc.stride = (uint8_t)params.stride_height;
    desc.pad_same = (params.padding == kTfLitePaddingSame) ? 1 : 0;
    desc.is_depthwise = 0;
    desc.relu6_en = (data.output_activation_min != -128 ||
                     data.output_activation_max != 127) ? 1 : 0;
    desc.weight_base  = wl.weight_base;
    desc.bias_base    = wl.bias_base;
    desc.requant_base = wl.requant_base;
    desc.input_base   = 0;
    desc.output_base  = 0;
    desc.input_zp  = (int8_t)data.input_zero_point;
    desc.output_zp = (int8_t)data.output_zero_point;

    accel_run_layer(&desc);
    accel_read_output(out_data, 0, out_h * out_w * out_c);

    profile_stop("conv2d_hw");
    return kTfLiteOk;
}

/* ================================================================
 *  DepthwiseConv2D — Init / Prepare / Eval
 * ================================================================ */

static void *AccelDwConvInit(TfLiteContext *context, const char *buffer,
                             size_t length) {
    (void)buffer; (void)length;
    init_stock_registrations();
    return context->AllocatePersistentBuffer(context, sizeof(AccelOpData));
}

static TfLiteStatus AccelDwConvPrepare(TfLiteContext *context,
                                       TfLiteNode *node) {
    auto *adata = static_cast<AccelOpData *>(node->user_data);
    auto *data = &adata->base;
    adata->use_hw = false;

    const auto &params =
        *static_cast<const TfLiteDepthwiseConvParams *>(node->builtin_data);
    tflite::MicroContext *micro_ctx = tflite::GetMicroContext(context);

    TfLiteTensor *output = micro_ctx->AllocateTempOutputTensor(
        node, tflite::kDepthwiseConvOutputTensor);
    TF_LITE_ENSURE(context, output != nullptr);
    TfLiteTensor *input = micro_ctx->AllocateTempInputTensor(
        node, tflite::kDepthwiseConvInputTensor);
    TF_LITE_ENSURE(context, input != nullptr);
    TfLiteTensor *filter = micro_ctx->AllocateTempInputTensor(
        node, tflite::kDepthwiseConvWeightsTensor);
    TF_LITE_ENSURE(context, filter != nullptr);

    const int num_channels =
        filter->dims->data[tflite::kDepthwiseConvQuantizedDimension];

    data->per_channel_output_multiplier = static_cast<int32_t *>(
        context->AllocatePersistentBuffer(context,
                                          num_channels * sizeof(int32_t)));
    data->per_channel_output_shift = static_cast<int32_t *>(
        context->AllocatePersistentBuffer(context,
                                          num_channels * sizeof(int32_t)));

    TF_LITE_ENSURE_STATUS(tflite::CalculateOpDataDepthwiseConv(
        context, node, params,
        input->dims->data[2],
        input->dims->data[1],
        filter->dims->data[2],
        filter->dims->data[1],
        output->dims->data[2],
        output->dims->data[1],
        input->type, data));

    if (dwconv_can_accel(input, filter, output, &params)) {
        adata->use_hw = true;
        xil_printf("ML_SSA> DWConv HW: %dx%dx%d\r\n",
                   (int)input->dims->data[1], (int)input->dims->data[2],
                   (int)input->dims->data[3]);
    }

    micro_ctx->DeallocateTempTfLiteTensor(filter);
    micro_ctx->DeallocateTempTfLiteTensor(input);
    micro_ctx->DeallocateTempTfLiteTensor(output);
    return kTfLiteOk;
}

static TfLiteStatus AccelDwConvEval(TfLiteContext *context, TfLiteNode *node) {
    const auto &params =
        *reinterpret_cast<const TfLiteDepthwiseConvParams *>(
            node->builtin_data);
    const auto *adata = static_cast<const AccelOpData *>(node->user_data);
    const auto &data = adata->base;

    if (!adata->use_hw) {
        return g_stock_dwconv.invoke(context, node);
    }

    /* ---- Hardware path ---- */
    const TfLiteEvalTensor *input = tflite::micro::GetEvalInput(
        context, node, tflite::kDepthwiseConvInputTensor);
    const TfLiteEvalTensor *filter = tflite::micro::GetEvalInput(
        context, node, tflite::kDepthwiseConvWeightsTensor);
    const TfLiteEvalTensor *bias = tflite::micro::GetEvalInput(
        context, node, tflite::kDepthwiseConvBiasTensor);
    TfLiteEvalTensor *output = tflite::micro::GetEvalOutput(
        context, node, tflite::kDepthwiseConvOutputTensor);

    const int8_t *in_data = tflite::micro::GetTensorData<int8_t>(input);
    int8_t *out_data      = tflite::micro::GetTensorData<int8_t>(output);

    int in_h  = input->dims->data[1];
    int in_w  = input->dims->data[2];
    int in_c  = input->dims->data[3];
    int out_h = output->dims->data[1];
    int out_w = output->dims->data[2];

    profile_start();

    /* Pack this layer's weights into weight BRAM */
    accel_weight_layout_t wl = accel_pack_layer(
        tflite::micro::GetTensorData<int8_t>(filter), 9 * in_c,
        tflite::micro::GetOptionalTensorData<int32_t>(bias), in_c,
        data.per_channel_output_multiplier,
        data.per_channel_output_shift,
        (int8_t)data.output_activation_min,
        (int8_t)data.output_activation_max);

    accel_load_input(in_data, 0, in_h * in_w * in_c);

    accel_layer_desc_t desc = {};
    desc.in_h  = (uint8_t)in_h;
    desc.in_w  = (uint8_t)in_w;
    desc.in_c  = (uint16_t)in_c;
    desc.out_h = (uint8_t)out_h;
    desc.out_w = (uint8_t)out_w;
    desc.out_c = (uint16_t)in_c;
    desc.stride = (uint8_t)params.stride_height;
    desc.pad_same = (params.padding == kTfLitePaddingSame) ? 1 : 0;
    desc.is_depthwise = 1;
    desc.relu6_en = (data.output_activation_min != -128 ||
                     data.output_activation_max != 127) ? 1 : 0;
    desc.weight_base  = wl.weight_base;
    desc.bias_base    = wl.bias_base;
    desc.requant_base = wl.requant_base;
    desc.input_base   = 0;
    desc.output_base  = 0;
    desc.input_zp  = (int8_t)data.input_zero_point;
    desc.output_zp = (int8_t)data.output_zero_point;

    accel_run_layer(&desc);
    accel_read_output(out_data, 0, out_h * out_w * in_c);

    profile_stop("dwconv_hw");
    return kTfLiteOk;
}

}  // anonymous namespace

/* ================================================================
 *  Public registration
 * ================================================================ */

TFLMRegistration Register_CONV_2D_ACCEL() {
    return tflite::micro::RegisterOp(AccelConvInit, AccelConvPrepare,
                                     AccelConvEval);
}

TFLMRegistration Register_DEPTHWISE_CONV_2D_ACCEL() {
    return tflite::micro::RegisterOp(AccelDwConvInit, AccelDwConvPrepare,
                                     AccelDwConvEval);
}
