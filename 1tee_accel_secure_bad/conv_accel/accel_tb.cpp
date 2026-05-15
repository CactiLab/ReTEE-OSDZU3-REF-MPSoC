/*
 * accel_tb.cpp — HLS C-simulation testbench for conv_accel.
 *
 * Self-contained reference kernels (ConvPerChannel, DepthwiseConvPerChannel)
 * that replicate TFLite Micro quantized integer arithmetic, so the
 * accelerator is validated without any external TFLM dependency.
 */

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <algorithm>
#include "accel.h"

// ============================================================
//  MultiplyByQuantizedMultiplier — matches TFLM single-rounding
// ============================================================
static int32_t MultiplyByQuantizedMultiplier(int32_t x,
                                             int32_t quantized_multiplier,
                                             int shift) {
    const int64_t total_shift = 31 - shift;
    const int64_t round = static_cast<int64_t>(1) << (total_shift - 1);
    int64_t result = x * static_cast<int64_t>(quantized_multiplier) + round;
    result = result >> total_shift;
    return static_cast<int32_t>(result);
}

// ============================================================
//  Convert TFLite shift convention to HLS shift convention.
//  HLS stores total_shift directly (= 31 - tflite_shift).
// ============================================================
static int8_t tflite_shift_to_hls(int tflite_shift) {
    return (int8_t)(31 - tflite_shift);
}

// ============================================================
//  32-bit BRAM packing helpers
// ============================================================
static void bram_write8(ap_uint<32>* bram, int byte_addr, uint8_t val) {
    int wa = byte_addr >> 2;
    int bo = (byte_addr & 3) * 8;
    ap_uint<32> w = bram[wa];
    w &= ~((ap_uint<32>)0xFF << bo);
    w |= ((ap_uint<32>)val) << bo;
    bram[wa] = w;
}

static void bram_write32(ap_uint<32>* bram, int byte_addr, uint32_t val) {
    bram[byte_addr >> 2] = (ap_uint<32>)val;
}

static int8_t bram_read8(ap_uint<32>* bram, int byte_addr) {
    int wa = byte_addr >> 2;
    int bo = (byte_addr & 3) * 8;
    return (int8_t)(int)(bram[wa] >> bo) & 0xFF;
}

// ============================================================
//  Pack pointwise layer into 32-bit act_bram_a
// ============================================================
static int pack_pointwise_bram_a(
    ap_uint<32>* bram_a,
    int8_t* weights, int oc, int ic,
    int32_t* biases, int32_t* multipliers, int* shifts,
    int8_t act_min, int8_t act_max,
    int8_t* input, int input_bytes,
    int* out_weight_base, int* out_bias_base, int* out_requant_base
) {
    int off = 0;

    *out_weight_base = off;
    for (int i = 0; i < oc * ic; i++)
        bram_write8(bram_a, off + i, (uint8_t)weights[i]);
    off += oc * ic;
    off = (off + 3) & ~3;

    *out_bias_base = off;
    for (int c = 0; c < oc; c++)
        bram_write32(bram_a, off + c * 4, (uint32_t)biases[c]);
    off += oc * 4;
    off = (off + 3) & ~3;

    *out_requant_base = off;
    for (int c = 0; c < oc; c++) {
        bram_write32(bram_a, off + c * 8, (uint32_t)multipliers[c]);
        ap_uint<32> rq_word1 = 0;
        rq_word1( 7,  0) = (ap_uint<8>)(uint8_t)tflite_shift_to_hls(shifts[c]);
        rq_word1(15,  8) = (ap_uint<8>)(uint8_t)act_min;
        rq_word1(23, 16) = (ap_uint<8>)(uint8_t)act_max;
        rq_word1(31, 24) = 0;
        bram_write32(bram_a, off + c * 8 + 4, (uint32_t)rq_word1);
    }
    off += oc * 8;
    off = (off + 3) & ~3;

    int input_base = off;
    for (int i = 0; i < input_bytes; i++)
        bram_write8(bram_a, input_base + i, (uint8_t)input[i]);

    return input_base;
}

