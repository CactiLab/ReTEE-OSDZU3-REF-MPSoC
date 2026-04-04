#ifndef CONV_ACCEL_DRIVER_H
#define CONV_ACCEL_DRIVER_H

#include <stdint.h>
#include <string.h>
#include <xil_io.h>
#include <xintc.h>
#include <xparameters.h>

/*
 * Memory map — from xparameters.h
 *
 *  AXI-Lite ctrl:  XPAR_CONV_ACCEL_0_BASEADDR
 *  Act BRAM A:     XPAR_ACT_BRAM_CTRL_A_BASEADDR  (64 KB — weights + input)
 *  Act BRAM B:     XPAR_ACT_BRAM_CTRL_B_BASEADDR  (64 KB — output)
 *
 *  No separate weight BRAM.  Weights are packed into act_bram_a
 *  alongside input activations before each layer.
 */
#define ACCEL_CTRL_BASE     XPAR_CONV_ACCEL_0_BASEADDR
#define ACCEL_ACT_A_BASE    XPAR_ACT_BRAM_CTRL_A_BASEADDR
#define ACCEL_ACT_B_BASE    XPAR_ACT_BRAM_CTRL_B_BASEADDR

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

/* HLS interrupt registers */
#define ACCEL_GIE              0x04   /* Global Interrupt Enable */
#define ACCEL_IER              0x08   /* IP Interrupt Enable Register */
#define ACCEL_ISR              0x0C   /* IP Interrupt Status Register */

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

/* Interrupt flag — set by ISR, cleared by accel_wait_done() */
static volatile bool accel_done_flag = false;

static inline void accel_wait_done(void) {
    while (!accel_done_flag)
        ;
}

static void accel_isr(void *callback_ref) {
    (void)callback_ref;
    /* Clear ap_done interrupt in HLS IP */
    accel_write(ACCEL_ISR, accel_read(ACCEL_ISR));
    accel_done_flag = true;
}

/*
 * Register accel interrupt on INTC input 1.
 * Call once after firmware init_platform().
 */
static inline int accel_init_interrupts(void) {
    extern XIntc InterruptController;
    int status;

    status = XIntc_Connect(&InterruptController,
                           XPAR_FABRIC_CONV_ACCEL_0_INTR,
                           (XInterruptHandler)accel_isr, NULL);
    if (status != XST_SUCCESS)
        return status;

    XIntc_Enable(&InterruptController, XPAR_FABRIC_CONV_ACCEL_0_INTR);

    /* Enable HLS IP interrupt output: GIE + ap_done in IER */
    accel_write(ACCEL_GIE, 1);
    accel_write(ACCEL_IER, 1);  /* bit 0 = ap_done */

    return XST_SUCCESS;
}

/* -------------------------------------------------------------------
 *  Per-layer packing into act_bram_a
 *
 *  Layout (packed sequentially, 4-byte aligned):
 *    [0]             weights
 *    [weight_end]    biases    (num_ch × 4 bytes, little-endian int32)
 *    [bias_end]      requant   (num_ch × 8 bytes per channel)
 *    [requant_end]   input activations
 * ------------------------------------------------------------------- */

static inline uint32_t align4(uint32_t x) { return (x + 3) & ~3U; }

typedef struct {
    uint32_t weight_base;
    uint32_t bias_base;
    uint32_t requant_base;
    uint32_t input_base;
} accel_bram_layout_t;

/*
 * Pack one layer's weights + biases + requant + input into act_bram_a.
 * Called from Eval, immediately before accel_run_layer().
 */
static inline accel_bram_layout_t accel_pack_layer(
    const int8_t *weights, uint32_t weight_bytes,
    const int32_t *biases, int num_channels,
    const int32_t *multipliers,
    const int32_t *shifts,
    int8_t act_min,
    int8_t act_max,
    const int8_t *input, uint32_t input_bytes)
{
    accel_bram_layout_t layout;
    volatile uint8_t *bram = (volatile uint8_t *)ACCEL_ACT_A_BASE;
    uint32_t off = 0;

    /* Weights */
    layout.weight_base = off;
    memcpy((void *)(bram + off), weights, weight_bytes);
    off += align4(weight_bytes);

    /* Biases (int32 little-endian) */
    layout.bias_base = off;
    memcpy((void *)(bram + off), biases, num_channels * 4);
    off += align4(num_channels * 4);

    /* Requant (8 bytes per channel, packed as two 32-bit words)
     *   word 0: multiplier (little-endian)
     *   word 1: [0 | act_max | act_min | hls_shift] (little-endian) */
    layout.requant_base = off;
    volatile uint32_t *rdst32 = (volatile uint32_t *)(bram + off);
    uint32_t clamp_hi = ((uint8_t)act_min << 8) | ((uint8_t)act_max << 16);
    for (int c = 0; c < num_channels; c++) {
        rdst32[c * 2 + 0] = (uint32_t)multipliers[c];
        rdst32[c * 2 + 1] = (uint8_t)(31 - shifts[c]) | clamp_hi;
    }
    off += align4(num_channels * 8);

    /* Input activations */
    layout.input_base = off;
    memcpy((void *)(bram + off), input, input_bytes);

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
    uint32_t weight_base;   /* offset in act_bram_a */
    uint32_t bias_base;     /* offset in act_bram_a */
    uint32_t requant_base;  /* offset in act_bram_a */
    uint32_t input_base;    /* offset in act_bram_a */
    uint32_t output_base;   /* offset in act_bram_b */
    int8_t   input_zp;
    int8_t   output_zp;
} accel_layer_desc_t;

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

    /* Read-back fence: force all pending AXI writes to BRAM A to
     * commit before the accelerator starts reading. */
    (void)*(volatile uint32_t *)ACCEL_ACT_A_BASE;

    accel_done_flag = false;
    accel_write(ACCEL_AP_CTRL, AP_START);
    accel_wait_done();
}

#endif /* CONV_ACCEL_DRIVER_H */
