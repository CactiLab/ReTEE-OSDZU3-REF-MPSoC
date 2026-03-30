#include "accel.h"

// ============================================================
//  Requantise: INT32 accumulator → INT8 output
//
//  TFLite quantisation:
//    out = (acc * multiplier) >> shift + output_zp
//    then clamp to [-128, 127] (and optionally [0, qmax] for ReLU6)
//
//  The multiplier and shift are per-channel, precomputed by
//  TFLite Micro and stored in the weight BRAM.
// ============================================================
static int8_t_hls requantise(
    int32_t_hls acc,
    int32_t_hls multiplier,
    int8_t_hls  shift,
    int8_t_hls  output_zp,
    ap_uint<1>  relu6_en,
    int8_t_hls  act_min,   // quantised 0   for ReLU6
    int8_t_hls  act_max    // quantised 6   for ReLU6
) {
#pragma HLS INLINE
#pragma HLS PIPELINE II=1

    // Multiply accumulator by per-channel scale
    // Use 64-bit intermediate to avoid overflow
    ap_int<64> wide = (ap_int<64>)acc * (ap_int<64>)multiplier;

    // Arithmetic right shift (rounding)
    int32_t_hls shifted;
    if (shift >= 0) {
        // Round-half-up: add (1 << (shift-1)) before shifting
        ap_int<64> round_val = (shift > 0) ? ((ap_int<64>)1 << (shift - 1)) : (ap_int<64>)0;
        shifted = (int32_t_hls)((wide + round_val) >> shift);
    } else {
        shifted = (int32_t_hls)(wide << (-shift));
    }

    // Add output zero point
    int32_t_hls result = shifted + (int32_t_hls)output_zp;

    // Clamp to INT8 range
    if (result > 127)  result = 127;
    if (result < -128)  result = -128;

    // Optional ReLU6 clamping
    if (relu6_en) {
        if (result < (int32_t_hls)act_min) result = (int32_t_hls)act_min;
        if (result > (int32_t_hls)act_max) result = (int32_t_hls)act_max;
    }

    return (int8_t_hls)result;
}

// ============================================================
//  Read a single activation value with padding support
// ============================================================
static int8_t_hls read_act_padded(
    int8_t_hls  act_bram[ACT_BUF_BYTES],
    ap_uint<20> input_base,
    int          h,
    int          w,
    int          c,
    int          in_h,
    int          in_w,
    int          in_c,
    int8_t_hls   input_zp   // padding fills with zero-point value
) {
#pragma HLS INLINE
    if (h < 0 || h >= in_h || w < 0 || w >= in_w) {
        return input_zp;
    }
    int addr = (int)input_base + (h * in_w * in_c) + (w * in_c) + c;
    return act_bram[addr];
}

