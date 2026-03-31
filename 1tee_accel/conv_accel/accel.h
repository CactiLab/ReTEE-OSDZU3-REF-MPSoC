#ifndef ACCEL_H
#define ACCEL_H

#include <ap_int.h>
#include <hls_stream.h>

// ============================================================
//  Accelerator parameters — tune to your ZU3 resource budget
// ============================================================

// Maximum dimensions this accelerator supports.
// MobileNetV1 0.25x 96×96: largest spatial = 48×48, largest channels = 256.
static const int MAX_H  = 48;
static const int MAX_W  = 48;
static const int MAX_C  = 256;
static const int MAX_K  = 256;   // max output channels

// Pointwise: output-channel tile size.
// Weights for one tile are preloaded into local cache, then all pixels
// are processed against them.  Determines DSP count for pointwise.
// TILE_OC=16 → 16 DSPs, 4 KB weight cache.
static const int PW_TILE_OC = 16;

// Accumulator depth — must be ≥ DSP48E2 multiply-accumulate latency
// to break the carried dependency on acc[t][d] and achieve II=1.
static const int ACC_DEPTH = 4;

// Depthwise parallelism — process DW_PARALLEL channels at a time.
// Kept small to avoid LUT explosion from wide unroll + variable trip counts.
static const int DW_PARALLEL = 32;

// Phases per output pixel in the merged DW pipeline:
// 9 MAC (3×3 kernel) + 1 reduce + DW_PARALLEL/4 store words = 18
static const int DW_PHASES_PER_PIX = 9 + 1 + DW_PARALLEL / 4;

// BRAM sizing (bytes).
// Two 64 KB activation BRAMs — no separate weight BRAM.
// Weights are packed into act_bram_a alongside input activations,
// loaded per-layer by the CPU before each accelerator call.
// Largest combined: PW 128→256 = ~36 KB weights + ~5 KB input = ~41 KB.
static const int ACT_BUF_BYTES = 64 * 1024;
static const int ACT_BUF_WORDS = ACT_BUF_BYTES / 4;

// ============================================================
//  Fixed-point / quantisation types
// ============================================================
typedef ap_int<8>   int8_t_hls;
typedef ap_int<32>  int32_t_hls;
typedef ap_uint<8>  uint8_t_hls;

// ============================================================
//  Layer descriptor — written by RISC-V via AXI-Lite
//
//  All base addresses are byte offsets within the act BRAMs:
//    weight_base, bias_base, requant_base → offsets in act_bram_a
//    input_base                           → offset in act_bram_a
//    output_base                          → offset in act_bram_b
// ============================================================
struct LayerDesc {
    // Spatial dimensions (input)
    ap_uint<8>  in_h;
    ap_uint<8>  in_w;
    ap_uint<16> in_c;

    // Spatial dimensions (output) — for convenience; derivable from stride
    ap_uint<8>  out_h;
    ap_uint<8>  out_w;
    ap_uint<16> out_c;

    // Convolution parameters
    ap_uint<2>  stride;       // 1 or 2
    ap_uint<1>  pad_same;     // 1 = SAME padding, 0 = VALID
    ap_uint<1>  is_depthwise; // 1 = DEPTHWISE_CONV_2D, 0 = CONV_2D (pointwise/standard)
    ap_uint<1>  relu6_en;     // 1 = apply ReLU6 clamp after requantisation

    // BRAM base addresses (byte offsets into act_bram_a)
    ap_uint<20> weight_base;  // weights
    ap_uint<20> bias_base;    // biases (after weights)
    ap_uint<20> input_base;   // input activations (after requant)
    ap_uint<20> output_base;  // offset in act_bram_b

    // Per-channel requantisation table base (in act_bram_a, after biases)
    // Each entry: int32 multiplier + int8 shift (5 bytes per channel)
    ap_uint<20> requant_base;

    // Input/output zero points
    int8_t_hls  input_zp;
    int8_t_hls  output_zp;
};

// ============================================================
//  Top-level accelerator function
// ============================================================
void conv_accel(
    // AXI-Lite control — layer descriptor fields mapped as registers
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

    // BRAM ports — two 64 KB activation BRAMs (32-bit wide)
    // act_bram_a: weights + input (read by accelerator)
    // act_bram_b: output (written by accelerator)
    ap_uint<32> act_bram_a[ACT_BUF_WORDS],
    ap_uint<32> act_bram_b[ACT_BUF_WORDS]
);

#endif // ACCEL_H