// ============================================================
//  Pack depthwise layer into 32-bit act_bram_a
// ============================================================
static int pack_depthwise_bram_a(
    ap_uint<32>* bram_a,
    int8_t* weights, int in_c,
    int32_t* biases, int32_t* multipliers, int* shifts,
    int8_t act_min, int8_t act_max,
    int8_t* input, int input_bytes,
    int* out_weight_base, int* out_bias_base, int* out_requant_base
) {
    int off = 0;

    *out_weight_base = off;
    for (int i = 0; i < 9 * in_c; i++)
        bram_write8(bram_a, off + i, (uint8_t)weights[i]);
    off += 9 * in_c;
    off = (off + 3) & ~3;

    *out_bias_base = off;
    for (int c = 0; c < in_c; c++)
        bram_write32(bram_a, off + c * 4, (uint32_t)biases[c]);
    off += in_c * 4;
    off = (off + 3) & ~3;

    *out_requant_base = off;
    for (int c = 0; c < in_c; c++) {
        bram_write32(bram_a, off + c * 8, (uint32_t)multipliers[c]);
        ap_uint<32> rq_word1 = 0;
        rq_word1( 7,  0) = (ap_uint<8>)(uint8_t)tflite_shift_to_hls(shifts[c]);
        rq_word1(15,  8) = (ap_uint<8>)(uint8_t)act_min;
        rq_word1(23, 16) = (ap_uint<8>)(uint8_t)act_max;
        rq_word1(31, 24) = 0;
        bram_write32(bram_a, off + c * 8 + 4, (uint32_t)rq_word1);
    }
    off += in_c * 8;
    off = (off + 3) & ~3;

    int input_base = off;
    for (int i = 0; i < input_bytes; i++)
        bram_write8(bram_a, input_base + i, (uint8_t)input[i]);

    return input_base;
}

// ============================================================
//  Reference implementations (replaces TFLM headers)
// ============================================================

// Compute SAME padding amounts (pad_top, pad_left).
static void compute_same_padding(int in_h, int in_w, int out_h, int out_w,
                                 int filt_h, int filt_w, int stride,
                                 int* pad_h, int* pad_w) {
    int total_h = (out_h - 1) * stride + filt_h - in_h;
    int total_w = (out_w - 1) * stride + filt_w - in_w;
    *pad_h = (total_h > 0) ? (total_h / 2) : 0;
    *pad_w = (total_w > 0) ? (total_w / 2) : 0;
}

// Reference pointwise (1x1) convolution, per-channel quantized.
// Weight layout: [out_c, 1, 1, in_c]  (NHWC / OHWI)
// Input layout:  [1, in_h, in_w, in_c]
// Output layout: [1, out_h, out_w, out_c]
static void ref_pointwise(
    int8_t* weights, int32_t* biases,
    int8_t* input, int8_t* output,
    int in_h, int in_w, int in_c,
    int out_h, int out_w, int out_c,
    int stride,
    int32_t* multipliers, int* shifts,
    int8_t input_zp, int8_t output_zp,
    int8_t act_min, int8_t act_max
) {
    int pad_h, pad_w;
    compute_same_padding(in_h, in_w, out_h, out_w, 1, 1, stride, &pad_h, &pad_w);

    for (int oh = 0; oh < out_h; oh++) {
        for (int ow = 0; ow < out_w; ow++) {
            for (int oc = 0; oc < out_c; oc++) {
                int32_t acc = biases[oc];

                // 1x1 filter: single spatial tap
                int ih = oh * stride - pad_h;
                int iw = ow * stride - pad_w;

                if (ih >= 0 && ih < in_h && iw >= 0 && iw < in_w) {
                    for (int ic = 0; ic < in_c; ic++) {
                        int32_t in_val = (int32_t)input[ih * in_w * in_c + iw * in_c + ic]
                                       - (int32_t)input_zp;
                        int32_t w_val  = (int32_t)weights[oc * in_c + ic];
                        acc += in_val * w_val;
                    }
                }

                acc = MultiplyByQuantizedMultiplier(acc, multipliers[oc], shifts[oc]);
                acc += (int32_t)output_zp;
                acc = std::max(acc, (int32_t)act_min);
                acc = std::min(acc, (int32_t)act_max);

                output[oh * out_w * out_c + ow * out_c + oc] = (int8_t)acc;
            }
        }
    }
}