// ============================================================
//  Pointwise (1×1) convolution kernel
//
//  Input is a flat array of spatial × in_c values (caller pre-strides).
//  For each pixel p in [0, spatial):
//    for each output channel oc:
//      acc = bias[oc] + Σ_ic (input[p,ic] - input_zp) * weight[oc,ic]
//      output[p, oc] = requantise(acc)
//
//  Inner ic loop is unrolled by MAC_PARALLEL.
// ============================================================
static void pointwise_conv(
    int8_t_hls  weight_bram[WEIGHT_BRAM_BYTES],
    int8_t_hls  act_in[ACT_BUF_BYTES],
    int8_t_hls  act_out[ACT_BUF_BYTES],
    int          spatial, int in_c,
    int          out_c,
    ap_uint<20>  weight_base,
    ap_uint<20>  bias_base,
    ap_uint<20>  requant_base,
    ap_uint<20>  input_base,
    ap_uint<20>  output_base,
    int8_t_hls   input_zp,
    int8_t_hls   output_zp,
    ap_uint<1>   relu6_en
) {
    // Local weight line buffer — holds one row of weight matrix:
    // weight[oc, 0..in_c-1] for current oc.
    // static to avoid stack overflow in HLS C simulation.
    static int8_t_hls w_buf[MAX_C];
#pragma HLS ARRAY_PARTITION variable=w_buf cyclic factor=MAC_PARALLEL

    // Input pixel buffer — holds input[pixel, 0..in_c-1]
    static int8_t_hls in_buf[MAX_C];
#pragma HLS ARRAY_PARTITION variable=in_buf cyclic factor=MAC_PARALLEL

    // Partial sums for MAC — one per DSP lane, zeroed each output channel.
    static int32_t_hls partial[MAC_PARALLEL];
#pragma HLS ARRAY_PARTITION variable=partial complete

    // Iterate over output pixels (caller pre-strides the input)
    LOOP_PIX: for (int pix = 0; pix < spatial; pix++) {

        // Load input pixel vector (all input channels)
        LOAD_IN: for (int ic = 0; ic < in_c; ic++) {
#pragma HLS PIPELINE II=1
            int addr = (int)input_base + pix * in_c + ic;
            in_buf[ic] = act_in[addr];
        }

        // Iterate over output channels
        LOOP_OC: for (int oc = 0; oc < out_c; oc++) {

            // Load bias
            int bias_addr = (int)bias_base + oc * 4;
            int32_t_hls bias_val = (int32_t_hls)(
                ((ap_uint<32>)(ap_uint<8>)weight_bram[bias_addr + 3] << 24) |
                ((ap_uint<32>)(ap_uint<8>)weight_bram[bias_addr + 2] << 16) |
                ((ap_uint<32>)(ap_uint<8>)weight_bram[bias_addr + 1] <<  8) |
                ((ap_uint<32>)(ap_uint<8>)weight_bram[bias_addr + 0])
            );

            // Load weight row for this output channel
            LOAD_W: for (int ic = 0; ic < in_c; ic++) {
#pragma HLS PIPELINE II=1
                int w_addr = (int)weight_base + (oc * in_c) + ic;
                w_buf[ic] = weight_bram[w_addr];
            }

            // MAC — use partial sums to break carried dependency.
            // Each partial[p] is independent; full-width UNROLL
            // creates MAC_PARALLEL DSPs operating in parallel.
            CLEAR_P: for (int p = 0; p < MAC_PARALLEL; p++) {
#pragma HLS UNROLL
                partial[p] = 0;
            }

            MAC_OUTER: for (int ic_base = 0; ic_base < in_c;
                            ic_base += MAC_PARALLEL) {
#pragma HLS PIPELINE II=1
                MAC_INNER: for (int p = 0; p < MAC_PARALLEL; p++) {
#pragma HLS UNROLL
                    int ic = ic_base + p;
                    if (ic < in_c) {
                        partial[p] +=
                            ((int32_t_hls)in_buf[ic] - (int32_t_hls)input_zp) *
                            (int32_t_hls)w_buf[ic];
                    }
                }
            }

            // Reduce partial sums + bias
            int32_t_hls sum = bias_val;
            REDUCE: for (int p = 0; p < MAC_PARALLEL; p++) {
#pragma HLS UNROLL
                sum += partial[p];
            }

            // Requantise and store
            int rq_addr = (int)requant_base + oc * 8;
            int32_t_hls mult = (int32_t_hls)(
                ((ap_uint<32>)(ap_uint<8>)weight_bram[rq_addr + 3] << 24) |
                ((ap_uint<32>)(ap_uint<8>)weight_bram[rq_addr + 2] << 16) |
                ((ap_uint<32>)(ap_uint<8>)weight_bram[rq_addr + 1] <<  8) |
                ((ap_uint<32>)(ap_uint<8>)weight_bram[rq_addr + 0])
            );
            int8_t_hls rq_shift = weight_bram[rq_addr + 4];
            int8_t_hls act_min = weight_bram[rq_addr + 5];
            int8_t_hls act_max = weight_bram[rq_addr + 6];

            int8_t_hls out_val = requantise(
                sum, mult, rq_shift, output_zp, relu6_en,
                act_min, act_max
            );

            int out_addr = (int)output_base + pix * out_c + oc;
            act_out[out_addr] = out_val;
        }
    }
}

