#include "accel.h"

// ============================================================
//  Requantise: INT32 accumulator -> INT8 output
// ============================================================
static int8_t_hls requantise(
    int32_t_hls acc,
    int32_t_hls multiplier,
    int8_t_hls  shift,
    int8_t_hls  output_zp,
    ap_uint<1>  relu6_en,
    int8_t_hls  act_min,
    int8_t_hls  act_max
) {
#pragma HLS INLINE
#pragma HLS PIPELINE II=1

    ap_int<64> wide = (ap_int<64>)acc * (ap_int<64>)multiplier;

    int32_t_hls shifted;
    if (shift >= 0) {
        ap_int<64> round_val = (shift > 0) ? ((ap_int<64>)1 << (shift - 1)) : (ap_int<64>)0;
        shifted = (int32_t_hls)((wide + round_val) >> shift);
    } else {
        shifted = (int32_t_hls)(wide << (-shift));
    }

    int32_t_hls result = shifted + (int32_t_hls)output_zp;

    if (result > 127)  result = 127;
    if (result < -128)  result = -128;

    if (relu6_en) {
        if (result < (int32_t_hls)act_min) result = (int32_t_hls)act_min;
        if (result > (int32_t_hls)act_max) result = (int32_t_hls)act_max;
    }

    return (int8_t_hls)result;
}

