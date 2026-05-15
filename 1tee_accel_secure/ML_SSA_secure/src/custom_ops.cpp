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


#include "tensorflow/lite/c/builtin_op_data.h"
#include "tensorflow/lite/c/common.h"
#include "tensorflow/lite/kernels/kernel_util.h"
#include "tensorflow/lite/micro/kernels/conv.h"
#include "tensorflow/lite/micro/kernels/depthwise_conv.h"
#include "tensorflow/lite/micro/kernels/kernel_util.h"
#include "tensorflow/lite/micro/micro_log.h"

uint32_t g_layer_idx;

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
    uint16_t tile_oc;   /* Conv2D: 0 = no tiling, >0 = OC tile size */
    bool use_im2col;    /* DWConv: dm>1 + in_c=1 → im2col + 1×1 PW */
};

/* ================================================================
 *  Helpers
 * ================================================================ */

/*
 * Check basic HW constraints shared by both untiled and tiled paths.
 * Returns false if the layer can never run on the accelerator.
 */
static bool conv_hw_eligible(const TfLiteTensor *input,
                             const TfLiteTensor *filter) {
    if (input->type != kTfLiteInt8) return false;
    if (filter->dims->data[1] != 1 || filter->dims->data[2] != 1) return false;
    int in_h = input->dims->data[1];
    int in_w = input->dims->data[2];
    if (in_h > 48 || in_w > 48) return false;
    if (input->dims->data[3] > 256 || filter->dims->data[0] > 256) return false;
    return true;
}

static bool conv_can_accel(const TfLiteTensor *input,
                           const TfLiteTensor *filter,
                           const TfLiteTensor *output) {
    if (!conv_hw_eligible(input, filter)) return false;

    int in_c  = input->dims->data[3];
    int out_c = filter->dims->data[0];
    int out_h = output->dims->data[1];
    int out_w = output->dims->data[2];

    if (out_h * out_w * out_c > (int)ACCEL_ACT_B_SIZE) return false;

    int param_bytes = out_c * in_c + out_c * 4 + out_c * 8;
    int in_bytes = out_h * out_w * in_c;
    if (param_bytes + in_bytes > (int)ACCEL_ACT_A_SIZE) return false;

    return true;
}

/*
 * Compute the largest OC tile that fits in BRAM A alongside the full
 * input.  Returns 0 if tiling is not possible or not needed.
 */
static int conv_tile_size(const TfLiteTensor *input,
                          const TfLiteTensor *filter,
                          const TfLiteTensor *output) {
    if (!conv_hw_eligible(input, filter)) return 0;

    int in_c    = input->dims->data[3];
    int out_c   = filter->dims->data[0];
    int spatial = output->dims->data[1] * output->dims->data[2];

    int in_bytes = spatial * in_c;
    int avail = (int)ACCEL_ACT_A_SIZE - in_bytes;
    if (avail <= 0) return 0;

    /* Per output-channel cost: in_c (weights) + 4 (bias) + 8 (requant) */
    int max_oc = avail / (in_c + 12);

    /* Round down to multiple of 4 (HLS packs 4 INT8 per 32-bit word) */
    max_oc &= ~3;
    if (max_oc <= 0) return 0;

    /* Tile output must fit in BRAM B */
    if (spatial * max_oc > (int)ACCEL_ACT_B_SIZE)
        max_oc = ((int)ACCEL_ACT_B_SIZE / spatial) & ~3;
    if (max_oc <= 0) return 0;

    /* If the full layer already fits, no tiling needed */
    if (max_oc >= out_c) return 0;

    return max_oc;
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
    if (out_h * out_w * in_c > (int)ACCEL_ACT_B_SIZE) return false;

    int param_bytes = 9 * in_c + in_c * 4 + in_c * 8;
    int in_bytes = in_h * in_w * in_c;
    if (param_bytes + in_bytes > (int)ACCEL_ACT_A_SIZE) return false;

    return true;
}

