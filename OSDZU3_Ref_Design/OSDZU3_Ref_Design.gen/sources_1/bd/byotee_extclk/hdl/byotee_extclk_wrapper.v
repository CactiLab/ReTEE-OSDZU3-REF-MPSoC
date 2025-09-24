//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
//Date        : Mon Sep 15 13:51:28 2025
//Host        : e-ubuntu running 64-bit Ubuntu 24.04.3 LTS
//Command     : generate_target byotee_extclk_wrapper.bd
//Design      : byotee_extclk_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module byotee_extclk_wrapper
   (leds_8bits_tri_io);
  inout [7:0]leds_8bits_tri_io;

  wire [0:0]leds_8bits_tri_i_0;
  wire [1:1]leds_8bits_tri_i_1;
  wire [2:2]leds_8bits_tri_i_2;
  wire [3:3]leds_8bits_tri_i_3;
  wire [4:4]leds_8bits_tri_i_4;
  wire [5:5]leds_8bits_tri_i_5;
  wire [6:6]leds_8bits_tri_i_6;
  wire [7:7]leds_8bits_tri_i_7;
  wire [0:0]leds_8bits_tri_io_0;
  wire [1:1]leds_8bits_tri_io_1;
  wire [2:2]leds_8bits_tri_io_2;
  wire [3:3]leds_8bits_tri_io_3;
  wire [4:4]leds_8bits_tri_io_4;
  wire [5:5]leds_8bits_tri_io_5;
  wire [6:6]leds_8bits_tri_io_6;
  wire [7:7]leds_8bits_tri_io_7;
  wire [0:0]leds_8bits_tri_o_0;
  wire [1:1]leds_8bits_tri_o_1;
  wire [2:2]leds_8bits_tri_o_2;
  wire [3:3]leds_8bits_tri_o_3;
  wire [4:4]leds_8bits_tri_o_4;
  wire [5:5]leds_8bits_tri_o_5;
  wire [6:6]leds_8bits_tri_o_6;
  wire [7:7]leds_8bits_tri_o_7;
  wire [0:0]leds_8bits_tri_t_0;
  wire [1:1]leds_8bits_tri_t_1;
  wire [2:2]leds_8bits_tri_t_2;
  wire [3:3]leds_8bits_tri_t_3;
  wire [4:4]leds_8bits_tri_t_4;
  wire [5:5]leds_8bits_tri_t_5;
  wire [6:6]leds_8bits_tri_t_6;
  wire [7:7]leds_8bits_tri_t_7;

  byotee_extclk byotee_extclk_i
       (.leds_8bits_tri_i({leds_8bits_tri_i_7,leds_8bits_tri_i_6,leds_8bits_tri_i_5,leds_8bits_tri_i_4,leds_8bits_tri_i_3,leds_8bits_tri_i_2,leds_8bits_tri_i_1,leds_8bits_tri_i_0}),
        .leds_8bits_tri_o({leds_8bits_tri_o_7,leds_8bits_tri_o_6,leds_8bits_tri_o_5,leds_8bits_tri_o_4,leds_8bits_tri_o_3,leds_8bits_tri_o_2,leds_8bits_tri_o_1,leds_8bits_tri_o_0}),
        .leds_8bits_tri_t({leds_8bits_tri_t_7,leds_8bits_tri_t_6,leds_8bits_tri_t_5,leds_8bits_tri_t_4,leds_8bits_tri_t_3,leds_8bits_tri_t_2,leds_8bits_tri_t_1,leds_8bits_tri_t_0}));
  IOBUF leds_8bits_tri_iobuf_0
       (.I(leds_8bits_tri_o_0),
        .IO(leds_8bits_tri_io[0]),
        .O(leds_8bits_tri_i_0),
        .T(leds_8bits_tri_t_0));
  IOBUF leds_8bits_tri_iobuf_1
       (.I(leds_8bits_tri_o_1),
        .IO(leds_8bits_tri_io[1]),
        .O(leds_8bits_tri_i_1),
        .T(leds_8bits_tri_t_1));
  IOBUF leds_8bits_tri_iobuf_2
       (.I(leds_8bits_tri_o_2),
        .IO(leds_8bits_tri_io[2]),
        .O(leds_8bits_tri_i_2),
        .T(leds_8bits_tri_t_2));
  IOBUF leds_8bits_tri_iobuf_3
       (.I(leds_8bits_tri_o_3),
        .IO(leds_8bits_tri_io[3]),
        .O(leds_8bits_tri_i_3),
        .T(leds_8bits_tri_t_3));
  IOBUF leds_8bits_tri_iobuf_4
       (.I(leds_8bits_tri_o_4),
        .IO(leds_8bits_tri_io[4]),
        .O(leds_8bits_tri_i_4),
        .T(leds_8bits_tri_t_4));
  IOBUF leds_8bits_tri_iobuf_5
       (.I(leds_8bits_tri_o_5),
        .IO(leds_8bits_tri_io[5]),
        .O(leds_8bits_tri_i_5),
        .T(leds_8bits_tri_t_5));
  IOBUF leds_8bits_tri_iobuf_6
       (.I(leds_8bits_tri_o_6),
        .IO(leds_8bits_tri_io[6]),
        .O(leds_8bits_tri_i_6),
        .T(leds_8bits_tri_t_6));
  IOBUF leds_8bits_tri_iobuf_7
       (.I(leds_8bits_tri_o_7),
        .IO(leds_8bits_tri_io[7]),
        .O(leds_8bits_tri_i_7),
        .T(leds_8bits_tri_t_7));
endmodule