// ============================================================
//  Depthwise 3×3 convolution kernel
//
//  Each output channel c depends only on input channel c.
//  For each output pixel (oh, ow), for each channel c:
//    acc = bias[c]
//    for kh in [0..2], kw in [0..2]:
//      acc += input[oh*stride+kh-1, ow*stride+kw-1, c] * weight[kh, kw, c]
//    output[oh, ow, c] = requantise(acc)
//
//  Parallelise across channels in tiles of DW_PARALLEL.
//  All inner loops have fixed trip counts to avoid mux explosion.
// ============================================================
static void depthwise_conv3x3(
    int8_t_hls  weight_bram[WEIGHT_BRAM_BYTES],
    int8_t_hls  act_in[ACT_BUF_BYTES],
    int8_t_hls  act_out[ACT_BUF_BYTES],
    int          in_h, int in_w, int in_c,
    int          out_h, int out_w,
    int          stride,
    ap_uint<20>  weight_base,
    ap_uint<20>  bias_base,
    ap_uint<20>  requant_base,
    ap_uint<20>  input_base,
    ap_uint<20>  output_base,
    int8_t_hls   input_zp,
    int8_t_hls   output_zp,
    ap_uint<1>   relu6_en
) {
    // Weight cache — partitioned by DW_PARALLEL for parallel reads.
    // static to avoid stack overflow in HLS C simulation (ap_int overhead).
    static int8_t_hls w_cache[9][MAX_C];
#pragma HLS ARRAY_PARTITION variable=w_cache complete dim=1
#pragma HLS ARRAY_PARTITION variable=w_cache cyclic factor=DW_PARALLEL dim=2

    // Preloaded bias / requant tables — avoids weight_bram port
    // contention in the per-pixel LOAD_DW_BIAS and DW_STORE loops.
    static int32_t_hls bias_cache[MAX_C];
#pragma HLS ARRAY_PARTITION variable=bias_cache cyclic factor=DW_PARALLEL

    static int32_t_hls rq_mult_cache[MAX_C];
    static int8_t_hls  rq_shift_cache[MAX_C];
    static int8_t_hls  rq_amin_cache[MAX_C];
    static int8_t_hls  rq_amax_cache[MAX_C];
#pragma HLS ARRAY_PARTITION variable=rq_mult_cache  cyclic factor=DW_PARALLEL
#pragma HLS ARRAY_PARTITION variable=rq_shift_cache cyclic factor=DW_PARALLEL
#pragma HLS ARRAY_PARTITION variable=rq_amin_cache  cyclic factor=DW_PARALLEL
#pragma HLS ARRAY_PARTITION variable=rq_amax_cache  cyclic factor=DW_PARALLEL

    // Per-tile accumulator — zeroed via LOAD_DW_BIAS each tile.
    static int32_t_hls acc[DW_PARALLEL];
#pragma HLS ARRAY_PARTITION variable=acc complete

    // Preload weights — one read from weight_bram per cycle (II=1).
    // Outer loop over kernel positions avoids multi-read-per-iter stall.
    LOAD_DW_W_K: for (int k = 0; k < 9; k++) {
        LOAD_DW_W_C: for (int c = 0; c < in_c; c++) {
#pragma HLS PIPELINE II=1
            int w_addr = (int)weight_base + k * in_c + c;
            w_cache[k][c] = weight_bram[w_addr];
        }
    }

    // Preload biases (4 bytes each from weight_bram)
    LOAD_DW_BIASES: for (int c = 0; c < in_c; c++) {
#pragma HLS PIPELINE II=1
        int addr = (int)bias_base + c * 4;
        int32_t_hls bv = (int32_t_hls)(
            ((ap_uint<32>)(ap_uint<8>)weight_bram[addr + 3] << 24) |
            ((ap_uint<32>)(ap_uint<8>)weight_bram[addr + 2] << 16) |
            ((ap_uint<32>)(ap_uint<8>)weight_bram[addr + 1] <<  8) |
            ((ap_uint<32>)(ap_uint<8>)weight_bram[addr + 0])
        );
        bias_cache[c] = bv;
    }

    // Preload requant parameters (7 bytes each from weight_bram)
    LOAD_DW_REQUANT: for (int c = 0; c < in_c; c++) {
#pragma HLS PIPELINE II=1
        int addr = (int)requant_base + c * 8;
        int32_t_hls m = (int32_t_hls)(
            ((ap_uint<32>)(ap_uint<8>)weight_bram[addr + 3] << 24) |
            ((ap_uint<32>)(ap_uint<8>)weight_bram[addr + 2] << 16) |
            ((ap_uint<32>)(ap_uint<8>)weight_bram[addr + 1] <<  8) |
            ((ap_uint<32>)(ap_uint<8>)weight_bram[addr + 0])
        );
        rq_mult_cache[c]  = m;
        rq_shift_cache[c] = weight_bram[addr + 4];
        rq_amin_cache[c]  = weight_bram[addr + 5];
        rq_amax_cache[c]  = weight_bram[addr + 6];
    }

    // Iterate over spatial and channel dimensions
    DW_OH: for (int oh = 0; oh < out_h; oh++) {
        DW_OW: for (int ow = 0; ow < out_w; ow++) {

            // Process DW_PARALLEL channels at a time
            DW_C_TILE: for (int c_base = 0; c_base < in_c;
                            c_base += DW_PARALLEL) {

                // Load biases from local cache (1 read/cycle, II=1)
                LOAD_DW_BIAS: for (int t = 0; t < DW_PARALLEL; t++) {
#pragma HLS PIPELINE II=1
                    acc[t] = bias_cache[c_base + t];
                }

                // 3×3 MAC — pipeline across channels within each
                // kernel position.  acc[t] reuse distance = DW_PARALLEL,
                // which exceeds DSP latency so II=1 is achievable.
                DW_KH: for (int kh = 0; kh < 3; kh++) {
                    DW_KW: for (int kw = 0; kw < 3; kw++) {
                        int ih = oh * stride + kh - 1;
                        int iw = ow * stride + kw - 1;
                        int k_idx = kh * 3 + kw;

                        DW_MAC: for (int t = 0; t < DW_PARALLEL; t++) {
#pragma HLS PIPELINE II=1
                            int c = c_base + t;
                            int8_t_hls in_val = read_act_padded(
                                act_in, input_base,
                                ih, iw, c,
                                in_h, in_w, in_c,
                                input_zp
                            );
                            acc[t] +=
                                ((int32_t_hls)in_val - (int32_t_hls)input_zp) *
                                (int32_t_hls)w_cache[k_idx][c];
                        }
                    }
                }

                // Requantise and store — reads only local caches (II=1)
                DW_STORE: for (int t = 0; t < DW_PARALLEL; t++) {
#pragma HLS PIPELINE II=1
                    int c = c_base + t;
                    if (c < in_c) {
                        int8_t_hls out_val = requantise(
                            acc[t],
                            rq_mult_cache[c],
                            rq_shift_cache[c],
                            output_zp, relu6_en,
                            rq_amin_cache[c],
                            rq_amax_cache[c]
                        );

                        int out_addr = (int)output_base +
                            (oh * out_w * in_c) + (ow * in_c) + c;
                        act_out[out_addr] = out_val;
                    }
                }
            }
        }
    }
}

