#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include "accel.h"

// ============================================================
//  TFLite Micro reference: MultiplyByQuantizedMultiplier
//  (single-rounding variant, from common.cc)
//
//  multiplier is Q0.31 (always in [1<<30, 1<<31-1])
//  shift is in [-31, 30]
//  total_shift = 31 - shift  (always positive)
// ============================================================
static int32_t MultiplyByQuantizedMultiplier(int32_t x,
                                             int32_t quantized_multiplier,
                                             int shift) {
    const int64_t total_shift = 31 - shift;
    const int64_t round = static_cast<int64_t>(1) << (total_shift - 1);
    int64_t result = static_cast<int64_t>(x) *
                     static_cast<int64_t>(quantized_multiplier) + round;
    result = result >> total_shift;
    return static_cast<int32_t>(result);
}

// Convert TFLite shift convention to HLS shift convention.
// HLS stores total_shift directly (= 31 - tflite_shift).
static int8_t tflite_shift_to_hls(int tflite_shift) {
    return (int8_t)(31 - tflite_shift);
}

// ============================================================
//  Golden reference: pointwise conv using TFLite requant
// ============================================================
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
    for (int oh = 0; oh < out_h; oh++) {
        for (int ow = 0; ow < out_w; ow++) {
            int ih = oh * stride;
            int iw = ow * stride;
            for (int oc = 0; oc < out_c; oc++) {
                int32_t acc = biases[oc];
                for (int ic = 0; ic < in_c; ic++) {
                    int in_addr = ih * in_w * in_c + iw * in_c + ic;
                    int w_addr  = oc * in_c + ic;
                    int32_t input_val = (int32_t)input[in_addr] - (int32_t)input_zp;
                    acc += input_val * (int32_t)weights[w_addr];
                }
                // TFLite Micro requantisation
                int32_t result = MultiplyByQuantizedMultiplier(
                    acc, multipliers[oc], shifts[oc]);
                result += (int32_t)output_zp;
                if (result < (int32_t)act_min) result = (int32_t)act_min;
                if (result > (int32_t)act_max) result = (int32_t)act_max;

                int out_addr = oh * out_w * out_c + ow * out_c + oc;
                output[out_addr] = (int8_t)result;
            }
        }
    }
}

// ============================================================
//  Golden reference: depthwise 3×3 conv using TFLite requant
// ============================================================
static void ref_depthwise(
    int8_t* weights, int32_t* biases,
    int8_t* input, int8_t* output,
    int in_h, int in_w, int in_c,
    int out_h, int out_w,
    int stride,
    int32_t* multipliers, int* shifts,
    int8_t input_zp, int8_t output_zp,
    int8_t act_min, int8_t act_max
) {
    for (int oh = 0; oh < out_h; oh++) {
        for (int ow = 0; ow < out_w; ow++) {
            for (int c = 0; c < in_c; c++) {
                int32_t acc = biases[c];
                for (int kh = 0; kh < 3; kh++) {
                    for (int kw = 0; kw < 3; kw++) {
                        int ih = oh * stride + kh - 1;
                        int iw = ow * stride + kw - 1;
                        int32_t input_val;
                        if (ih < 0 || ih >= in_h || iw < 0 || iw >= in_w) {
                            input_val = 0; // padding: (input_zp - input_zp) = 0
                        } else {
                            input_val = (int32_t)input[ih * in_w * in_c + iw * in_c + c]
                                        - (int32_t)input_zp;
                        }
                        int w_addr = kh * 3 * in_c + kw * in_c + c;
                        acc += input_val * (int32_t)weights[w_addr];
                    }
                }
                // TFLite Micro requantisation
                int32_t result = MultiplyByQuantizedMultiplier(
                    acc, multipliers[c], shifts[c]);
                result += (int32_t)output_zp;
                if (result < (int32_t)act_min) result = (int32_t)act_min;
                if (result > (int32_t)act_max) result = (int32_t)act_max;

                int out_addr = oh * out_w * in_c + ow * in_c + c;
                output[out_addr] = (int8_t)result;
            }
        }
    }
}

