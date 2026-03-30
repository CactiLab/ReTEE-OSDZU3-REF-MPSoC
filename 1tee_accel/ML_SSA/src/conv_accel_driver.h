#ifndef CONV_ACCEL_DRIVER_H
#define CONV_ACCEL_DRIVER_H

#include <stdint.h>
#include <string.h>
#include <xil_io.h>

/*
 * Memory map — from Vivado address editor / xparameters.h
 *
 *  AXI-Lite ctrl:  0xC0000000  (register offsets from xconv_accel_hw.h)
 *  Weight BRAM:    0xC1000000  (48 KB — loaded per-layer)
 *  Act BRAM A:     0xC2000000  (64 KB, input side)
 *  Act BRAM B:     0xC2010000  (64 KB, output side)
 */
#define ACCEL_CTRL_BASE     0xC0000000U
#define ACCEL_WEIGHT_BASE   0xC1000000U
#define ACCEL_ACT_A_BASE    0xC2000000U
#define ACCEL_ACT_B_BASE    0xC2010000U

#define ACCEL_WEIGHT_SIZE   (48 * 1024)
#define ACCEL_ACT_A_SIZE    (64 * 1024)
#define ACCEL_ACT_B_SIZE    (64 * 1024)

/* AXI-Lite register offsets (from xconv_accel_hw.h) */
#define ACCEL_AP_CTRL           0x00
#define ACCEL_REG_IN_H          0x10
#define ACCEL_REG_IN_W          0x18
#define ACCEL_REG_IN_C          0x20
#define ACCEL_REG_OUT_H         0x28
#define ACCEL_REG_OUT_W         0x30
#define ACCEL_REG_OUT_C         0x38
#define ACCEL_REG_STRIDE        0x40
#define ACCEL_REG_PAD_SAME      0x48
#define ACCEL_REG_IS_DEPTHWISE  0x50
#define ACCEL_REG_RELU6_EN      0x58
#define ACCEL_REG_WEIGHT_BASE   0x60
#define ACCEL_REG_BIAS_BASE     0x68
#define ACCEL_REG_INPUT_BASE    0x70
#define ACCEL_REG_OUTPUT_BASE   0x78
#define ACCEL_REG_REQUANT_BASE  0x80
#define ACCEL_REG_INPUT_ZP      0x88
#define ACCEL_REG_OUTPUT_ZP     0x90

/* AP_CTRL bits */
#define AP_START    (1U << 0)
#define AP_DONE     (1U << 1)
#define AP_IDLE     (1U << 2)

static inline void accel_write(uint32_t offset, uint32_t val) {
    Xil_Out32(ACCEL_CTRL_BASE + offset, val);
}

static inline uint32_t accel_read(uint32_t offset) {
    return Xil_In32(ACCEL_CTRL_BASE + offset);
}

static inline void accel_wait_idle(void) {
    while (!(accel_read(ACCEL_AP_CTRL) & AP_IDLE))
        ;
}

static inline void accel_wait_done(void) {
    while (!(accel_read(ACCEL_AP_CTRL) & AP_DONE))
        ;
}

/* -------------------------------------------------------------------
 *  Per-layer weight packing
 *
 *  Weight BRAM is reused every layer.  Layout for each invocation:
 *    [0]             weights  (oc*ic bytes for pw, 9*c bytes for dw)
 *    [weight_end]    biases   (oc*4 bytes, little-endian int32)
 *    [bias_end]      requant  (oc*8 bytes: int32 mult, int8 shift,
 *                              int8 act_min, int8 act_max, 1 pad)
 * ------------------------------------------------------------------- */

/* Align to 4-byte boundary */
static inline uint32_t align4(uint32_t x) { return (x + 3) & ~3U; }

typedef struct {
    uint32_t weight_base;
    uint32_t bias_base;
    uint32_t requant_base;
} accel_weight_layout_t;

/*
 * Pack one layer's weights + biases + requant into weight BRAM.
 * Called from Eval, immediately before accel_run_layer().
 *
 * Returns the BRAM offsets so the caller can set the register fields.
 */