// Reference depthwise 3x3 convolution, per-channel quantized.
// Weight layout: [1, 3, 3, out_c]  (depth_multiplier=1 so out_c == in_c)
// Input layout:  [1, in_h, in_w, in_c]
// Output layout: [1, out_h, out_w, out_c]
static void ref_depthwise(
    int8_t* weights, int32_t* biases,
    int8_t* input, int8_t* output,
    int in_h, int in_w, int in_c,
    int out_h, int out_w,
    int stride, int depth_multiplier,
    int32_t* multipliers, int* shifts,
    int8_t input_zp, int8_t output_zp,
    int8_t act_min, int8_t act_max
) {
    int out_c = in_c * depth_multiplier;

    int pad_h, pad_w;
    compute_same_padding(in_h, in_w, out_h, out_w, 3, 3, stride, &pad_h, &pad_w);

    for (int oh = 0; oh < out_h; oh++) {
        for (int ow = 0; ow < out_w; ow++) {
            for (int oc = 0; oc < out_c; oc++) {
                int32_t acc = biases[oc];
                int ic = oc / depth_multiplier;

                for (int kh = 0; kh < 3; kh++) {
                    for (int kw = 0; kw < 3; kw++) {
                        int ih = oh * stride + kh - pad_h;
                        int iw = ow * stride + kw - pad_w;

                        if (ih >= 0 && ih < in_h && iw >= 0 && iw < in_w) {
                            int32_t in_val = (int32_t)input[ih * in_w * in_c + iw * in_c + ic]
                                           - (int32_t)input_zp;
                            int32_t w_val  = (int32_t)weights[kh * 3 * out_c + kw * out_c + oc];
                            acc += in_val * w_val;
                        }
                    }
                }

                acc = MultiplyByQuantizedMultiplier(acc, multipliers[oc], shifts[oc]);
                acc += (int32_t)output_zp;
                acc = std::max(acc, (int32_t)act_min);
                acc = std::min(acc, (int32_t)act_max);

                output[oh * out_w * out_c + ow * out_c + oc] = (int8_t)acc;
            }
        }
    }
}

// ============================================================
//  Compare helper — reports errors, returns count.
// ============================================================
static int compare_outputs(int8_t* ref, ap_uint<32>* bram_b,
                           int output_base, int count,
                           const char* label) {
    int errors = 0;
    int max_diff = 0;
    for (int i = 0; i < count; i++) {
        int8_t dut = bram_read8(bram_b, output_base + i);
        int diff = abs((int)dut - (int)ref[i]);
        if (diff > max_diff) max_diff = diff;
        if (dut != ref[i]) {
            if (errors < 10)
                printf("  %s MISMATCH [%d]: ref=%d, dut=%d (diff=%d)\n",
                       label, i, ref[i], dut, diff);
            errors++;
        }
    }
    if (errors > 0)
        printf("  %s max_diff=%d\n", label, max_diff);
    return errors;
}