// ============================================================
//  Pointwise (1x1) convolution -- weight-stationary tiled
//
//  All BRAM accesses are 32-bit words. Weights and activations
//  are packed 4 INT8 values per word (little-endian byte order).
//  MAC inner loop steps by 4 channels per BRAM read.
// ============================================================
static void pointwise_conv(
    ap_uint<32> act_in[ACT_BUF_WORDS],
    ap_uint<32> act_out[ACT_BUF_WORDS],
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
    static int8_t_hls w_cache[PW_TILE_OC][MAX_C];
#pragma HLS ARRAY_PARTITION variable=w_cache complete dim=1
#pragma HLS BIND_STORAGE variable=w_cache type=ram_1p impl=lutram

    static int32_t_hls bias_cache[PW_TILE_OC];
#pragma HLS ARRAY_PARTITION variable=bias_cache complete

    static int32_t_hls rq_mult_cache[PW_TILE_OC];
    static int8_t_hls  rq_shift_cache[PW_TILE_OC];
    static int8_t_hls  rq_amin_cache[PW_TILE_OC];
    static int8_t_hls  rq_amax_cache[PW_TILE_OC];
#pragma HLS ARRAY_PARTITION variable=rq_mult_cache  complete
#pragma HLS ARRAY_PARTITION variable=rq_shift_cache complete
#pragma HLS ARRAY_PARTITION variable=rq_amin_cache  complete
#pragma HLS ARRAY_PARTITION variable=rq_amax_cache  complete

    static int32_t_hls acc[PW_TILE_OC][ACC_DEPTH];
#pragma HLS ARRAY_PARTITION variable=acc complete

    int in_c4 = in_c >> 2;  // number of 32-bit words per row

    PW_OC_TILE: for (int oc_base = 0; oc_base < out_c;
                     oc_base += PW_TILE_OC) {

        int tile_oc = (oc_base + PW_TILE_OC <= out_c)
                      ? PW_TILE_OC : (out_c - oc_base);

        // Preload weights: 4 channels per 32-bit BRAM read
        PW_PRELOAD_W:
        for (int t = 0; t < tile_oc; t++) {
            PW_PRELOAD_W_IC:
            for (int ic4 = 0; ic4 < in_c4; ic4++) {
#pragma HLS PIPELINE II=1
                int word_addr = ((int)weight_base + (oc_base + t) * in_c) / 4 + ic4;
                ap_uint<32> w = act_in[word_addr];
                int ic = ic4 * 4;
                w_cache[t][ic + 0] = (int8_t_hls)w( 7,  0);
                w_cache[t][ic + 1] = (int8_t_hls)w(15,  8);
                w_cache[t][ic + 2] = (int8_t_hls)w(23, 16);
                w_cache[t][ic + 3] = (int8_t_hls)w(31, 24);
            }
        }

        // Preload biases: one 32-bit word = one bias
        PW_PRELOAD_BIAS:
        for (int t = 0; t < tile_oc; t++) {
#pragma HLS PIPELINE II=1
            int word_addr = ((int)bias_base + (oc_base + t) * 4) / 4;
            bias_cache[t] = (int32_t_hls)act_in[word_addr];
        }

        // Preload requant params: 2 words per channel (8 bytes each)
        // Word 0: multiplier (32-bit), Word 1: [shift, amin, amax, pad]
        PW_PRELOAD_RQ:
        for (int t = 0; t < tile_oc; t++) {
#pragma HLS PIPELINE II=1
            int base_word = ((int)requant_base + (oc_base + t) * 8) / 4;
            ap_uint<32> w0 = act_in[base_word];
            ap_uint<32> w1 = act_in[base_word + 1];
            rq_mult_cache[t]  = (int32_t_hls)w0;
            rq_shift_cache[t] = (int8_t_hls)w1( 7,  0);
            rq_amin_cache[t]  = (int8_t_hls)w1(15,  8);
            rq_amax_cache[t]  = (int8_t_hls)w1(23, 16);
        }

        // Process all spatial pixels against cached weights
        PW_PIX: for (int pix = 0; pix < spatial; pix++) {

            // Init accumulators
            PW_INIT_ACC: for (int t = 0; t < PW_TILE_OC; t++) {
#pragma HLS UNROLL
                for (int d = 0; d < ACC_DEPTH; d++) {
#pragma HLS UNROLL
                    acc[t][d] = (d == 0) ? bias_cache[t] : (int32_t_hls)0;
                }
            }

            // MAC: read 4 input channels per 32-bit word
            PW_MAC: for (int ic4 = 0; ic4 < in_c4; ic4++) {
#pragma HLS PIPELINE II=1
                int word_addr = ((int)input_base + pix * in_c) / 4 + ic4;
                ap_uint<32> in_word = act_in[word_addr];

                // Extract 4 INT8 values and subtract zero point
                int32_t_hls in_sub[4];
#pragma HLS ARRAY_PARTITION variable=in_sub complete
                in_sub[0] = (int32_t_hls)(int8_t_hls)in_word( 7,  0) - (int32_t_hls)input_zp;
                in_sub[1] = (int32_t_hls)(int8_t_hls)in_word(15,  8) - (int32_t_hls)input_zp;
                in_sub[2] = (int32_t_hls)(int8_t_hls)in_word(23, 16) - (int32_t_hls)input_zp;
                in_sub[3] = (int32_t_hls)(int8_t_hls)in_word(31, 24) - (int32_t_hls)input_zp;

                int ic = ic4 * 4;
                int d0 = (ic + 0) % ACC_DEPTH;
                int d1 = (ic + 1) % ACC_DEPTH;
                int d2 = (ic + 2) % ACC_DEPTH;
                int d3 = (ic + 3) % ACC_DEPTH;

                PW_MAC_TILE: for (int t = 0; t < PW_TILE_OC; t++) {
#pragma HLS UNROLL
                    acc[t][d0] += in_sub[0] * (int32_t_hls)w_cache[t][ic + 0];
                    acc[t][d1] += in_sub[1] * (int32_t_hls)w_cache[t][ic + 1];
                    acc[t][d2] += in_sub[2] * (int32_t_hls)w_cache[t][ic + 2];
                    acc[t][d3] += in_sub[3] * (int32_t_hls)w_cache[t][ic + 3];
                }
            }

            // Reduce depth-interleaved accumulators
            PW_REDUCE: for (int t = 0; t < PW_TILE_OC; t++) {
#pragma HLS UNROLL
                for (int d = 1; d < ACC_DEPTH; d++) {
#pragma HLS UNROLL
                    acc[t][0] += acc[t][d];
                }
            }

            // Requantise and store: pack 4 INT8 results per 32-bit word
            PW_STORE: for (int t = 0; t < tile_oc; t += 4) {
#pragma HLS PIPELINE II=1
                ap_uint<32> out_word;
                for (int b = 0; b < 4; b++) {
#pragma HLS UNROLL
                    int8_t_hls out_val = (int8_t_hls)0;
                    if (oc_base + t + b < out_c) {
                        out_val = requantise(
                            acc[t + b][0],
                            rq_mult_cache[t + b],
                            rq_shift_cache[t + b],
                            output_zp, relu6_en,
                            rq_amin_cache[t + b],
                            rq_amax_cache[t + b]
                        );
                    }
                    out_word(b * 8 + 7, b * 8) = (ap_uint<8>)out_val;
                }
                int byte_addr = (int)output_base + pix * out_c + oc_base + t;
                act_out[byte_addr / 4] = out_word;
            }
        }
    }
}

