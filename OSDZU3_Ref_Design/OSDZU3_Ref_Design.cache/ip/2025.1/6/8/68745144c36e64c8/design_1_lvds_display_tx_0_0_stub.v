// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
// Date        : Thu Sep  4 16:01:30 2025
// Host        : e-ubuntu running 64-bit Ubuntu 24.04.3 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_lvds_display_tx_0_0_stub.v
// Design      : design_1_lvds_display_tx_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu3eg-sfvc784-1-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_lvds_display_tx_0_0,lvds_display_tx,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "lvds_display_tx,Vivado 2023.1" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(ref_clk, reset, cmt_locked, px_clk, vid_io_in, 
  vid_active_video, vid_hsync, vid_vsync, clkout_p, clkout_n, dataout_p, dataout_n)
/* synthesis syn_black_box black_box_pad_pin="reset,cmt_locked,vid_io_in[23:0],vid_active_video,vid_hsync,vid_vsync,clkout_p,clkout_n,dataout_p[3:0],dataout_n[3:0]" */
/* synthesis syn_force_seq_prim="ref_clk" */
/* synthesis syn_force_seq_prim="px_clk" */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ref_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ref_clk, ASSOCIATED_RESET reset, ASSOCIATED_BUSIF vid, FREQ_TOLERANCE_HZ -1, FREQ_HZ 59999401, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk2, INSERT_VIP 0" *) input ref_clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input reset;
  output cmt_locked;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 px_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME px_clk, FREQ_TOLERANCE_HZ -1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_lvds_display_tx_0_0_px_clk, INSERT_VIP 0" *) output px_clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid DATA" *) input [23:0]vid_io_in;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid ACTIVE_VIDEO" *) input vid_active_video;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid HSYNC" *) input vid_hsync;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid VSYNC" *) input vid_vsync;
  output clkout_p;
  output clkout_n;
  output [3:0]dataout_p;
  output [3:0]dataout_n;
endmodule