// ============================================================
//  main
// ============================================================
int main() {
    printf("=== Conv Accelerator HLS Testbench ===\n\n");

    static ap_uint<32> act_a[ACT_BUF_WORDS];
    static ap_uint<32> act_b[ACT_BUF_WORDS];

    // ---- Test 1: Pointwise conv (4x4x8 -> 4x4x16) ----
    {
        const int IH = 4, IW = 4, IC = 8;
        const int OH = 4, OW = 4, OC = 16;
        const int STRIDE = 1;

        srand(42);
        int8_t  weights[OC * IC];
        int32_t biases[OC];
        int32_t multipliers[OC];
        int     shifts[OC];
        int8_t  input[IH * IW * IC];
        int8_t  ref_output[OH * OW * OC];

        for (int i = 0; i < OC * IC; i++)
            weights[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < IH * IW * IC; i++)
            input[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < OC; i++) {
            biases[i] = rand() % 2000 - 1000;
            multipliers[i] = 1073741824 + (rand() % 1073741824);
            shifts[i] = -(rand() % 10 + 1);
        }

        memset(act_a, 0, sizeof(act_a));
        memset(act_b, 0, sizeof(act_b));

        int wb, bb, rb;
        int input_base = pack_pointwise_bram_a(
            act_a, weights, OC, IC,
            biases, multipliers, shifts, -128, 127,
            input, IH * IW * IC,
            &wb, &bb, &rb);

        ref_pointwise(weights, biases, input, ref_output,
                       IH, IW, IC, OH, OW, OC, STRIDE,
                       multipliers, shifts, 0, 0, -128, 127);

        conv_accel(
            (ap_uint<8>)IH, (ap_uint<8>)IW, (ap_uint<16>)IC,
            (ap_uint<8>)OH, (ap_uint<8>)OW, (ap_uint<16>)OC,
            (ap_uint<2>)STRIDE, (ap_uint<1>)1, (ap_uint<1>)0, (ap_uint<1>)0,
            (ap_uint<20>)wb, (ap_uint<20>)bb,
            (ap_uint<20>)input_base, (ap_uint<20>)0,
            (ap_uint<20>)rb,
            (ap_int<8>)0, (ap_int<8>)0,
            act_a, act_b);

        int errors = compare_outputs(ref_output, act_b, 0, OH * OW * OC, "PW1");
        printf("Test 1 (Pointwise 4x4x8 -> 16): %s (%d/%d errors)\n",
               errors == 0 ? "PASS" : "FAIL", errors, OH * OW * OC);
    }

    // ---- Test 2: Depthwise conv (6x6x16, stride=1, dm=1) ----
    {
        const int IH = 6, IW = 6, IC = 16;
        const int OH = 6, OW = 6;
        const int STRIDE = 1, DM = 1;

        int8_t  weights[9 * IC];
        int32_t biases[IC];
        int32_t multipliers[IC];
        int     shifts[IC];
        int8_t  input[IH * IW * IC];
        int8_t  ref_output[OH * OW * IC];

        for (int i = 0; i < 9 * IC; i++)
            weights[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < IH * IW * IC; i++)
            input[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < IC; i++) {
            biases[i] = rand() % 2000 - 1000;
            multipliers[i] = 1073741824 + (rand() % 1073741824);
            shifts[i] = -(rand() % 10 + 1);
        }

        memset(act_a, 0, sizeof(act_a));
        memset(act_b, 0, sizeof(act_b));

        int wb, bb, rb;
        int input_base = pack_depthwise_bram_a(
            act_a, weights, IC,
            biases, multipliers, shifts, -128, 127,
            input, IH * IW * IC,
            &wb, &bb, &rb);

        ref_depthwise(weights, biases, input, ref_output,
                       IH, IW, IC, OH, OW, STRIDE, DM,
                       multipliers, shifts, 0, 0, -128, 127);

        conv_accel(
            (ap_uint<8>)IH, (ap_uint<8>)IW, (ap_uint<16>)IC,
            (ap_uint<8>)OH, (ap_uint<8>)OW, (ap_uint<16>)IC,
            (ap_uint<2>)STRIDE, (ap_uint<1>)1, (ap_uint<1>)1, (ap_uint<1>)0,
            (ap_uint<20>)wb, (ap_uint<20>)bb,
            (ap_uint<20>)input_base, (ap_uint<20>)0,
            (ap_uint<20>)rb,
            (ap_int<8>)0, (ap_int<8>)0,
            act_a, act_b);

        int errors = compare_outputs(ref_output, act_b, 0, OH * OW * IC, "DW2");
        printf("Test 2 (Depthwise 6x6x16, stride=1): %s (%d/%d errors)\n",
               errors == 0 ? "PASS" : "FAIL", errors, OH * OW * IC);
    }

    // ---- Test 3: Pointwise with non-zero zero-points ----
    {
        const int IH = 4, IW = 4, IC = 16;
        const int OH = 4, OW = 4, OC = 32;
        const int STRIDE = 1;
        const int8_t INPUT_ZP = -3, OUTPUT_ZP = 5;

        int8_t  weights[OC * IC];
        int32_t biases[OC];
        int32_t multipliers[OC];
        int     shifts[OC];
        int8_t  input[IH * IW * IC];
        int8_t  ref_output[OH * OW * OC];

        for (int i = 0; i < OC * IC; i++)
            weights[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < IH * IW * IC; i++)
            input[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < OC; i++) {
            biases[i] = rand() % 2000 - 1000;
            multipliers[i] = 1073741824 + (rand() % 1073741824);
            shifts[i] = -(rand() % 10 + 1);
        }

        memset(act_a, 0, sizeof(act_a));
        memset(act_b, 0, sizeof(act_b));

        int wb, bb, rb;
        int input_base = pack_pointwise_bram_a(
            act_a, weights, OC, IC,
            biases, multipliers, shifts, -128, 127,
            input, IH * IW * IC,
            &wb, &bb, &rb);

        ref_pointwise(weights, biases, input, ref_output,
                       IH, IW, IC, OH, OW, OC, STRIDE,
                       multipliers, shifts, INPUT_ZP, OUTPUT_ZP, -128, 127);

        conv_accel(
            (ap_uint<8>)IH, (ap_uint<8>)IW, (ap_uint<16>)IC,
            (ap_uint<8>)OH, (ap_uint<8>)OW, (ap_uint<16>)OC,
            (ap_uint<2>)STRIDE, (ap_uint<1>)1, (ap_uint<1>)0, (ap_uint<1>)0,
            (ap_uint<20>)wb, (ap_uint<20>)bb,
            (ap_uint<20>)input_base, (ap_uint<20>)0,
            (ap_uint<20>)rb,
            (ap_int<8>)INPUT_ZP, (ap_int<8>)OUTPUT_ZP,
            act_a, act_b);

        int errors = compare_outputs(ref_output, act_b, 0, OH * OW * OC, "PW3");
        printf("Test 3 (Pointwise 4x4x16->32, zp=-3/5): %s (%d/%d errors)\n",
               errors == 0 ? "PASS" : "FAIL", errors, OH * OW * OC);
    }

    // ---- Test 4: Depthwise stride=2 (48x48x16 -> 24x24x16) ----
    // Regression test for hardcoded pad_top=1 bug (stride=2 needs pad_top=0)
    {
        const int IH = 48, IW = 48, IC = 16;
        const int OH = 24, OW = 24;
        const int STRIDE = 2, DM = 1;

        int8_t  *weights     = new int8_t[9 * IC];
        int32_t *biases      = new int32_t[IC];
        int32_t *multipliers = new int32_t[IC];
        int     *shifts      = new int[IC];
        int8_t  *input       = new int8_t[IH * IW * IC];
        int8_t  *ref_output  = new int8_t[OH * OW * IC];

        for (int i = 0; i < 9 * IC; i++)
            weights[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < IH * IW * IC; i++)
            input[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < IC; i++) {
            biases[i] = rand() % 2000 - 1000;
            multipliers[i] = 1073741824 + (rand() % 1073741824);
            shifts[i] = -(rand() % 10 + 1);
        }

        memset(act_a, 0, sizeof(act_a));
        memset(act_b, 0, sizeof(act_b));

        int wb, bb, rb;
        int input_base = pack_depthwise_bram_a(
            act_a, weights, IC,
            biases, multipliers, shifts, -128, 127,
            input, IH * IW * IC,
            &wb, &bb, &rb);

        ref_depthwise(weights, biases, input, ref_output,
                       IH, IW, IC, OH, OW, STRIDE, DM,
                       multipliers, shifts, 0, 0, -128, 127);

        conv_accel(
            (ap_uint<8>)IH, (ap_uint<8>)IW, (ap_uint<16>)IC,
            (ap_uint<8>)OH, (ap_uint<8>)OW, (ap_uint<16>)IC,
            (ap_uint<2>)STRIDE, (ap_uint<1>)1, (ap_uint<1>)1, (ap_uint<1>)0,
            (ap_uint<20>)wb, (ap_uint<20>)bb,
            (ap_uint<20>)input_base, (ap_uint<20>)0,
            (ap_uint<20>)rb,
            (ap_int<8>)0, (ap_int<8>)0,
            act_a, act_b);

        int errors = compare_outputs(ref_output, act_b, 0, OH * OW * IC, "DW4");
        printf("Test 4 (Depthwise 48x48x16, stride=2): %s (%d/%d errors)\n",
               errors == 0 ? "PASS" : "FAIL", errors, OH * OW * IC);

        delete[] weights; delete[] biases; delete[] multipliers;
        delete[] shifts;  delete[] input;  delete[] ref_output;
    }

    // ---- Test 5: Depthwise stride=2 (12x12x64 -> 6x6x64) ----
    // Typical MobileNet stride-2 DW layer with more channels
    {
        const int IH = 12, IW = 12, IC = 64;
        const int OH = 6, OW = 6;
        const int STRIDE = 2, DM = 1;

        int8_t  *weights     = new int8_t[9 * IC];
        int32_t *biases      = new int32_t[IC];
        int32_t *multipliers = new int32_t[IC];
        int     *shifts      = new int[IC];
        int8_t  *input       = new int8_t[IH * IW * IC];
        int8_t  *ref_output  = new int8_t[OH * OW * IC];

        for (int i = 0; i < 9 * IC; i++)
            weights[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < IH * IW * IC; i++)
            input[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < IC; i++) {
            biases[i] = rand() % 2000 - 1000;
            multipliers[i] = 1073741824 + (rand() % 1073741824);
            shifts[i] = -(rand() % 10 + 1);
        }

        memset(act_a, 0, sizeof(act_a));
        memset(act_b, 0, sizeof(act_b));

        int wb, bb, rb;
        int input_base = pack_depthwise_bram_a(
            act_a, weights, IC,
            biases, multipliers, shifts, -128, 127,
            input, IH * IW * IC,
            &wb, &bb, &rb);

        ref_depthwise(weights, biases, input, ref_output,
                       IH, IW, IC, OH, OW, STRIDE, DM,
                       multipliers, shifts, 0, 0, -128, 127);

        conv_accel(
            (ap_uint<8>)IH, (ap_uint<8>)IW, (ap_uint<16>)IC,
            (ap_uint<8>)OH, (ap_uint<8>)OW, (ap_uint<16>)IC,
            (ap_uint<2>)STRIDE, (ap_uint<1>)1, (ap_uint<1>)1, (ap_uint<1>)0,
            (ap_uint<20>)wb, (ap_uint<20>)bb,
            (ap_uint<20>)input_base, (ap_uint<20>)0,
            (ap_uint<20>)rb,
            (ap_int<8>)0, (ap_int<8>)0,
            act_a, act_b);

        int errors = compare_outputs(ref_output, act_b, 0, OH * OW * IC, "DW5");
        printf("Test 5 (Depthwise 12x12x64, stride=2): %s (%d/%d errors)\n",
               errors == 0 ? "PASS" : "FAIL", errors, OH * OW * IC);

        delete[] weights; delete[] biases; delete[] multipliers;
        delete[] shifts;  delete[] input;  delete[] ref_output;
    }

    // ---- Test 6: Depthwise stride=2 (6x6x128 -> 3x3x128) ----
    // Smallest stride-2 DW layer in MobileNet 0.25
    {
        const int IH = 6, IW = 6, IC = 128;
        const int OH = 3, OW = 3;
        const int STRIDE = 2, DM = 1;

        int8_t  *weights     = new int8_t[9 * IC];
        int32_t *biases      = new int32_t[IC];
        int32_t *multipliers = new int32_t[IC];
        int     *shifts      = new int[IC];
        int8_t  *input       = new int8_t[IH * IW * IC];
        int8_t  *ref_output  = new int8_t[OH * OW * IC];

        for (int i = 0; i < 9 * IC; i++)
            weights[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < IH * IW * IC; i++)
            input[i] = (int8_t)(rand() % 256 - 128);
        for (int i = 0; i < IC; i++) {
            biases[i] = rand() % 2000 - 1000;
            multipliers[i] = 1073741824 + (rand() % 1073741824);
            shifts[i] = -(rand() % 10 + 1);
        }

        memset(act_a, 0, sizeof(act_a));
        memset(act_b, 0, sizeof(act_b));

        int wb, bb, rb;
        int input_base = pack_depthwise_bram_a(
            act_a, weights, IC,
            biases, multipliers, shifts, -128, 127,
            input, IH * IW * IC,
            &wb, &bb, &rb);

        ref_depthwise(weights, biases, input, ref_output,
                       IH, IW, IC, OH, OW, STRIDE, DM,
                       multipliers, shifts, 0, 0, -128, 127);

        conv_accel(
            (ap_uint<8>)IH, (ap_uint<8>)IW, (ap_uint<16>)IC,
            (ap_uint<8>)OH, (ap_uint<8>)OW, (ap_uint<16>)IC,
            (ap_uint<2>)STRIDE, (ap_uint<1>)1, (ap_uint<1>)1, (ap_uint<1>)0,
            (ap_uint<20>)wb, (ap_uint<20>)bb,
            (ap_uint<20>)input_base, (ap_uint<20>)0,
            (ap_uint<20>)rb,
            (ap_int<8>)0, (ap_int<8>)0,
            act_a, act_b);

        int errors = compare_outputs(ref_output, act_b, 0, OH * OW * IC, "DW6");
        printf("Test 6 (Depthwise 6x6x128, stride=2): %s (%d/%d errors)\n",
               errors == 0 ? "PASS" : "FAIL", errors, OH * OW * IC);

        delete[] weights; delete[] biases; delete[] multipliers;
        delete[] shifts;  delete[] input;  delete[] ref_output;
    }

    printf("\n=== Done ===\n");
    return 0;
}
