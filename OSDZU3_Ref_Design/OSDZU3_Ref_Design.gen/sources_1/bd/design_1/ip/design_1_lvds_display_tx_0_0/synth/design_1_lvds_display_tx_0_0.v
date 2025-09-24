// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2025 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: designlinxhs.com:user:lvds_display_tx:1.2
// IP Revision: 6

(* X_CORE_INFO = "lvds_display_tx,Vivado 2025.1" *)
(* CHECK_LICENSE_TYPE = "design_1_lvds_display_tx_0_0,lvds_display_tx,{}" *)
(* IP_DEFINITION_SOURCE = "package_project" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_lvds_display_tx_0_0 (
  ref_clk,
  reset,
  cmt_locked,
  px_clk,
  vid_io_in,
  vid_active_video,
  vid_hsync,
  vid_vsync,
  clkout_p,
  clkout_n,
  dataout_p,
  dataout_n
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ref_clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ref_clk, ASSOCIATED_RESET reset, ASSOCIATED_BUSIF vid, FREQ_TOLERANCE_HZ -1, FREQ_HZ 59999401, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk2, INSERT_VIP 0" *)
input wire ref_clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
input wire reset;
output wire cmt_locked;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 px_clk CLK" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME px_clk, FREQ_TOLERANCE_HZ -1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_lvds_display_tx_0_0_px_clk, INSERT_VIP 0" *)
output wire px_clk;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid DATA" *)
(* X_INTERFACE_MODE = "slave" *)
input wire [23 : 0] vid_io_in;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid ACTIVE_VIDEO" *)
input wire vid_active_video;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid HSYNC" *)
input wire vid_hsync;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid VSYNC" *)
input wire vid_vsync;
output wire clkout_p;
output wire clkout_n;
output wire [3 : 0] dataout_p;
output wire [3 : 0] dataout_n;

  lvds_display_tx #(
    .CLKIN_PERIOD(12.5),
    .USE_PLL("FALSE"),
    .CLK_PATTERN(7'B1100011),
    .TX_SWAP_MASK(16'H0000),
    .PIXEL_FORMAT("RBG"),
    .USE_ALPHA(3)
  ) inst (
    .ref_clk(ref_clk),
    .reset(reset),
    .cmt_locked(cmt_locked),
    .px_clk(px_clk),
    .vid_io_in(vid_io_in),
    .vid_active_video(vid_active_video),
    .vid_hsync(vid_hsync),
    .vid_vsync(vid_vsync),
    .clkout_p(clkout_p),
    .clkout_n(clkout_n),
    .dataout_p(dataout_p),
    .dataout_n(dataout_n)
  );
endmodule
