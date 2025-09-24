//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
//Date        : Mon Sep  8 15:43:19 2025
//Host        : e-ubuntu running 64-bit Ubuntu 24.04.3 LTS
//Command     : generate_target OSDZU3x_Tutorial_wrapper.bd
//Design      : OSDZU3x_Tutorial_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module OSDZU3x_Tutorial_wrapper
   (dip_switches_8bits_tri_i,
    leds_8bits_tri_o,
    push_buttons_3bits_tri_i);
  input [7:0]dip_switches_8bits_tri_i;
  output [7:0]leds_8bits_tri_o;
  input [2:0]push_buttons_3bits_tri_i;

  wire [7:0]dip_switches_8bits_tri_i;
  wire [7:0]leds_8bits_tri_o;
  wire [2:0]push_buttons_3bits_tri_i;

  OSDZU3x_Tutorial OSDZU3x_Tutorial_i
       (.dip_switches_8bits_tri_i(dip_switches_8bits_tri_i),
        .leds_8bits_tri_o(leds_8bits_tri_o),
        .push_buttons_3bits_tri_i(push_buttons_3bits_tri_i));
endmodule
