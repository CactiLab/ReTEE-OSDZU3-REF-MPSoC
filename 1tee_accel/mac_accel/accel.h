#ifndef ACCEL_H
#define ACCEL_H

#include <ap_int.h>
#include <hls_stream.h>

// ============================================================
//  Accelerator parameters — tune to your ZU3 resource budget
// ============================================================

// MAC array width.  128 INT8 MACs ≈ 128 DSP48E2s (1:1 mapping).
// Increase to 256 if you pack 2 mults per DSP and have headroom.
static const int MAC_PARALLEL = 128;

// Maximum dimensions this accelerator supports.
// MobileNetV1 0.25x 96×96: largest spatial = 48×48, largest channels = 256.
static const int MAX_H  = 48;
static const int MAX_W  = 48;
static const int MAX_C  = 256;
static const int MAX_K  = 256;   // max output channels
static const int MAX_TILE_ROWS = 4; // spatial tiling — process 4 rows at a time

// Depthwise parallelism — process DW_PARALLEL channels at a time.
// Kept small to avoid LUT explosion from wide unroll + variable trip counts.
static const int DW_PARALLEL = 16;

// BRAM sizing (bytes).  These determine the ap_uint port widths.
// Weight buffer: loaded per-layer by the CPU before each accelerator call.
// Largest layer (PW 128→256): 32K weights + 1K bias + 2K requant ≈ 36 KB.
static const int WEIGHT_BRAM_BYTES = 64 * 1024;
// Activation double-buffer: 48 KB each.
static const int ACT_BUF_BYTES = 48 * 1024;

// ============================================================
//  Fixed-point / quantisation types
// ============================================================
typedef ap_int<8>   int8_t_hls;
typedef ap_int<32>  int32_t_hls;
typedef ap_uint<8>  uint8_t_hls;

// ============================================================
//  Layer descriptor — written by RISC-V via AXI-Lite
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

    // BRAM base addresses (byte offsets)
    ap_uint<20> weight_base;  // offset into weight BRAM
    ap_uint<20> bias_base;    // offset into weight BRAM (biases stored after weights)
    ap_uint<20> input_base;   // offset into activation BRAM (ping or pong)
    ap_uint<20> output_base;  // offset into activation BRAM (pong or ping)

    // Per-channel requantisation table base (stored in weight BRAM)
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

    // BRAM ports — directly wired to PL block RAMs
    int8_t_hls  weight_bram[WEIGHT_BRAM_BYTES],
    int8_t_hls  act_bram_a[ACT_BUF_BYTES],
    int8_t_hls  act_bram_b[ACT_BUF_BYTES]
);

#endif // ACCEL_H