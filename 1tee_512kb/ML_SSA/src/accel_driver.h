// accel_driver.h
void accel_pointwise_conv(
    const int8_t* input,     // pointer in TFLite arena
    const int8_t* filter,    // pointer to weight tensor
    const int32_t* bias,     // pointer to bias tensor
    int8_t* output,          // pointer in TFLite arena
    int H, int W, int C_in, int C_out,
    int32_t input_offset,    // zero-point
    int32_t output_offset,
    int32_t output_multiplier,
    int output_shift
) {
    // Flush cache for DMA coherence
    Xil_DCacheFlushRange((INTPTR)input,  H * W * C_in);
    Xil_DCacheFlushRange((INTPTR)filter, C_out * C_in);

    // Program accelerator via AXI-Lite registers
    ACCEL_REG(INPUT_ADDR)   = (u32)input;
    ACCEL_REG(FILTER_ADDR)  = (u32)filter;
    ACCEL_REG(BIAS_ADDR)    = (u32)bias;
    ACCEL_REG(OUTPUT_ADDR)  = (u32)output;
    ACCEL_REG(DIMS)         = (H * W) | (C_in << 16);
    ACCEL_REG(OUT_CH)       = C_out;
    ACCEL_REG(QUANT_MULT)   = output_multiplier;
    ACCEL_REG(QUANT_SHIFT)  = output_shift;
    ACCEL_REG(CTRL)         = START_BIT;

    // Poll for completion
    while (!(ACCEL_REG(STATUS) & DONE_BIT));

    // Invalidate output cache region
    Xil_DCacheInvalidateRange((INTPTR)output, H * W * C_out);
}