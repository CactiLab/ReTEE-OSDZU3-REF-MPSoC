#ifndef CONV_ACCEL_H
#define CONV_ACCEL_H

#include <stdint.h>
#include "xconv_accel_hw.h"

/* ----------------------------------------------------------------
 *  Memory-mapped base addresses (from hardware address map)
 * ---------------------------------------------------------------- */
#define CONV_ACCEL_BASE   0xC0000000
#define WEIGHT_BRAM_BASE  0xC1000000
#define ACT_BRAM_A_BASE   0xC2000000
#define ACT_BRAM_B_BASE   0xC2010000

/* BRAM sizes (bytes) */
#define WEIGHT_BRAM_SIZE  (256 * 1024)
#define ACT_BRAM_A_SIZE   (64 * 1024)
#define ACT_BRAM_B_SIZE   (64 * 1024)

/* ----------------------------------------------------------------
 *  Register access helpers
 * ---------------------------------------------------------------- */
static inline void conv_reg_write(uint32_t offset, uint32_t val)
{
    *(volatile uint32_t *)(CONV_ACCEL_BASE + offset) = val;
}

static inline uint32_t conv_reg_read(uint32_t offset)
{
    return *(volatile uint32_t *)(CONV_ACCEL_BASE + offset);
}

/* ----------------------------------------------------------------
 *  Accelerator control
 * ---------------------------------------------------------------- */
static inline void conv_accel_start(void)
{
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_AP_CTRL, 0x01);
}

static inline int conv_accel_is_done(void)
{
    return (conv_reg_read(XCONV_ACCEL_CTRL_ADDR_AP_CTRL) & 0x02) != 0;
}

static inline int conv_accel_is_idle(void)
{
    return (conv_reg_read(XCONV_ACCEL_CTRL_ADDR_AP_CTRL) & 0x04) != 0;
}

static inline void conv_accel_wait(void)
{
    while (!conv_accel_is_done())
        ;
}

/* ----------------------------------------------------------------
 *  Layer descriptor programming
 * ---------------------------------------------------------------- */
static inline void conv_accel_set_layer(
    uint8_t  in_h,  uint8_t  in_w,  uint16_t in_c,
    uint8_t  out_h, uint8_t  out_w, uint16_t out_c,
    uint8_t  stride,
    uint8_t  pad_same,
    uint8_t  is_depthwise,
    uint8_t  relu6_en,
    uint32_t weight_base,
    uint32_t bias_base,
    uint32_t input_base,
    uint32_t output_base,
    uint32_t requant_base,
    int8_t   input_zp,
    int8_t   output_zp)
{
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_IN_H_DATA,         in_h);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_IN_W_DATA,         in_w);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_IN_C_DATA,         in_c);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_OUT_H_DATA,        out_h);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_OUT_W_DATA,        out_w);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_OUT_C_DATA,        out_c);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_STRIDE_DATA,       stride);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_PAD_SAME_DATA,     pad_same);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_IS_DEPTHWISE_DATA, is_depthwise);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_RELU6_EN_DATA,     relu6_en);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_WEIGHT_BASE_DATA,  weight_base);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_BIAS_BASE_DATA,    bias_base);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_INPUT_BASE_DATA,   input_base);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_OUTPUT_BASE_DATA,  output_base);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_REQUANT_BASE_DATA, requant_base);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_INPUT_ZP_DATA,     (uint32_t)(uint8_t)input_zp);
    conv_reg_write(XCONV_ACCEL_CTRL_ADDR_OUTPUT_ZP_DATA,    (uint32_t)(uint8_t)output_zp);
}

/* ----------------------------------------------------------------
 *  Convenience: program layer + start + wait
 * ---------------------------------------------------------------- */
static inline void conv_accel_run_layer(
    uint8_t  in_h,  uint8_t  in_w,  uint16_t in_c,
    uint8_t  out_h, uint8_t  out_w, uint16_t out_c,
    uint8_t  stride,
    uint8_t  pad_same,
    uint8_t  is_depthwise,
    uint8_t  relu6_en,
    uint32_t weight_base,
    uint32_t bias_base,
    uint32_t input_base,
    uint32_t output_base,
    uint32_t requant_base,
    int8_t   input_zp,
    int8_t   output_zp)
{
    conv_accel_set_layer(
        in_h, in_w, in_c, out_h, out_w, out_c,
        stride, pad_same, is_depthwise, relu6_en,
        weight_base, bias_base, input_base, output_base, requant_base,
        input_zp, output_zp);
    conv_accel_start();
    conv_accel_wait();
}

/* ----------------------------------------------------------------
 *  BRAM access helpers
 * ---------------------------------------------------------------- */
static inline volatile int8_t *weight_bram(void)
{
    return (volatile int8_t *)WEIGHT_BRAM_BASE;
}

static inline volatile int8_t *act_bram_a(void)
{
    return (volatile int8_t *)ACT_BRAM_A_BASE;
}

static inline volatile int8_t *act_bram_b(void)
{
    return (volatile int8_t *)ACT_BRAM_B_BASE;
}

#endif /* CONV_ACCEL_H */
