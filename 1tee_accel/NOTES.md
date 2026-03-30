# MAC Accelerator Design Notes

## Architecture

- **Target device:** xczu3eg-sfvc784-1-e (ZU3EG)
- **Clock:** 100 MHz (10 ns target, 5 ns uncertainty)
- **Interface:** AXI-Lite control registers, 3x BRAM ports (weight ROM_2P, activation RAM_2P x2)
- **Supported ops:** INT8 pointwise (1x1) conv, INT8 depthwise 3x3 conv

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

## Pointwise Kernel

### Caller pre-strides the input

The pointwise kernel takes a flat `spatial` pixel count and treats input/output as `spatial x channels` arrays. It has no concept of height, width, or stride. For strided 1x1 convolutions, the caller must rearrange the activation buffer to contain only the strided pixels before invoking the accelerator. This simplifies the address math and eliminates the multiply-by-stride in the hot loop.

### Partial sums for MAC parallelism

The original design used `PIPELINE II=1` + `UNROLL factor=128` on a single accumulator `sum`. This created a carried dependency: 128 products all feed into one `sum`, and the next group of 128 can't start until the reduction tree completes. HLS could not achieve any II up to 127.

Fix: split into `partial[MAC_PARALLEL]` independent accumulators. `MAC_OUTER` iterates in chunks of 128 with `PIPELINE II=1`; `MAC_INNER` is fully `UNROLL`ed (128 parallel DSP MACs). Each `partial[p]` only depends on itself across iterations, with reuse distance = `ceil(in_c / 128)`. A final `REDUCE` step sums all partials + bias. Uses 128 DSPs at ~37% of ZU3 budget.

## Depthwise Kernel

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