static inline accel_weight_layout_t accel_pack_layer(
    const int8_t *weights, uint32_t weight_bytes,
    const int32_t *biases, int num_channels,
    const int32_t *multipliers,
    const int32_t *shifts,
    int8_t act_min,
    int8_t act_max)
{
    accel_weight_layout_t layout;
    uint32_t off = 0;

    /* Weights */
    layout.weight_base = off;
    volatile int8_t *wdst = (volatile int8_t *)(ACCEL_WEIGHT_BASE + off);
    memcpy((void *)wdst, weights, weight_bytes);
    off += align4(weight_bytes);

    /* Biases (int32 little-endian) */
    layout.bias_base = off;
    volatile int8_t *bdst = (volatile int8_t *)(ACCEL_WEIGHT_BASE + off);
    memcpy((void *)bdst, biases, num_channels * 4);
    off += align4(num_channels * 4);

    /* Requant (8 bytes per channel) */
    layout.requant_base = off;
    volatile uint8_t *rdst = (volatile uint8_t *)(ACCEL_WEIGHT_BASE + off);
    for (int c = 0; c < num_channels; c++) {
        uint32_t m = (uint32_t)multipliers[c];
        /* TFLite shift is negative (right-shift amount).
         * HLS shift = -tflite_shift (positive right-shift). */
        int8_t hls_shift = (int8_t)(-shifts[c]);

        int i = c * 8;
        rdst[i + 0] = (uint8_t)(m >>  0);
        rdst[i + 1] = (uint8_t)(m >>  8);
        rdst[i + 2] = (uint8_t)(m >> 16);
        rdst[i + 3] = (uint8_t)(m >> 24);
        rdst[i + 4] = (uint8_t)hls_shift;
        rdst[i + 5] = (uint8_t)act_min;
        rdst[i + 6] = (uint8_t)act_max;
        rdst[i + 7] = 0;
    }

    return layout;
}

/* -------------------------------------------------------------------
 *  Layer execution
 * ------------------------------------------------------------------- */

typedef struct {
    uint8_t  in_h, in_w;
    uint16_t in_c;
    uint8_t  out_h, out_w;
    uint16_t out_c;
    uint8_t  stride;
    uint8_t  pad_same;
    uint8_t  is_depthwise;
    uint8_t  relu6_en;
    uint32_t weight_base;   /* offset in weight BRAM */
    uint32_t bias_base;
    uint32_t requant_base;
    uint32_t input_base;    /* offset in act BRAM A */
    uint32_t output_base;   /* offset in act BRAM B */
    int8_t   input_zp;
    int8_t   output_zp;
} accel_layer_desc_t;

/*
 * Copy activations from a CPU buffer into act BRAM A at the given offset.
 */
static inline void accel_load_input(const int8_t *src, uint32_t act_offset,
                                     uint32_t nbytes) {
    volatile int8_t *dst = (volatile int8_t *)(ACCEL_ACT_A_BASE + act_offset);
    memcpy((void *)dst, src, nbytes);
}

/*
 * Copy results from act BRAM B back to a CPU buffer.
 */
static inline void accel_read_output(int8_t *dst, uint32_t act_offset,
                                      uint32_t nbytes) {
    volatile int8_t *src = (volatile int8_t *)(ACCEL_ACT_B_BASE + act_offset);
    memcpy(dst, (const void *)src, nbytes);
}

/*
 * Program registers and fire the accelerator for one layer.
 * Blocks until done.
 */
static inline void accel_run_layer(const accel_layer_desc_t *d) {
    accel_wait_idle();

    accel_write(ACCEL_REG_IN_H,         d->in_h);
    accel_write(ACCEL_REG_IN_W,         d->in_w);
    accel_write(ACCEL_REG_IN_C,         d->in_c);
    accel_write(ACCEL_REG_OUT_H,        d->out_h);
    accel_write(ACCEL_REG_OUT_W,        d->out_w);
    accel_write(ACCEL_REG_OUT_C,        d->out_c);
    accel_write(ACCEL_REG_STRIDE,       d->stride);
    accel_write(ACCEL_REG_PAD_SAME,     d->pad_same);
    accel_write(ACCEL_REG_IS_DEPTHWISE, d->is_depthwise);
    accel_write(ACCEL_REG_RELU6_EN,     d->relu6_en);
    accel_write(ACCEL_REG_WEIGHT_BASE,  d->weight_base);
    accel_write(ACCEL_REG_BIAS_BASE,    d->bias_base);
    accel_write(ACCEL_REG_INPUT_BASE,   d->input_base);
    accel_write(ACCEL_REG_OUTPUT_BASE,  d->output_base);
    accel_write(ACCEL_REG_REQUANT_BASE, d->requant_base);
    accel_write(ACCEL_REG_INPUT_ZP,     (uint32_t)(uint8_t)d->input_zp);
    accel_write(ACCEL_REG_OUTPUT_ZP,    (uint32_t)(uint8_t)d->output_zp);

    /* Start */
    accel_write(ACCEL_AP_CTRL, AP_START);

    /* Wait for completion */
    accel_wait_done();
}

#endif /* CONV_ACCEL_DRIVER_H */