// ============================================================
//  Depthwise 3x3 convolution — line-buffered, full-width MAC
//
//  Caches 3 input rows per channel tile into partitioned LUTRAM,
//  enabling DW_PARALLEL channels to be processed per cycle.
//  The 3×3 kernel loop runs in 9 cycles per pixel (vs 72+overhead
//  when limited to 4 channels/cycle from a single BRAM port).
//
//  Accumulators are depth-interleaved (ACC_DEPTH=4) to break the
//  carried dependency across kernel positions, same technique as
//  the pointwise kernel.
// ============================================================
static void depthwise_conv3x3(
    ap_uint<32> act_in[ACT_BUF_WORDS],
    ap_uint<32> act_out[ACT_BUF_WORDS],
    int          in_h, int in_w, int in_c,
    int          out_h, int out_w,
    int          stride,
    ap_uint<1>   pad_same,
    ap_uint<20>  weight_base,
    ap_uint<20>  bias_base,
    ap_uint<20>  requant_base,
    ap_uint<20>  input_base,
    ap_uint<20>  output_base,
    int8_t_hls   input_zp,
    int8_t_hls   output_zp,
    ap_uint<1>   relu6_en
) {
    static int8_t_hls w_cache[9][MAX_C];
#pragma HLS ARRAY_PARTITION variable=w_cache complete dim=1
#pragma HLS ARRAY_PARTITION variable=w_cache cyclic factor=DW_PARALLEL dim=2
#pragma HLS BIND_STORAGE variable=w_cache type=ram_1p impl=lutram

    static int32_t_hls bias_cache[MAX_C];
#pragma HLS ARRAY_PARTITION variable=bias_cache cyclic factor=DW_PARALLEL
#pragma HLS BIND_STORAGE variable=bias_cache type=ram_1p impl=lutram

    static int32_t_hls rq_mult_cache[MAX_C];
    static int8_t_hls  rq_shift_cache[MAX_C];
    static int8_t_hls  rq_amin_cache[MAX_C];
    static int8_t_hls  rq_amax_cache[MAX_C];
#pragma HLS ARRAY_PARTITION variable=rq_mult_cache  cyclic factor=DW_PARALLEL
#pragma HLS ARRAY_PARTITION variable=rq_shift_cache cyclic factor=DW_PARALLEL
#pragma HLS ARRAY_PARTITION variable=rq_amin_cache  cyclic factor=DW_PARALLEL
#pragma HLS ARRAY_PARTITION variable=rq_amax_cache  cyclic factor=DW_PARALLEL
#pragma HLS BIND_STORAGE variable=rq_mult_cache  type=ram_1p impl=lutram
#pragma HLS BIND_STORAGE variable=rq_shift_cache type=ram_1p impl=lutram
#pragma HLS BIND_STORAGE variable=rq_amin_cache  type=ram_1p impl=lutram
#pragma HLS BIND_STORAGE variable=rq_amax_cache  type=ram_1p impl=lutram

    // Line buffer: 3 input rows × in_w columns × DW_PARALLEL channels.
    // dim=1 (3 rows) and dim=3 (DW_PARALLEL channels) fully partitioned
    // so all 32 channels can be read in one cycle from any of the 3 rows.
    // Cost: 96 LUTRAMs of depth MAX_W = ~768 LUTs (~1% of ZU3).
    static int8_t_hls line_buf[3][MAX_W][DW_PARALLEL];
#pragma HLS ARRAY_PARTITION variable=line_buf complete dim=1
#pragma HLS ARRAY_PARTITION variable=line_buf complete dim=3
#pragma HLS BIND_STORAGE variable=line_buf type=ram_1p impl=lutram

    // Depth-interleaved accumulators: breaks carried dependency across
    // the 9 kernel positions so DW_KERNEL achieves II=1.
    // Reuse distance for acc[t][d] = ACC_DEPTH = 4, matching DSP latency.
    static int32_t_hls acc[DW_PARALLEL][ACC_DEPTH];
#pragma HLS ARRAY_PARTITION variable=acc complete

    int in_c4 = in_c >> 2;
    int dw_c4 = DW_PARALLEL >> 2;

    // Compute SAME-padding offsets from dimensions
    int pad_top = 0, pad_left = 0;
    if (pad_same) {
        int pad_h = (out_h - 1) * stride + 3 - in_h;
        int pad_w = (out_w - 1) * stride + 3 - in_w;
        if (pad_h > 0) pad_top = pad_h / 2;
        if (pad_w > 0) pad_left = pad_w / 2;
    }

    // Preload weights: 4 channels per word
    LOAD_DW_W_K: for (int k = 0; k < 9; k++) {
        LOAD_DW_W_C: for (int c4 = 0; c4 < in_c4; c4++) {
#pragma HLS PIPELINE II=1
            int word_addr = ((int)weight_base + k * in_c) / 4 + c4;
            ap_uint<32> w = act_in[word_addr];
            int c = c4 * 4;
            w_cache[k][c + 0] = (int8_t_hls)w( 7,  0);
            w_cache[k][c + 1] = (int8_t_hls)w(15,  8);
            w_cache[k][c + 2] = (int8_t_hls)w(23, 16);
            w_cache[k][c + 3] = (int8_t_hls)w(31, 24);
        }
    }

    // Preload biases: one word = one 32-bit bias
    LOAD_DW_BIASES: for (int c = 0; c < in_c; c++) {
#pragma HLS PIPELINE II=1
        int word_addr = ((int)bias_base + c * 4) / 4;
        bias_cache[c] = (int32_t_hls)act_in[word_addr];
    }

    // Preload requant: 2 words per channel
    LOAD_DW_REQUANT: for (int c = 0; c < in_c; c++) {
#pragma HLS PIPELINE II=1
        int base_word = ((int)requant_base + c * 8) / 4;
        ap_uint<32> w0 = act_in[base_word];
        ap_uint<32> w1 = act_in[base_word + 1];
        rq_mult_cache[c]  = (int32_t_hls)w0;
        rq_shift_cache[c] = (int8_t_hls)w1( 7,  0);
        rq_amin_cache[c]  = (int8_t_hls)w1(15,  8);
        rq_amax_cache[c]  = (int8_t_hls)w1(23, 16);
    }

    DW_C_TILE: for (int c_base = 0; c_base < in_c;
                    c_base += DW_PARALLEL) {

        // Track which input rows have been loaded into line_buf.
        // Row ir occupies slot ir % 3.  On each output row, we
        // load only the new rows the sliding window needs.
        int max_loaded = -1;

        DW_OH: for (int oh = 0; oh < out_h; oh++) {

            // Determine the highest input row this output row reads
            int need_up_to = oh * stride - pad_top + 2;
            if (need_up_to >= in_h) need_up_to = in_h - 1;

            // Load any input rows not yet in the line buffer
            LOAD_ROWS: for (int ir = max_loaded + 1; ir <= need_up_to; ir++) {
#pragma HLS LOOP_TRIPCOUNT min=0 max=3
                int slot = ir % 3;
                LOAD_COL: for (int col = 0; col < in_w; col++) {
                    LOAD_CH: for (int t4 = 0; t4 < dw_c4; t4++) {
#pragma HLS PIPELINE II=1
                        int byte_addr = (int)input_base +
                            ir * in_w * in_c + col * in_c + c_base + t4 * 4;
                        ap_uint<32> w = act_in[byte_addr / 4];
                        int t = t4 * 4;
                        line_buf[slot][col][t + 0] = (int8_t_hls)w( 7,  0);
                        line_buf[slot][col][t + 1] = (int8_t_hls)w(15,  8);
                        line_buf[slot][col][t + 2] = (int8_t_hls)w(23, 16);
                        line_buf[slot][col][t + 3] = (int8_t_hls)w(31, 24);
                    }
                }
                max_loaded = ir;
            }

            DW_OW: for (int ow = 0; ow < out_w; ow++) {

                // Init depth-interleaved accumulators from bias
                DW_INIT: for (int t = 0; t < DW_PARALLEL; t++) {
#pragma HLS UNROLL
                    for (int d = 0; d < ACC_DEPTH; d++) {
#pragma HLS UNROLL
                        acc[t][d] = (d == 0) ? bias_cache[c_base + t]
                                              : (int32_t_hls)0;
                    }
                }

                // 3×3 MAC: DW_PARALLEL channels per cycle, 9 cycles total.
                // acc[t][k%4] breaks the carried dependency so II=1.
                DW_KERNEL: for (int k = 0; k < 9; k++) {
#pragma HLS PIPELINE II=1
                    int kh = k / 3;
                    int kw = k % 3;
                    int ih = oh * stride + kh - pad_top;
                    int iw = ow * stride + kw - pad_left;
                    bool pad = (ih < 0 || ih >= in_h ||
                                iw < 0 || iw >= in_w);
                    int safe_ih = pad ? 0 : ih;
                    int safe_iw = pad ? 0 : iw;
                    int slot = safe_ih % 3;
                    int d = k % ACC_DEPTH;

                    for (int t = 0; t < DW_PARALLEL; t++) {
#pragma HLS UNROLL
                        int8_t_hls in_val = pad ? input_zp
                                                : line_buf[slot][safe_iw][t];
                        acc[t][d] +=
                            ((int32_t_hls)in_val - (int32_t_hls)input_zp) *
                            (int32_t_hls)w_cache[k][c_base + t];
                    }
                }

                // Reduce depth-interleaved accumulators
                DW_REDUCE: for (int t = 0; t < DW_PARALLEL; t++) {
#pragma HLS UNROLL
                    for (int d = 1; d < ACC_DEPTH; d++) {
#pragma HLS UNROLL
                        acc[t][0] += acc[t][d];
                    }
                }

                // Requantise and store: pack 4 results per word
                DW_STORE: for (int t = 0; t < DW_PARALLEL; t += 4) {
#pragma HLS PIPELINE II=1
                    ap_uint<32> out_word;
                    for (int b = 0; b < 4; b++) {
#pragma HLS UNROLL
                        int c = c_base + t + b;
                        int8_t_hls out_val = (int8_t_hls)0;
                        if (c < in_c) {
                            out_val = requantise(
                                acc[t + b][0],
                                rq_mult_cache[c],
                                rq_shift_cache[c],
                                output_zp, relu6_en,
                                rq_amin_cache[c],
                                rq_amax_cache[c]
                            );
                        }
                        out_word(b * 8 + 7, b * 8) = (ap_uint<8>)out_val;
                    }
                    int byte_addr = (int)output_base +
                        (oh * out_w * in_c) + (ow * in_c) + c_base + t;
                    act_out[byte_addr / 4] = out_word;
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
    ap_uint<32> act_bram_a[ACT_BUF_WORDS],
    ap_uint<32> act_bram_b[ACT_BUF_WORDS]
) {
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

#pragma HLS INTERFACE bram port=act_bram_a  storage_type=ram_1p
#pragma HLS INTERFACE bram port=act_bram_b  storage_type=ram_t2p

    int h_in  = (int)in_h;
    int w_in  = (int)in_w;
    int c_in  = (int)in_c;
    int h_out = (int)out_h;
    int w_out = (int)out_w;
    int c_out = (int)out_c;
    int s     = (int)stride;

    if (is_depthwise) {
        depthwise_conv3x3(
            act_bram_a, act_bram_b,
            h_in, w_in, c_in,
            h_out, w_out,
            s, pad_same,
            weight_base, bias_base, requant_base,
            input_base, output_base,
            input_zp, output_zp, relu6_en
        );
    } else {
        pointwise_conv(
            act_bram_a, act_bram_b,
            h_out * w_out, c_in,
            c_out,
            weight_base, bias_base, requant_base,
            input_base, output_base,
            input_zp, output_zp, relu6_en
        );
    }
}