/*
 * Check if a DWConv with dm>1 and in_c==1 can be converted to a 1×1
 * pointwise conv via im2col.  The kernel patches (fH×fW values per
 * output pixel) become the "input channels" of the pointwise conv.
 */
static bool dwconv_can_im2col(const TfLiteTensor *input,
                              const TfLiteTensor *filter,
                              const TfLiteTensor *output,
                              const TfLiteDepthwiseConvParams *params) {
    if (input->type != kTfLiteInt8) return false;
    if (input->dims->data[3] != 1) return false;
    if (params->depth_multiplier < 2) return false;

    int filt_h = filter->dims->data[1];
    int filt_w = filter->dims->data[2];
    int out_c  = params->depth_multiplier;
    int out_h  = output->dims->data[1];
    int out_w  = output->dims->data[2];
    int spatial = out_h * out_w;

    if (out_h > 48 || out_w > 48) return false;
    if (out_c > 256) return false;

    int padded_ic = (filt_h * filt_w + 3) & ~3;
    int param_bytes = out_c * padded_ic + out_c * 4 + out_c * 8;
    int in_bytes = spatial * padded_ic;
    if (param_bytes + in_bytes > (int)ACCEL_ACT_A_SIZE) return false;
    if (spatial * out_c > (int)ACCEL_ACT_B_SIZE) return false;

    return true;
}

/* ================================================================
 *  Conv2D — Init / Prepare / Eval
 * ================================================================ */

static bool g_accel_intr_inited = false;

