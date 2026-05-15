# MAC Accelerator Design Notes

## Architecture

- **Target device:** xczu3eg-sfvc784-1-e (ZU3EG)
- **Clock:** 100 MHz (10 ns target, 5 ns uncertainty)
- **Interface:** AXI-Lite control registers, 2x BRAM ports (act_bram_a RAM_1P 64KB, act_bram_b RAM_T2P 64KB)
- **Supported ops:** INT8 pointwise (1x1) conv, INT8 depthwise 3x3 conv
- **No separate weight BRAM** — weights are packed into act_bram_a alongside input activations per-layer

## System Overview

- **BYOTEE RISC-V TEE** on Xilinx ZU3EG (Zynq UltraScale+)
- **RISC-V soft processor:** MicroBlaze V (microblaze_riscv), rv32imf, no D-cache, no I-cache
- **TFLM inference:** Person detection (MobileNet 0.25, INT8, 96×96 grayscale)
- **Toolchain:** Vitis 2025.2
- **ELF dynamic loading:** Linux ARM PS loads ML_SSA.elf into RISC-V PL soft processor
- **IPC:** Shared OCM at 0xFFFC0000 between ARM Linux and RISC-V

## Memory Map

| Region | Address | Size |
|--------|---------|------|
| BRAM (code + data) | 0x00000000 | 704 KB (0xB0000) |
| act_bram_a (weights + input) | 0xC1000000 | 64 KB |
| act_bram_b (output) | 0xC2000000 | 64 KB |
| OCM (IPC) | 0xFFFC0000 | 256 KB |

## Quantisation Convention

The accelerator matches TFLite Micro's single-rounding `MultiplyByQuantizedMultiplier`:

```
result = (acc * multiplier + round) >> total_shift
```

- **multiplier:** Q0.31 format, stored as int32 in weight BRAM
- **shift:** stored in HLS convention (`hls_shift = 31 - tflite_shift`), so the HLS code does a direct `>> hls_shift`
- **Input zero point:** subtracted from each activation before multiply (`(in - input_zp) * weight`), matching TFLite's `filter * (input + input_offset)` where `input_offset = -input_zp`
- **Padding (depthwise):** fills with `input_zp`, so after subtraction the contribution is zero — equivalent to TFLite's skip-out-of-bounds behaviour

The driver must convert TFLite shift to HLS shift: `hls_shift = 31 - tflite_shift`.

## BRAM Packing Layout

Per-layer, packed sequentially into act_bram_a (4-byte aligned):

```
[0]             weights
[weight_end]    biases    (num_ch × 4 bytes, little-endian int32)
[bias_end]      requant   (num_ch × 8 bytes per channel)
[requant_end]   input activations
```

Requant entry (8 bytes per channel):
- Word 0: multiplier (32-bit)
- Word 1: `[0 | act_max | act_min | hls_shift]` (little-endian)

## Accelerator Constraints

- INT8 quantised (per-channel)
- Conv2D: 1×1 (pointwise) only — caller pre-strides input
- DepthwiseConv2D: 3×3, stride 1 or 2, SAME padding
- Max spatial: 48×48, max channels: 256
- Activation buffer: 64 KB each (input / output)
- HLS parameters: PW_TILE_OC=16, DW_PARALLEL=32, ACC_DEPTH=4

## HW Dispatch Strategy

### Conv2D
- **Untiled:** full layer fits in both BRAMs → single HW call
- **OC tiled:** input fits in BRAM A but full output doesn't → loop over OC tiles (tile_oc channels per call), strided readback interleaves tiles in output buffer
- **SW fallback:** non-1×1 filters, spatial > 48, channels > 256

### DepthwiseConv2D
- **Direct HW:** 3×3 kernel, dm=1, stride 1 or 2, fits in BRAMs
- **Im2col HW:** dm>1 + in_c=1 → extract fH×fW patches into BRAM A as "channels", transpose DW filter to PW layout, run as 1×1 pointwise conv
- **SW fallback:** non-3×3 filters, spatial > 48

## Key Files