// ============================================================
//  Pack INT32 bias/multiplier into weight_bram (little-endian)
// ============================================================
static void pack_i32(int8_t_hls* bram, int offset, int32_t val) {
    bram[offset + 0] = (int8_t_hls)(val & 0xFF);
    bram[offset + 1] = (int8_t_hls)((val >> 8) & 0xFF);
    bram[offset + 2] = (int8_t_hls)((val >> 16) & 0xFF);
    bram[offset + 3] = (int8_t_hls)((val >> 24) & 0xFF);
}

int main() {
    printf("=== Conv Accelerator HLS Testbench ===\n\n");

    // ---- Test 1: Small pointwise conv (4×4×8 → 4×4×16) ----
    const int PW_IH = 4, PW_IW = 4, PW_IC = 8;
    const int PW_OH = 4, PW_OW = 4, PW_OC = 16;
    const int PW_STRIDE = 1;

    static int8_t_hls weight_bram[WEIGHT_BRAM_BYTES];
    static int8_t_hls act_a[ACT_BUF_BYTES];
    static int8_t_hls act_b[ACT_BUF_BYTES];

    // Randomise weights, input, biases, requant params
    srand(42);
    int8_t  ref_weights[PW_OC * PW_IC];
    int32_t ref_biases[PW_OC];
    int32_t ref_multipliers[PW_OC];  // Q0.31 format, in [1<<30, 1<<31-1]
    int     ref_shifts[PW_OC];       // TFLite convention: shift in [-31, 30]
    int8_t  ref_input[PW_IH * PW_IW * PW_IC];
    int8_t  ref_output[PW_OH * PW_OW * PW_OC];
    int8_t  dut_output[PW_OH * PW_OW * PW_OC];

    // Generate random test data
    for (int i = 0; i < PW_OC * PW_IC; i++)
        ref_weights[i] = (int8_t)(rand() % 256 - 128);
    for (int i = 0; i < PW_IH * PW_IW * PW_IC; i++)
        ref_input[i] = (int8_t)(rand() % 256 - 128);
    for (int i = 0; i < PW_OC; i++) {
        ref_biases[i] = rand() % 2000 - 1000;
        // Q0.31 multiplier in [0.5, 1.0) — typical TFLite range
        ref_multipliers[i] = 1073741824 + (rand() % 1073741824);
        // TFLite shift: typically in [-10, -1] for real models
        ref_shifts[i] = -(rand() % 10 + 1);
    }

    // Pack into BRAM layout:
    //   weight_base  = 0              : OC×IC bytes of weights
    //   bias_base    = OC*IC          : OC×4 bytes of INT32 biases
    //   requant_base = OC*IC + OC*4   : OC×8 bytes (mult[4], shift[1], act_min[1], act_max[1], pad[1])
    int pw_weight_base = 0;
    int pw_bias_base   = PW_OC * PW_IC;
    int pw_requant_base = pw_bias_base + PW_OC * 4;

    for (int i = 0; i < PW_OC * PW_IC; i++)
        weight_bram[pw_weight_base + i] = (int8_t_hls)ref_weights[i];

    for (int oc = 0; oc < PW_OC; oc++) {
        pack_i32(weight_bram, pw_bias_base + oc * 4, ref_biases[oc]);
        pack_i32(weight_bram, pw_requant_base + oc * 8, ref_multipliers[oc]);
        // Convert TFLite shift to HLS convention: hls_shift = 31 - tflite_shift
        weight_bram[pw_requant_base + oc * 8 + 4] = (int8_t_hls)tflite_shift_to_hls(ref_shifts[oc]);
        weight_bram[pw_requant_base + oc * 8 + 5] = (int8_t_hls)(-128); // act_min
        weight_bram[pw_requant_base + oc * 8 + 6] = (int8_t_hls)(127);  // act_max
        weight_bram[pw_requant_base + oc * 8 + 7] = 0; // padding
    }

    // Pack input into act_bram_a
    int pw_input_base = 0;
    int pw_output_base = 0;
    for (int i = 0; i < PW_IH * PW_IW * PW_IC; i++)
        act_a[pw_input_base + i] = (int8_t_hls)ref_input[i];

    // Run golden reference
    ref_pointwise(
        ref_weights, ref_biases,
        ref_input, ref_output,
        PW_IH, PW_IW, PW_IC,
        PW_OH, PW_OW, PW_OC,
        PW_STRIDE,
        ref_multipliers, ref_shifts,
        0, 0,   // zero points
        -128, 127  // relu6 range (effectively disabled)
    );

    // Run DUT
    conv_accel(
        (ap_uint<8>)PW_IH, (ap_uint<8>)PW_IW, (ap_uint<16>)PW_IC,
        (ap_uint<8>)PW_OH, (ap_uint<8>)PW_OW, (ap_uint<16>)PW_OC,
        (ap_uint<2>)PW_STRIDE,
        (ap_uint<1>)1,   // pad_same
        (ap_uint<1>)0,   // is_depthwise = false
        (ap_uint<1>)0,   // relu6_en = false (act_min/max set to full range)
        (ap_uint<20>)pw_weight_base,
        (ap_uint<20>)pw_bias_base,
        (ap_uint<20>)pw_input_base,
        (ap_uint<20>)pw_output_base,
        (ap_uint<20>)pw_requant_base,
        (ap_int<8>)0,    // input_zp
        (ap_int<8>)0,    // output_zp
        weight_bram, act_a, act_b
    );

    // Compare
    int pw_errors = 0;
    for (int i = 0; i < PW_OH * PW_OW * PW_OC; i++) {
        int8_t dut_val = (int8_t)(int)act_b[pw_output_base + i];
        if (dut_val != ref_output[i]) {
            if (pw_errors < 10)
                printf("  PW MISMATCH [%d]: ref=%d, dut=%d\n",
                       i, ref_output[i], dut_val);
            pw_errors++;
        }
    }
    printf("Test 1 (Pointwise 4x4x8 -> 4x4x16): %s (%d/%d errors)\n",
           pw_errors == 0 ? "PASS" : "FAIL",
           pw_errors, PW_OH * PW_OW * PW_OC);

    // ---- Test 2: Small depthwise conv (6×6×16, stride=1) ----
    const int DW_IH = 6, DW_IW = 6, DW_IC = 16;
    const int DW_OH = 6, DW_OW = 6;
    const int DW_STRIDE = 1;

    int8_t  dw_weights[9 * DW_IC];
    int32_t dw_biases[DW_IC];
    int32_t dw_multipliers[DW_IC];
    int     dw_shifts[DW_IC];
    int8_t  dw_input[DW_IH * DW_IW * DW_IC];
    int8_t  dw_ref_output[DW_OH * DW_OW * DW_IC];

    for (int i = 0; i < 9 * DW_IC; i++)
        dw_weights[i] = (int8_t)(rand() % 256 - 128);
    for (int i = 0; i < DW_IH * DW_IW * DW_IC; i++)
        dw_input[i] = (int8_t)(rand() % 256 - 128);
    for (int i = 0; i < DW_IC; i++) {
        dw_biases[i] = rand() % 2000 - 1000;
        dw_multipliers[i] = 1073741824 + (rand() % 1073741824);
        dw_shifts[i] = -(rand() % 10 + 1);
    }

    // Pack depthwise test data into BRAM (use offset past pointwise data)
    int dw_weight_base  = 4096;
    int dw_bias_base    = dw_weight_base + 9 * DW_IC;
    int dw_requant_base = dw_bias_base + DW_IC * 4;
    int dw_input_base   = 0;
    int dw_output_base  = 0;

    for (int i = 0; i < 9 * DW_IC; i++)
        weight_bram[dw_weight_base + i] = (int8_t_hls)dw_weights[i];
    for (int c = 0; c < DW_IC; c++) {
        pack_i32(weight_bram, dw_bias_base + c * 4, dw_biases[c]);
        pack_i32(weight_bram, dw_requant_base + c * 8, dw_multipliers[c]);
        weight_bram[dw_requant_base + c * 8 + 4] = (int8_t_hls)tflite_shift_to_hls(dw_shifts[c]);
        weight_bram[dw_requant_base + c * 8 + 5] = (int8_t_hls)(-128);
        weight_bram[dw_requant_base + c * 8 + 6] = (int8_t_hls)(127);
    }

    // Pack input
    for (int i = 0; i < DW_IH * DW_IW * DW_IC; i++)
        act_a[dw_input_base + i] = (int8_t_hls)dw_input[i];

    // Golden reference
    ref_depthwise(
        dw_weights, dw_biases,
        dw_input, dw_ref_output,
        DW_IH, DW_IW, DW_IC,
        DW_OH, DW_OW,
        DW_STRIDE,
        dw_multipliers, dw_shifts,
        0, 0,
        -128, 127
    );

    // Run DUT
    conv_accel(
        (ap_uint<8>)DW_IH, (ap_uint<8>)DW_IW, (ap_uint<16>)DW_IC,
        (ap_uint<8>)DW_OH, (ap_uint<8>)DW_OW, (ap_uint<16>)DW_IC,
        (ap_uint<2>)DW_STRIDE,
        (ap_uint<1>)1,   // pad_same
        (ap_uint<1>)1,   // is_depthwise = true
        (ap_uint<1>)0,   // relu6_en
        (ap_uint<20>)dw_weight_base,
        (ap_uint<20>)dw_bias_base,
        (ap_uint<20>)dw_input_base,
        (ap_uint<20>)dw_output_base,
        (ap_uint<20>)dw_requant_base,
        (ap_int<8>)0,
        (ap_int<8>)0,
        weight_bram, act_a, act_b
    );

    // Compare
    int dw_errors = 0;
    for (int i = 0; i < DW_OH * DW_OW * DW_IC; i++) {
        int8_t dut_val = (int8_t)(int)act_b[dw_output_base + i];
        if (dut_val != dw_ref_output[i]) {
            if (dw_errors < 10)
                printf("  DW MISMATCH [%d]: ref=%d, dut=%d\n",
                       i, dw_ref_output[i], dut_val);
            dw_errors++;
        }
    }
    printf("Test 2 (Depthwise 6x6x16, stride=1): %s (%d/%d errors)\n",
           dw_errors == 0 ? "PASS" : "FAIL",
           dw_errors, DW_OH * DW_OW * DW_IC);

    // ---- Test 3: Pointwise with non-zero input_zp (common in real models) ----
    const int PW3_IH = 4, PW3_IW = 4, PW3_IC = 16;
    const int PW3_OH = 4, PW3_OW = 4, PW3_OC = 32;
    const int PW3_STRIDE = 1;
    const int8_t PW3_INPUT_ZP = -3;
    const int8_t PW3_OUTPUT_ZP = 5;

    int8_t  pw3_weights[PW3_OC * PW3_IC];
    int32_t pw3_biases[PW3_OC];
    int32_t pw3_multipliers[PW3_OC];
    int     pw3_shifts[PW3_OC];
    int8_t  pw3_input[PW3_IH * PW3_IW * PW3_IC];
    int8_t  pw3_ref_output[PW3_OH * PW3_OW * PW3_OC];

    for (int i = 0; i < PW3_OC * PW3_IC; i++)
        pw3_weights[i] = (int8_t)(rand() % 256 - 128);
    for (int i = 0; i < PW3_IH * PW3_IW * PW3_IC; i++)
        pw3_input[i] = (int8_t)(rand() % 256 - 128);
    for (int i = 0; i < PW3_OC; i++) {
        pw3_biases[i] = rand() % 2000 - 1000;
        pw3_multipliers[i] = 1073741824 + (rand() % 1073741824);
        pw3_shifts[i] = -(rand() % 10 + 1);
    }

    int pw3_weight_base  = 8192;
    int pw3_bias_base    = pw3_weight_base + PW3_OC * PW3_IC;
    int pw3_requant_base = pw3_bias_base + PW3_OC * 4;
    int pw3_input_base   = 0;
    int pw3_output_base  = 0;

    for (int i = 0; i < PW3_OC * PW3_IC; i++)
        weight_bram[pw3_weight_base + i] = (int8_t_hls)pw3_weights[i];
    for (int oc = 0; oc < PW3_OC; oc++) {
        pack_i32(weight_bram, pw3_bias_base + oc * 4, pw3_biases[oc]);
        pack_i32(weight_bram, pw3_requant_base + oc * 8, pw3_multipliers[oc]);
        weight_bram[pw3_requant_base + oc * 8 + 4] = (int8_t_hls)tflite_shift_to_hls(pw3_shifts[oc]);
        weight_bram[pw3_requant_base + oc * 8 + 5] = (int8_t_hls)(-128);
        weight_bram[pw3_requant_base + oc * 8 + 6] = (int8_t_hls)(127);
        weight_bram[pw3_requant_base + oc * 8 + 7] = 0;
    }

    for (int i = 0; i < PW3_IH * PW3_IW * PW3_IC; i++)
        act_a[pw3_input_base + i] = (int8_t_hls)pw3_input[i];

    ref_pointwise(
        pw3_weights, pw3_biases,
        pw3_input, pw3_ref_output,
        PW3_IH, PW3_IW, PW3_IC,
        PW3_OH, PW3_OW, PW3_OC,
        PW3_STRIDE,
        pw3_multipliers, pw3_shifts,
        PW3_INPUT_ZP, PW3_OUTPUT_ZP,
        -128, 127
    );

    conv_accel(
        (ap_uint<8>)PW3_IH, (ap_uint<8>)PW3_IW, (ap_uint<16>)PW3_IC,
        (ap_uint<8>)PW3_OH, (ap_uint<8>)PW3_OW, (ap_uint<16>)PW3_OC,
        (ap_uint<2>)PW3_STRIDE,
        (ap_uint<1>)1,
        (ap_uint<1>)0,   // pointwise
        (ap_uint<1>)0,
        (ap_uint<20>)pw3_weight_base,
        (ap_uint<20>)pw3_bias_base,
        (ap_uint<20>)pw3_input_base,
        (ap_uint<20>)pw3_output_base,
        (ap_uint<20>)pw3_requant_base,
        (ap_int<8>)PW3_INPUT_ZP,
        (ap_int<8>)PW3_OUTPUT_ZP,
        weight_bram, act_a, act_b
    );

    int pw3_errors = 0;
    for (int i = 0; i < PW3_OH * PW3_OW * PW3_OC; i++) {
        int8_t dut_val = (int8_t)(int)act_b[pw3_output_base + i];
        if (dut_val != pw3_ref_output[i]) {
            if (pw3_errors < 10)
                printf("  PW3 MISMATCH [%d]: ref=%d, dut=%d\n",
                       i, pw3_ref_output[i], dut_val);
            pw3_errors++;
        }
    }
    printf("Test 3 (Pointwise 4x4x16->4x4x32, zp=-3/5): %s (%d/%d errors)\n",
           pw3_errors == 0 ? "PASS" : "FAIL",
           pw3_errors, PW3_OH * PW3_OW * PW3_OC);

    printf("\n=== Done ===\n");
    return (pw_errors + dw_errors + pw3_errors) > 0 ? 1 : 0;
}