// ============================================================
//  Top-level accelerator
// ============================================================
void conv_accel(
    ap_uint<8>  in_h,
    ap_uint<8>  in_w,
    ap_uint<16> in_c,
    ap_uint<8>  out_h,
    ap_uint<8>  out_w,
    ap_uint<16> out_c,
    ap_uint<2>  stride,
    ap_uint<1>  pad_same,
    ap_uint<1>  is_depthwise,
    ap_uint<1>  relu6_en,
    ap_uint<20> weight_base,
    ap_uint<20> bias_base,
    ap_uint<20> input_base,
    ap_uint<20> output_base,
    ap_uint<20> requant_base,
    ap_int<8>   input_zp,
    ap_int<8>   output_zp,
    int8_t_hls  weight_bram[WEIGHT_BRAM_BYTES],
    int8_t_hls  act_bram_a[ACT_BUF_BYTES],
    int8_t_hls  act_bram_b[ACT_BUF_BYTES]
) {
    // ---- AXI-Lite for scalar control registers ----
#pragma HLS INTERFACE s_axilite port=in_h        bundle=ctrl
#pragma HLS INTERFACE s_axilite port=in_w        bundle=ctrl
#pragma HLS INTERFACE s_axilite port=in_c        bundle=ctrl
#pragma HLS INTERFACE s_axilite port=out_h       bundle=ctrl
#pragma HLS INTERFACE s_axilite port=out_w       bundle=ctrl
#pragma HLS INTERFACE s_axilite port=out_c       bundle=ctrl
#pragma HLS INTERFACE s_axilite port=stride      bundle=ctrl
#pragma HLS INTERFACE s_axilite port=pad_same    bundle=ctrl
#pragma HLS INTERFACE s_axilite port=is_depthwise bundle=ctrl
#pragma HLS INTERFACE s_axilite port=relu6_en    bundle=ctrl
#pragma HLS INTERFACE s_axilite port=weight_base bundle=ctrl
#pragma HLS INTERFACE s_axilite port=bias_base   bundle=ctrl
#pragma HLS INTERFACE s_axilite port=input_base  bundle=ctrl
#pragma HLS INTERFACE s_axilite port=output_base bundle=ctrl
#pragma HLS INTERFACE s_axilite port=requant_base bundle=ctrl
#pragma HLS INTERFACE s_axilite port=input_zp    bundle=ctrl
#pragma HLS INTERFACE s_axilite port=output_zp   bundle=ctrl
#pragma HLS INTERFACE s_axilite port=return      bundle=ctrl

    // ---- BRAM interfaces ----
    // weight_bram is read-only during inference.
    // act BRAMs use true dual-port so cosim (and the external bus master)
    // can preload act_bram_a and readback act_bram_b.
#pragma HLS INTERFACE bram port=weight_bram storage_type=ram_1p
#pragma HLS INTERFACE bram port=act_bram_a  storage_type=ram_t2p
#pragma HLS INTERFACE bram port=act_bram_b  storage_type=ram_t2p

    // Force HLS to keep both read and write paths on each activation
    // BRAM.  Without these accesses, HLS optimises away the unused
    // direction and cosim cannot preload/readback test data.
    volatile int8_t_hls dummy_a = act_bram_a[0];
    volatile int8_t_hls dummy_b = act_bram_b[0];
    (void)dummy_a;
    (void)dummy_b;
    act_bram_a[0] = act_bram_a[0];
    act_bram_b[0] = act_bram_b[0];

    // Cast to plain int for loop bounds (HLS needs static-friendly types)
    int h_in  = (int)in_h;
    int w_in  = (int)in_w;
    int c_in  = (int)in_c;
    int h_out = (int)out_h;
    int w_out = (int)out_w;
    int c_out = (int)out_c;
    int s     = (int)stride;

    if (is_depthwise) {
        depthwise_conv3x3(
            weight_bram, act_bram_a, act_bram_b,
            h_in, w_in, c_in,
            h_out, w_out,
            s,
            weight_base, bias_base, requant_base,
            input_base, output_base,
            input_zp, output_zp, relu6_en
        );
    } else {
        pointwise_conv(
            weight_bram, act_bram_a, act_bram_b,
            h_out * w_out, c_in,
            c_out,
            weight_base, bias_base, requant_base,
            input_base, output_base,
            input_zp, output_zp, relu6_en
        );
    }
}