| File | Purpose |
|------|---------|
| `mac_accel/accel.cpp` | HLS accelerator top-level + pointwise/depthwise kernels |
| `mac_accel/accel.h` | Accelerator parameters, types, top-level declaration |
| `mac_accel/accel_tb.cpp` | C-sim testbench using TFLM reference ops |
| `ML_SSA/src/custom_ops.cpp` | TFLM Conv2D/DWConv2D kernels with HW dispatch |
| `ML_SSA/src/custom_ops.h` | Registration functions for accel kernels |
| `ML_SSA/src/conv_accel_driver.h` | Low-level driver: BRAM packing, register programming, interrupt handling |
| `ML_SSA/src/main.cpp` | Module entry point: model load, inference loop, OCM IPC |
| `ML_SSA/src/lscript.ld` | Linker script for RISC-V module |
| `ML_SSA/src/UserConfig.cmake` | Build config: TFLM linkage, compiler flags |
| `riscv_firmware/src/main.c` | RISC-V firmware: ELF loader, IPC handler |

## Build Notes

### TFLM Library
- Built from `../tflm-tree/` (sibling of `1tee_accel/` in the byotee_riscv repo) via Makefile
- RISC-V hard-float variant: `build-riscv-hfloat/libtflm.a` (rv32imf)
- Cortex-A53 variant: `build-cortexa-neon/libtflm.a` (aarch64 ARMv8-A NEON)
- Compile definitions: `TF_LITE_STATIC_MEMORY`, `TF_LITE_MCU_DEBUG_LOG`, `NDEBUG`
- **Critical:** ML_SSA must also define `TF_LITE_STATIC_MEMORY` — this changes `TfLiteTensor`/`TfLiteNode` struct layouts. Mismatching this causes garbage tensor dimensions.

### ML_SSA Build (UserConfig.cmake)
- Links against: `../../riscv_firmware/build/riscv_firmware.elf` (for firmware symbols)
- Links TFLM from: `../../../tflm-tree/build-riscv-hfloat/`
- `.init_array`/`.fini_array` sections are `/DISCARD/`ed — module is called by entry point only
- Optimisation: `-Os -fno-exceptions -fno-rtti -ffunction-sections -fdata-sections`

### HLS Testbench
- Compiled by Vitis HLS Clang (x86 C-simulation)
- Uses TFLM reference ops (`ConvPerChannel`, `DepthwiseConvPerChannel`) as golden reference
- Requires include paths: `<tflm-tree>/`, `<tflm-tree>/third_party/gemmlowp`, `<tflm-tree>/third_party/flatbuffers/include`
- Requires defines: `NDEBUG`, `TF_LITE_STRIP_ERROR_STRINGS`, `TFLITE_SINGLE_ROUNDING=1`

## Bugs Found & Fixed

### 1. TF_LITE_STATIC_MEMORY ABI Mismatch
- **Symptom:** Garbage tensor dimensions during Prepare
- **Cause:** ML_SSA build didn't define `TF_LITE_STATIC_MEMORY` while TFLM library was compiled with it, causing different `TfLiteTensor` struct layouts
- **Fix:** Added `TF_LITE_STATIC_MEMORY` to `UserConfig.cmake` compile definitions

### 2. Wrong BRAM Addresses
- **Symptom:** Hang after first HW layer
- **Cause:** Driver had hardcoded wrong addresses (A=0xC2000000, B=0xC2010000)
- **Fix:** Use `xparameters.h` macros directly (`XPAR_ACT_BRAM_CTRL_A_BASEADDR`, `XPAR_ACT_BRAM_CTRL_B_BASEADDR`)

### 3. Requant Shift Off by 31 Bits
- **Symptom:** All HW outputs saturated to ±118 or 0
- **Cause:** Driver used `hls_shift = -shifts[c]` instead of `hls_shift = 31 - tflite_shift`
- **Fix:** Changed to `(uint8_t)(31 - shifts[c])` in `conv_accel_driver.h` and `custom_ops.cpp` im2col path

### 4. HLS Stride-2 Depthwise Padding Bug
- **Symptom:** Per-layer test showed max_diff=95–183 on stride=2 DW layers
- **Cause:** `accel.cpp` line 298 hardcoded `kh - 1` for padding offset, only correct for stride=1 SAME padding. Stride=2 SAME padding on 3×3 kernel needs pad_top=0.
- **Fix:** Compute `pad_top`/`pad_left` dynamically from dimensions: `pad_h = (out_h-1)*stride + 3 - in_h`, `pad_top = pad_h / 2`. Changed `kh - 1` → `kh - pad_top`, `kw - 1` → `kw - pad_left`. Added `pad_same` parameter to `depthwise_conv3x3`.

### 5. MicroProfiler Freeze
- **Symptom:** Freeze after ~100 inferences
- **Cause:** MicroProfiler (80KB in OCM, never zeroed) accumulating events until overflow
- **Fix:** Removed profiler entirely