static void *AccelConvInit(TfLiteContext *context, const char *buffer,
                           size_t length) {
    (void)buffer; (void)length;
    init_stock_registrations();
    if (!g_accel_intr_inited) {
        int st = accel_init_interrupts();
        xil_printf("ML_SSA> accel_init_interrupts: %s\r\n",
                   st == XST_SUCCESS ? "OK" : "FAIL");
        g_accel_intr_inited = true;
    }
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

    adata->tile_oc = 0;
    if (conv_can_accel(input, filter, output)) {
        adata->use_hw = true;
        xil_printf("ML_SSA> Conv2D HW: %dx%dx%d->%d\r\n",
                   (int)input->dims->data[1], (int)input->dims->data[2],
                   (int)filter->dims->data[3], num_channels);
    } else {
        int tile = conv_tile_size(input, filter, output);
        if (tile > 0) {
            adata->use_hw = true;
            adata->tile_oc = (uint16_t)tile;
            xil_printf("ML_SSA> Conv2D HW tiled: %dx%dx%d->%d (tile=%d)\r\n",
                       (int)input->dims->data[1], (int)input->dims->data[2],
                       (int)filter->dims->data[3], num_channels, tile);
        } else {
            xil_printf("ML_SSA> Conv2D SW: %dx%dx%d->%d (f=%dx%d)\r\n",
                       (int)input->dims->data[1], (int)input->dims->data[2],
                       (int)input->dims->data[3], num_channels,
                       (int)filter->dims->data[1], (int)filter->dims->data[2]);
        }
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

    g_layer_idx++;

    if (!adata->use_hw) {
        return g_stock_conv.invoke(context, node);
    }

    const TfLiteEvalTensor *input =
        tflite::micro::GetEvalInput(context, node, tflite::kConvInputTensor);
    const TfLiteEvalTensor *filter =
        tflite::micro::GetEvalInput(context, node, tflite::kConvWeightsTensor);
    const TfLiteEvalTensor *bias =
        tflite::micro::GetEvalInput(context, node, tflite::kConvBiasTensor);
    TfLiteEvalTensor *output =
        tflite::micro::GetEvalOutput(context, node, tflite::kConvOutputTensor);

    const int8_t *in_data    = tflite::micro::GetTensorData<int8_t>(input);
    const int8_t *filt_data  = tflite::micro::GetTensorData<int8_t>(filter);
    const int32_t *bias_data = tflite::micro::GetOptionalTensorData<int32_t>(bias);
    int8_t *out_data         = tflite::micro::GetTensorData<int8_t>(output);

    int in_h  = input->dims->data[1];
    int in_w  = input->dims->data[2];
    int in_c  = input->dims->data[3];
    int out_h = output->dims->data[1];
    int out_w = output->dims->data[2];
    int out_c = output->dims->data[3];
    int spatial = out_h * out_w;
    int out_size = spatial * out_c;

    int8_t act_min = (int8_t)data.output_activation_min;
    int8_t act_max = (int8_t)data.output_activation_max;

    int tile = adata->tile_oc ? adata->tile_oc : out_c;

    for (int oc_off = 0; oc_off < out_c; oc_off += tile) {
        int tile_sz = (oc_off + tile <= out_c) ? tile : (out_c - oc_off);

        accel_bram_layout_t bl = accel_pack_layer(
            filt_data + oc_off * in_c, tile_sz * in_c,
            bias_data + oc_off, tile_sz,
            data.per_channel_output_multiplier + oc_off,
            data.per_channel_output_shift + oc_off,
            act_min, act_max,
            in_data, spatial * in_c);

        accel_layer_desc_t desc = {};
        desc.in_h  = (uint8_t)in_h;
        desc.in_w  = (uint8_t)in_w;
        desc.in_c  = (uint16_t)in_c;
        desc.out_h = (uint8_t)out_h;
        desc.out_w = (uint8_t)out_w;
        desc.out_c = (uint16_t)tile_sz;
        desc.stride = (uint8_t)params.stride_height;
        desc.pad_same = (params.padding == kTfLitePaddingSame) ? 1 : 0;
        desc.is_depthwise = 0;
        desc.relu6_en = (act_min != -128 || act_max != 127) ? 1 : 0;
        desc.weight_base  = bl.weight_base;
        desc.bias_base    = bl.bias_base;
        desc.requant_base = bl.requant_base;
        desc.input_base   = bl.input_base;
        desc.output_base  = 0;
        desc.input_zp  = (int8_t)data.input_zero_point;
        desc.output_zp = (int8_t)data.output_zero_point;

        accel_run_layer(&desc);

        if (adata->tile_oc == 0) {
            accel_read_output(out_data, 0, out_size);
        } else {
            volatile int8_t *src = (volatile int8_t *)ACCEL_ACT_B_BASE;
            for (int p = 0; p < spatial; p++) {
                memcpy(out_data + p * out_c + oc_off,
                       (const void *)(src + p * tile_sz),
                       tile_sz);
            }
        }
    }

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

    adata->use_im2col = false;
    if (dwconv_can_accel(input, filter, output, &params)) {
        adata->use_hw = true;
        xil_printf("ML_SSA> DWConv HW: %dx%dx%d\r\n",
                   (int)input->dims->data[1], (int)input->dims->data[2],
                   (int)input->dims->data[3]);
    } else if (dwconv_can_im2col(input, filter, output, &params)) {
        adata->use_hw = true;
        adata->use_im2col = true;
        xil_printf("ML_SSA> DWConv HW im2col: %dx%dx%d dm=%d -> %dx%d\r\n",
                   (int)input->dims->data[1], (int)input->dims->data[2],
                   (int)input->dims->data[3],
                   (int)params.depth_multiplier,
                   (int)output->dims->data[1], (int)output->dims->data[2]);
    } else {
        xil_printf("ML_SSA> DWConv SW: %dx%dx%d (f=%dx%d dm=%d)\r\n",
                   (int)input->dims->data[1], (int)input->dims->data[2],
                   (int)input->dims->data[3],
                   (int)filter->dims->data[1], (int)filter->dims->data[2],
                   (int)params.depth_multiplier);
    }

    micro_ctx->DeallocateTempTfLiteTensor(filter);
    micro_ctx->DeallocateTempTfLiteTensor(input);
    micro_ctx->DeallocateTempTfLiteTensor(output);
    return kTfLiteOk;
}

/*
 * Im2col path: convert DWConv(dm>1, in_c=1) to pointwise 1×1 conv.
 *
 * Extracts strided fH×fW patches from the single-channel input,
 * transposes the DW filter to PW layout, and runs the accelerator
 * as a 1×1 conv with in_c = fH*fW (padded to mult of 4).
 */
static TfLiteStatus AccelDwConvEvalIm2col(
    TfLiteContext *context, TfLiteNode *node,
    const AccelOpData *adata,
    const TfLiteDepthwiseConvParams &params) {

    const auto &data = adata->base;

    const TfLiteEvalTensor *input = tflite::micro::GetEvalInput(
        context, node, tflite::kDepthwiseConvInputTensor);
    const TfLiteEvalTensor *filter = tflite::micro::GetEvalInput(
        context, node, tflite::kDepthwiseConvWeightsTensor);
    const TfLiteEvalTensor *bias = tflite::micro::GetEvalInput(
        context, node, tflite::kDepthwiseConvBiasTensor);
    TfLiteEvalTensor *output = tflite::micro::GetEvalOutput(
        context, node, tflite::kDepthwiseConvOutputTensor);

    const int8_t  *in_data   = tflite::micro::GetTensorData<int8_t>(input);
    const int8_t  *filt_data = tflite::micro::GetTensorData<int8_t>(filter);
    const int32_t *bias_data = tflite::micro::GetOptionalTensorData<int32_t>(bias);
    int8_t        *out_data  = tflite::micro::GetTensorData<int8_t>(output);

    int in_h   = input->dims->data[1];
    int in_w   = input->dims->data[2];
    int filt_h = filter->dims->data[1];
    int filt_w = filter->dims->data[2];
    int out_c  = params.depth_multiplier;
    int out_h  = output->dims->data[1];
    int out_w  = output->dims->data[2];
    int stride = params.stride_height;
    int spatial    = out_h * out_w;
    int kernel_sz  = filt_h * filt_w;
    int padded_ic  = (kernel_sz + 3) & ~3;

    /* SAME padding offsets */
    int pad_top  = 0, pad_left = 0;
    if (params.padding == kTfLitePaddingSame) {
        int pad_h = (out_h - 1) * stride + filt_h - in_h;
        int pad_w = (out_w - 1) * stride + filt_w - in_w;
        if (pad_h > 0) pad_top  = pad_h / 2;
        if (pad_w > 0) pad_left = pad_w / 2;
    }

    int8_t act_min  = (int8_t)data.output_activation_min;
    int8_t act_max  = (int8_t)data.output_activation_max;
    int8_t input_zp = (int8_t)data.input_zero_point;

    /* ---- Pack into BRAM A ---- */
    volatile uint8_t *bram = (volatile uint8_t *)ACCEL_ACT_A_BASE;
    uint32_t off = 0;

    /* 1. Transpose DW filter [1, fH, fW, out_c] → PW [out_c, padded_ic]
     *    Weights for padding channels (kernel_sz..padded_ic-1) stay 0. */
    uint32_t weight_base = off;
    memset((void *)(bram + off), 0, out_c * padded_ic);
    for (int oc = 0; oc < out_c; oc++)
        for (int k = 0; k < kernel_sz; k++)
            *((volatile int8_t *)(bram + off + oc * padded_ic + k)) =
                filt_data[k * out_c + oc];
    off += align4(out_c * padded_ic);

    /* 2. Biases */
    uint32_t bias_off = off;
    memcpy((void *)(bram + off), bias_data, out_c * 4);
    off += align4(out_c * 4);

    /* 3. Requant */
    uint32_t requant_off = off;
    volatile uint32_t *rdst32 = (volatile uint32_t *)(bram + off);
    uint32_t clamp_hi = ((uint8_t)act_min << 8) | ((uint8_t)act_max << 16);
    for (int c = 0; c < out_c; c++) {
        rdst32[c * 2 + 0] = (uint32_t)data.per_channel_output_multiplier[c];
        rdst32[c * 2 + 1] = (uint8_t)(31 - data.per_channel_output_shift[c]) | clamp_hi;
    }
    off += align4(out_c * 8);

    /* 4. Im2col: extract fH×fW patches directly into BRAM A.
     *    Each output pixel gets padded_ic "channels". */
    uint32_t input_off = off;
    volatile int8_t *bram_in = (volatile int8_t *)(bram + input_off);

    for (int oh = 0; oh < out_h; oh++) {
        for (int ow = 0; ow < out_w; ow++) {
            int pix = oh * out_w + ow;
            int base = pix * padded_ic;
            for (int kh = 0; kh < filt_h; kh++) {
                for (int kw = 0; kw < filt_w; kw++) {
                    int ih = oh * stride + kh - pad_top;
                    int iw = ow * stride + kw - pad_left;
                    int8_t val = (ih >= 0 && ih < in_h && iw >= 0 && iw < in_w)
                                 ? in_data[ih * in_w + iw]
                                 : input_zp;
                    bram_in[base + kh * filt_w + kw] = val;
                }
            }
            /* Padding channels: weight=0 there, so any value works.
             * Leave whatever was in BRAM — contributes 0 to accumulator. */
        }
    }

    /* ---- Run accelerator as 1×1 pointwise conv ---- */
    accel_layer_desc_t desc = {};
    desc.in_h  = (uint8_t)out_h;
    desc.in_w  = (uint8_t)out_w;
    desc.in_c  = (uint16_t)padded_ic;
    desc.out_h = (uint8_t)out_h;
    desc.out_w = (uint8_t)out_w;
    desc.out_c = (uint16_t)out_c;
    desc.stride = 1;
    desc.pad_same = 0;
    desc.is_depthwise = 0;
    desc.relu6_en = (act_min != -128 || act_max != 127) ? 1 : 0;
    desc.weight_base  = weight_base;
    desc.bias_base    = bias_off;
    desc.requant_base = requant_off;
    desc.input_base   = input_off;
    desc.output_base  = 0;
    desc.input_zp  = input_zp;
    desc.output_zp = (int8_t)data.output_zero_point;

    accel_run_layer(&desc);
    accel_read_output(out_data, 0, spatial * out_c);

    return kTfLiteOk;
}

static TfLiteStatus AccelDwConvEval(TfLiteContext *context, TfLiteNode *node) {
    const auto &params =
        *reinterpret_cast<const TfLiteDepthwiseConvParams *>(
            node->builtin_data);
    const auto *adata = static_cast<const AccelOpData *>(node->user_data);
    const auto &data = adata->base;

    g_layer_idx++;

    if (!adata->use_hw) {
        return g_stock_dwconv.invoke(context, node);
    }

    if (adata->use_im2col) {
        return AccelDwConvEvalIm2col(context, node, adata, params);
    }

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

    /* Pack weights + input into act_bram_a */
    accel_bram_layout_t bl = accel_pack_layer(
        tflite::micro::GetTensorData<int8_t>(filter), 9 * in_c,
        tflite::micro::GetOptionalTensorData<int32_t>(bias), in_c,
        data.per_channel_output_multiplier,
        data.per_channel_output_shift,
        (int8_t)data.output_activation_min,
        (int8_t)data.output_activation_max,
        in_data, in_h * in_w * in_c);

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
    desc.weight_base  = bl.weight_base;
    desc.bias_base    = bl.bias_base;
    desc.requant_base = bl.requant_base;
    desc.input_base   = bl.input_base;
    desc.output_base  = 0;
    desc.input_zp  = (int8_t)data.input_zero_point;
    desc.output_zp = (int8_t)data.output_zero_point;

    accel_run_layer(&desc);
    int out_size = out_h * out_w * in_c;
    accel_read_output(out_data, 0, out_size);

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
