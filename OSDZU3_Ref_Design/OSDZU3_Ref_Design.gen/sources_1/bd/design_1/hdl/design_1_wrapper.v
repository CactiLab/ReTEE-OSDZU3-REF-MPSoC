//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
//Date        : Sat Sep  6 13:55:55 2025
//Host        : e-ubuntu running 64-bit Ubuntu 24.04.3 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (CLICK_I2C_scl_io,
    CLICK_I2C_sda_io,
    CLICK_PWM,
    CLICK_UART_RX,
    CLICK_UART_TX,
    PMOD_A_GPIO_tri_io,
    PMOD_A_UART_CTSn,
    PMOD_A_UART_RTSn,
    PMOD_A_UART_RX,
    PMOD_A_UART_TX,
    PMOD_B_GPIO_tri_io,
    PMOD_B_I2C_scl_io,
    PMOD_B_I2C_sda_io,
    backlight_dctrl,
    dip_switches_8bits_tri_i,
    led_8bits_tri_o,
    lvds_display_clk_n,
    lvds_display_clk_p,
    lvds_display_data_n,
    lvds_display_data_p,
    lvds_display_iic_scl_io,
    lvds_display_iic_sda_io,
    lvds_display_reset,
    lvds_display_standby,
    lvds_display_touch_irq_tri_io,
    lvds_display_touch_reset,
    push_buttons_3bits_tri_i,
    pwr_en_ctrl);
  inout CLICK_I2C_scl_io;
  inout CLICK_I2C_sda_io;
  output CLICK_PWM;
  input CLICK_UART_RX;
  output CLICK_UART_TX;
  inout [3:0]PMOD_A_GPIO_tri_io;
  input PMOD_A_UART_CTSn;
  output PMOD_A_UART_RTSn;
  input PMOD_A_UART_RX;
  output PMOD_A_UART_TX;
  inout [5:0]PMOD_B_GPIO_tri_io;
  inout PMOD_B_I2C_scl_io;
  inout PMOD_B_I2C_sda_io;
  output backlight_dctrl;
  input [7:0]dip_switches_8bits_tri_i;
  output [7:0]led_8bits_tri_o;
  output lvds_display_clk_n;
  output lvds_display_clk_p;
  output [3:0]lvds_display_data_n;
  output [3:0]lvds_display_data_p;
  inout lvds_display_iic_scl_io;
  inout lvds_display_iic_sda_io;
  output [0:0]lvds_display_reset;
  output [0:0]lvds_display_standby;
  inout [0:0]lvds_display_touch_irq_tri_io;
  output [0:0]lvds_display_touch_reset;
  input [2:0]push_buttons_3bits_tri_i;
  output [0:0]pwr_en_ctrl;

  wire CLICK_I2C_scl_i;
  wire CLICK_I2C_scl_io;
  wire CLICK_I2C_scl_o;
  wire CLICK_I2C_scl_t;
  wire CLICK_I2C_sda_i;
  wire CLICK_I2C_sda_io;
  wire CLICK_I2C_sda_o;
  wire CLICK_I2C_sda_t;
  wire CLICK_PWM;
  wire CLICK_UART_RX;
  wire CLICK_UART_TX;
  wire [0:0]PMOD_A_GPIO_tri_i_0;
  wire [1:1]PMOD_A_GPIO_tri_i_1;
  wire [2:2]PMOD_A_GPIO_tri_i_2;
  wire [3:3]PMOD_A_GPIO_tri_i_3;
  wire [0:0]PMOD_A_GPIO_tri_io_0;
  wire [1:1]PMOD_A_GPIO_tri_io_1;
  wire [2:2]PMOD_A_GPIO_tri_io_2;
  wire [3:3]PMOD_A_GPIO_tri_io_3;
  wire [0:0]PMOD_A_GPIO_tri_o_0;
  wire [1:1]PMOD_A_GPIO_tri_o_1;
  wire [2:2]PMOD_A_GPIO_tri_o_2;
  wire [3:3]PMOD_A_GPIO_tri_o_3;
  wire [0:0]PMOD_A_GPIO_tri_t_0;
  wire [1:1]PMOD_A_GPIO_tri_t_1;
  wire [2:2]PMOD_A_GPIO_tri_t_2;
  wire [3:3]PMOD_A_GPIO_tri_t_3;
  wire PMOD_A_UART_CTSn;
  wire PMOD_A_UART_RTSn;
  wire PMOD_A_UART_RX;
  wire PMOD_A_UART_TX;
  wire [0:0]PMOD_B_GPIO_tri_i_0;
  wire [1:1]PMOD_B_GPIO_tri_i_1;
  wire [2:2]PMOD_B_GPIO_tri_i_2;
  wire [3:3]PMOD_B_GPIO_tri_i_3;
  wire [4:4]PMOD_B_GPIO_tri_i_4;
  wire [5:5]PMOD_B_GPIO_tri_i_5;
  wire [0:0]PMOD_B_GPIO_tri_io_0;
  wire [1:1]PMOD_B_GPIO_tri_io_1;
  wire [2:2]PMOD_B_GPIO_tri_io_2;
  wire [3:3]PMOD_B_GPIO_tri_io_3;
  wire [4:4]PMOD_B_GPIO_tri_io_4;
  wire [5:5]PMOD_B_GPIO_tri_io_5;
  wire [0:0]PMOD_B_GPIO_tri_o_0;
  wire [1:1]PMOD_B_GPIO_tri_o_1;
  wire [2:2]PMOD_B_GPIO_tri_o_2;
  wire [3:3]PMOD_B_GPIO_tri_o_3;
  wire [4:4]PMOD_B_GPIO_tri_o_4;
  wire [5:5]PMOD_B_GPIO_tri_o_5;
  wire [0:0]PMOD_B_GPIO_tri_t_0;
  wire [1:1]PMOD_B_GPIO_tri_t_1;
  wire [2:2]PMOD_B_GPIO_tri_t_2;
  wire [3:3]PMOD_B_GPIO_tri_t_3;
  wire [4:4]PMOD_B_GPIO_tri_t_4;
  wire [5:5]PMOD_B_GPIO_tri_t_5;
  wire PMOD_B_I2C_scl_i;
  wire PMOD_B_I2C_scl_io;
  wire PMOD_B_I2C_scl_o;
  wire PMOD_B_I2C_scl_t;
  wire PMOD_B_I2C_sda_i;
  wire PMOD_B_I2C_sda_io;
  wire PMOD_B_I2C_sda_o;
  wire PMOD_B_I2C_sda_t;
  wire backlight_dctrl;
  wire [7:0]dip_switches_8bits_tri_i;
  wire [7:0]led_8bits_tri_o;
  wire lvds_display_clk_n;
  wire lvds_display_clk_p;
  wire [3:0]lvds_display_data_n;
  wire [3:0]lvds_display_data_p;
  wire lvds_display_iic_scl_i;
  wire lvds_display_iic_scl_io;
  wire lvds_display_iic_scl_o;
  wire lvds_display_iic_scl_t;
  wire lvds_display_iic_sda_i;
  wire lvds_display_iic_sda_io;
  wire lvds_display_iic_sda_o;
  wire lvds_display_iic_sda_t;
  wire [0:0]lvds_display_reset;
  wire [0:0]lvds_display_standby;
  wire [0:0]lvds_display_touch_irq_tri_i_0;
  wire [0:0]lvds_display_touch_irq_tri_io_0;
  wire [0:0]lvds_display_touch_irq_tri_o_0;
  wire [0:0]lvds_display_touch_irq_tri_t_0;
  wire [0:0]lvds_display_touch_reset;
  wire [2:0]push_buttons_3bits_tri_i;
  wire [0:0]pwr_en_ctrl;

  IOBUF CLICK_I2C_scl_iobuf
       (.I(CLICK_I2C_scl_o),
        .IO(CLICK_I2C_scl_io),
        .O(CLICK_I2C_scl_i),
        .T(CLICK_I2C_scl_t));
  IOBUF CLICK_I2C_sda_iobuf
       (.I(CLICK_I2C_sda_o),
        .IO(CLICK_I2C_sda_io),
        .O(CLICK_I2C_sda_i),
        .T(CLICK_I2C_sda_t));
  IOBUF PMOD_A_GPIO_tri_iobuf_0
       (.I(PMOD_A_GPIO_tri_o_0),
        .IO(PMOD_A_GPIO_tri_io[0]),
        .O(PMOD_A_GPIO_tri_i_0),
        .T(PMOD_A_GPIO_tri_t_0));
  IOBUF PMOD_A_GPIO_tri_iobuf_1
       (.I(PMOD_A_GPIO_tri_o_1),
        .IO(PMOD_A_GPIO_tri_io[1]),
        .O(PMOD_A_GPIO_tri_i_1),
        .T(PMOD_A_GPIO_tri_t_1));
  IOBUF PMOD_A_GPIO_tri_iobuf_2
       (.I(PMOD_A_GPIO_tri_o_2),
        .IO(PMOD_A_GPIO_tri_io[2]),
        .O(PMOD_A_GPIO_tri_i_2),
        .T(PMOD_A_GPIO_tri_t_2));
  IOBUF PMOD_A_GPIO_tri_iobuf_3
       (.I(PMOD_A_GPIO_tri_o_3),
        .IO(PMOD_A_GPIO_tri_io[3]),
        .O(PMOD_A_GPIO_tri_i_3),
        .T(PMOD_A_GPIO_tri_t_3));
  IOBUF PMOD_B_GPIO_tri_iobuf_0
       (.I(PMOD_B_GPIO_tri_o_0),
        .IO(PMOD_B_GPIO_tri_io[0]),
        .O(PMOD_B_GPIO_tri_i_0),
        .T(PMOD_B_GPIO_tri_t_0));
  IOBUF PMOD_B_GPIO_tri_iobuf_1
       (.I(PMOD_B_GPIO_tri_o_1),
        .IO(PMOD_B_GPIO_tri_io[1]),
        .O(PMOD_B_GPIO_tri_i_1),
        .T(PMOD_B_GPIO_tri_t_1));
  IOBUF PMOD_B_GPIO_tri_iobuf_2
       (.I(PMOD_B_GPIO_tri_o_2),
        .IO(PMOD_B_GPIO_tri_io[2]),
        .O(PMOD_B_GPIO_tri_i_2),
        .T(PMOD_B_GPIO_tri_t_2));
  IOBUF PMOD_B_GPIO_tri_iobuf_3
       (.I(PMOD_B_GPIO_tri_o_3),
        .IO(PMOD_B_GPIO_tri_io[3]),
        .O(PMOD_B_GPIO_tri_i_3),
        .T(PMOD_B_GPIO_tri_t_3));
  IOBUF PMOD_B_GPIO_tri_iobuf_4
       (.I(PMOD_B_GPIO_tri_o_4),
        .IO(PMOD_B_GPIO_tri_io[4]),
        .O(PMOD_B_GPIO_tri_i_4),
        .T(PMOD_B_GPIO_tri_t_4));
  IOBUF PMOD_B_GPIO_tri_iobuf_5
       (.I(PMOD_B_GPIO_tri_o_5),
        .IO(PMOD_B_GPIO_tri_io[5]),
        .O(PMOD_B_GPIO_tri_i_5),
        .T(PMOD_B_GPIO_tri_t_5));
  IOBUF PMOD_B_I2C_scl_iobuf
       (.I(PMOD_B_I2C_scl_o),
        .IO(PMOD_B_I2C_scl_io),
        .O(PMOD_B_I2C_scl_i),
        .T(PMOD_B_I2C_scl_t));
  IOBUF PMOD_B_I2C_sda_iobuf
       (.I(PMOD_B_I2C_sda_o),
        .IO(PMOD_B_I2C_sda_io),
        .O(PMOD_B_I2C_sda_i),
        .T(PMOD_B_I2C_sda_t));
  design_1 design_1_i
       (.CLICK_I2C_scl_i(CLICK_I2C_scl_i),
        .CLICK_I2C_scl_o(CLICK_I2C_scl_o),
        .CLICK_I2C_scl_t(CLICK_I2C_scl_t),
        .CLICK_I2C_sda_i(CLICK_I2C_sda_i),
        .CLICK_I2C_sda_o(CLICK_I2C_sda_o),
        .CLICK_I2C_sda_t(CLICK_I2C_sda_t),
        .CLICK_PWM(CLICK_PWM),
        .CLICK_UART_RX(CLICK_UART_RX),
        .CLICK_UART_TX(CLICK_UART_TX),
        .PMOD_A_GPIO_tri_i({PMOD_A_GPIO_tri_i_3,PMOD_A_GPIO_tri_i_2,PMOD_A_GPIO_tri_i_1,PMOD_A_GPIO_tri_i_0}),
        .PMOD_A_GPIO_tri_o({PMOD_A_GPIO_tri_o_3,PMOD_A_GPIO_tri_o_2,PMOD_A_GPIO_tri_o_1,PMOD_A_GPIO_tri_o_0}),
        .PMOD_A_GPIO_tri_t({PMOD_A_GPIO_tri_t_3,PMOD_A_GPIO_tri_t_2,PMOD_A_GPIO_tri_t_1,PMOD_A_GPIO_tri_t_0}),
        .PMOD_A_UART_CTSn(PMOD_A_UART_CTSn),
        .PMOD_A_UART_RTSn(PMOD_A_UART_RTSn),
        .PMOD_A_UART_RX(PMOD_A_UART_RX),
        .PMOD_A_UART_TX(PMOD_A_UART_TX),
        .PMOD_B_GPIO_tri_i({PMOD_B_GPIO_tri_i_5,PMOD_B_GPIO_tri_i_4,PMOD_B_GPIO_tri_i_3,PMOD_B_GPIO_tri_i_2,PMOD_B_GPIO_tri_i_1,PMOD_B_GPIO_tri_i_0}),
        .PMOD_B_GPIO_tri_o({PMOD_B_GPIO_tri_o_5,PMOD_B_GPIO_tri_o_4,PMOD_B_GPIO_tri_o_3,PMOD_B_GPIO_tri_o_2,PMOD_B_GPIO_tri_o_1,PMOD_B_GPIO_tri_o_0}),
        .PMOD_B_GPIO_tri_t({PMOD_B_GPIO_tri_t_5,PMOD_B_GPIO_tri_t_4,PMOD_B_GPIO_tri_t_3,PMOD_B_GPIO_tri_t_2,PMOD_B_GPIO_tri_t_1,PMOD_B_GPIO_tri_t_0}),
        .PMOD_B_I2C_scl_i(PMOD_B_I2C_scl_i),
        .PMOD_B_I2C_scl_o(PMOD_B_I2C_scl_o),
        .PMOD_B_I2C_scl_t(PMOD_B_I2C_scl_t),
        .PMOD_B_I2C_sda_i(PMOD_B_I2C_sda_i),
        .PMOD_B_I2C_sda_o(PMOD_B_I2C_sda_o),
        .PMOD_B_I2C_sda_t(PMOD_B_I2C_sda_t),
        .backlight_dctrl(backlight_dctrl),
        .dip_switches_8bits_tri_i(dip_switches_8bits_tri_i),
        .led_8bits_tri_o(led_8bits_tri_o),
        .lvds_display_clk_n(lvds_display_clk_n),
        .lvds_display_clk_p(lvds_display_clk_p),
        .lvds_display_data_n(lvds_display_data_n),
        .lvds_display_data_p(lvds_display_data_p),
        .lvds_display_iic_scl_i(lvds_display_iic_scl_i),
        .lvds_display_iic_scl_o(lvds_display_iic_scl_o),
        .lvds_display_iic_scl_t(lvds_display_iic_scl_t),
        .lvds_display_iic_sda_i(lvds_display_iic_sda_i),
        .lvds_display_iic_sda_o(lvds_display_iic_sda_o),
        .lvds_display_iic_sda_t(lvds_display_iic_sda_t),
        .lvds_display_reset(lvds_display_reset),
        .lvds_display_standby(lvds_display_standby),
        .lvds_display_touch_irq_tri_i(lvds_display_touch_irq_tri_i_0),
        .lvds_display_touch_irq_tri_o(lvds_display_touch_irq_tri_o_0),
        .lvds_display_touch_irq_tri_t(lvds_display_touch_irq_tri_t_0),
        .lvds_display_touch_reset(lvds_display_touch_reset),
        .push_buttons_3bits_tri_i(push_buttons_3bits_tri_i),
        .pwr_en_ctrl(pwr_en_ctrl));
  IOBUF lvds_display_iic_scl_iobuf
       (.I(lvds_display_iic_scl_o),
        .IO(lvds_display_iic_scl_io),
        .O(lvds_display_iic_scl_i),
        .T(lvds_display_iic_scl_t));
  IOBUF lvds_display_iic_sda_iobuf
       (.I(lvds_display_iic_sda_o),
        .IO(lvds_display_iic_sda_io),
        .O(lvds_display_iic_sda_i),
        .T(lvds_display_iic_sda_t));
  IOBUF lvds_display_touch_irq_tri_iobuf_0
       (.I(lvds_display_touch_irq_tri_o_0),
        .IO(lvds_display_touch_irq_tri_io[0]),
        .O(lvds_display_touch_irq_tri_i_0),
        .T(lvds_display_touch_irq_tri_t_0));
endmodule