## Performance History

| Change | Ticks | Inference Time | FPS |
|--------|-------|---------------|-----|
| Initial (all SW) | 92.3M | ~923ms | ~1 |
| Remove eval prints + 32-bit requant | 79.5M | ~795ms | ~1.3 |
| Conv2D OC tiling (all PW in HW) | 26.4M | ~264ms | ~3.8 |
| DWConv im2col (first DW in HW) | 7.2M | ~72ms | ~14 |
| Stride-2 DW fallback to SW (correct) | ~25M | ~255ms | ~3.9 |
| **Pending: HLS stride-2 fix + resynth** | ~7M est | ~72ms est | ~14 est |

## Pointwise Kernel Details

### Caller pre-strides the input

The pointwise kernel takes a flat `spatial` pixel count and treats input/output as `spatial x channels` arrays. It has no concept of height, width, or stride. For strided 1x1 convolutions, the caller must rearrange the activation buffer to contain only the strided pixels before invoking the accelerator. This simplifies the address math and eliminates the multiply-by-stride in the hot loop.

### Partial sums for MAC parallelism

The original design used `PIPELINE II=1` + `UNROLL factor=128` on a single accumulator `sum`. This created a carried dependency: 128 products all feed into one `sum`, and the next group of 128 can't start until the reduction tree completes. HLS could not achieve any II up to 127.

Fix: split into `partial[MAC_PARALLEL]` independent accumulators. `MAC_OUTER` iterates in chunks of 128 with `PIPELINE II=1`; `MAC_INNER` is fully `UNROLL`ed (128 parallel DSP MACs). Each `partial[p]` only depends on itself across iterations, with reuse distance = `ceil(in_c / 128)`. A final `REDUCE` step sums all partials + bias. Uses 128 DSPs at ~37% of ZU3 budget.

## Depthwise Kernel Details

### DW_PARALLEL = 16 (not MAC_PARALLEL = 128)

The original depthwise kernel tried to unroll 128 channels in parallel (`MAC_PARALLEL`), but:

1. **Variable trip count** (`tile_size = min(MAC_PARALLEL, in_c - c_base)`) prevented HLS from statically unrolling `DW_MAC`, `LOAD_DW_BIAS`, and `DW_STORE`. This generated 128-wide mux networks (54,230 LUT in multiplexers alone) and 80K registers.
2. **`w_cache[9][256]` with `cyclic factor=128`** created 1,152 two-element RAMs with 128:1 sparse mux select logic.
3. **Total LUT: 102%** for depthwise alone — design could not be placed.

Fix: separate `DW_PARALLEL = 16` constant. All inner loops iterate exactly `DW_PARALLEL` times (fixed trip count). The `DW_MAC` loop is `PIPELINE II=1` (not UNROLL) — each cycle processes one channel, and `acc[t]` reuse distance of 16 exceeds DSP latency (~4 cycles). Uses only 8 DSPs and ~12% LUT.

### Preloaded bias and requant caches

The per-pixel `LOAD_DW_BIAS` and `DW_STORE` loops originally read directly from `weight_bram` (ROM_2P, 2 ports). Bias needs 4 reads per channel (II=2), requant needs 7 reads per channel (II=4).

Fix: preload biases and requant parameters into local arrays (`bias_cache`, `rq_mult_cache`, `rq_shift_cache`, `rq_amin_cache`, `rq_amax_cache`) once per layer invocation. These are partitioned by `DW_PARALLEL`, giving unlimited read ports. The per-pixel loops then read only from local memory, achieving II=1.

The preload loops themselves still hit II>1 on `weight_bram`, but they run once per frame, not per pixel.

### Weight preload loop order

`LOAD_DW_WEIGHTS` iterates kernel position `k` (outer) then channel `c` (inner, pipelined). This gives 1 `weight_bram` read per cycle (II=1). The original order (`c` outer, `k` inner) tried to read 9 weights per cycle through 2 ports, forcing II=5.

## Resource Utilisation (post-fix)

| Resource | Used    | Available | % |
|----------|---------|-----------|---|
| LUT      | 40,486  | 70,560    | 57 |
| FF       | 29,003  | 141,120   | 20 |
| DSP      | 142     | 360       | 39 |
| BRAM     | 0       | 432       | 0  |

Depthwise went from 72,660 LUT (102%) to 8,764 LUT (12%).
