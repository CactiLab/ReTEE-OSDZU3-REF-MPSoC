// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
// Date        : Thu Sep  4 16:01:30 2025
// Host        : e-ubuntu running 64-bit Ubuntu 24.04.3 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_lvds_display_tx_0_0_sim_netlist.v
// Design      : design_1_lvds_display_tx_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu3eg-sfvc784-1-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_lvds_display_tx_0_0,lvds_display_tx,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "lvds_display_tx,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (ref_clk,
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
    dataout_n);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ref_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ref_clk, ASSOCIATED_RESET reset, ASSOCIATED_BUSIF vid, FREQ_TOLERANCE_HZ -1, FREQ_HZ 59999401, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk2, INSERT_VIP 0" *) input ref_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input reset;
  output cmt_locked;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 px_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME px_clk, FREQ_TOLERANCE_HZ -1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_lvds_display_tx_0_0_px_clk, INSERT_VIP 0" *) output px_clk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid DATA" *) input [23:0]vid_io_in;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid ACTIVE_VIDEO" *) input vid_active_video;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid HSYNC" *) input vid_hsync;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid VSYNC" *) input vid_vsync;
  output clkout_p;
  output clkout_n;
  output [3:0]dataout_p;
  output [3:0]dataout_n;

  (* SLEW = "SLOW" *) wire clkout_n;
  (* SLEW = "SLOW" *) wire clkout_p;
  wire cmt_locked;
  (* SLEW = "SLOW" *) wire [3:0]dataout_n;
  (* SLEW = "SLOW" *) wire [3:0]dataout_p;
  wire px_clk;
  wire ref_clk;
  wire reset;
  wire vid_active_video;
  wire vid_hsync;
  wire [23:0]vid_io_in;
  wire vid_vsync;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_lvds_display_tx inst
       (.clkout_n(clkout_n),
        .clkout_p(clkout_p),
        .cmt_locked(cmt_locked),
        .dataout_n(dataout_n),
        .dataout_p(dataout_p),
        .px_clk(px_clk),
        .ref_clk(ref_clk),
        .reset(reset),
        .vid_active_video(vid_active_video),
        .vid_hsync(vid_hsync),
        .vid_io_in(vid_io_in),
        .vid_vsync(vid_vsync));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_lvds_display_tx
   (cmt_locked,
    px_clk,
    dataout_p,
    dataout_n,
    clkout_p,
    clkout_n,
    ref_clk,
    reset,
    vid_io_in,
    vid_active_video,
    vid_vsync,
    vid_hsync);
  output cmt_locked;
  output px_clk;
  output [3:0]dataout_p;
  output [3:0]dataout_n;
  output clkout_p;
  output clkout_n;
  input ref_clk;
  input reset;
  input [23:0]vid_io_in;
  input vid_active_video;
  input vid_vsync;
  input vid_hsync;

  wire clkdiv2;
  wire clkdiv4;
  wire clkout_n;
  wire clkout_p;
  wire cmt_locked;
  wire [3:0]dataout_n;
  wire [3:0]dataout_p;
  wire px_clk;
  wire [27:0]px_data;
  wire \px_locked[3]_i_1_n_0 ;
  wire \px_locked_reg_n_0_[0] ;
  wire \px_locked_reg_n_0_[1] ;
  wire \px_locked_reg_n_0_[2] ;
  wire \px_locked_reg_n_0_[3] ;
  wire ref_clk;
  wire reset;
  wire vid_active_video;
  wire vid_hsync;
  wire [23:0]vid_io_in;
  wire vid_vsync;

  LUT1 #(
    .INIT(2'h1)) 
    \px_locked[3]_i_1 
       (.I0(cmt_locked),
        .O(\px_locked[3]_i_1_n_0 ));
  FDCE \px_locked_reg[0] 
       (.C(px_clk),
        .CE(1'b1),
        .CLR(\px_locked[3]_i_1_n_0 ),
        .D(\px_locked_reg_n_0_[1] ),
        .Q(\px_locked_reg_n_0_[0] ));
  FDCE \px_locked_reg[1] 
       (.C(px_clk),
        .CE(1'b1),
        .CLR(\px_locked[3]_i_1_n_0 ),
        .D(\px_locked_reg_n_0_[2] ),
        .Q(\px_locked_reg_n_0_[1] ));
  FDCE \px_locked_reg[2] 
       (.C(px_clk),
        .CE(1'b1),
        .CLR(\px_locked[3]_i_1_n_0 ),
        .D(\px_locked_reg_n_0_[3] ),
        .Q(\px_locked_reg_n_0_[2] ));
  FDCE \px_locked_reg[3] 
       (.C(px_clk),
        .CE(1'b1),
        .CLR(\px_locked[3]_i_1_n_0 ),
        .D(1'b1),
        .Q(\px_locked_reg_n_0_[3] ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_channel_7to1 tx_channel
       (.Q(\px_locked_reg_n_0_[0] ),
        .clkout_n(clkout_n),
        .clkout_p(clkout_p),
        .dataout_n(dataout_n),
        .dataout_p(dataout_p),
        .px_clk(px_clk),
        .px_data({px_data[27:4],px_data[2:0]}),
        .tx_clkdiv2(clkdiv2),
        .tx_clkdiv4(clkdiv4));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_clkgen_7to1 tx_clkgen
       (.cmt_locked(cmt_locked),
        .px_clk(px_clk),
        .ref_clk(ref_clk),
        .reset(reset),
        .tx_clkdiv2(clkdiv2),
        .tx_clkdiv4(clkdiv4));
  FDRE vid_av_r_reg
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_active_video),
        .Q(px_data[2]),
        .R(1'b0));
  FDRE vid_hs_r_reg
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_hsync),
        .Q(px_data[10]),
        .R(1'b0));
  FDRE \vid_io_r_reg[0] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[0]),
        .Q(px_data[0]),
        .R(1'b0));
  FDRE \vid_io_r_reg[10] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[10]),
        .Q(px_data[26]),
        .R(1'b0));
  FDRE \vid_io_r_reg[11] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[11]),
        .Q(px_data[22]),
        .R(1'b0));
  FDRE \vid_io_r_reg[12] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[12]),
        .Q(px_data[18]),
        .R(1'b0));
  FDRE \vid_io_r_reg[13] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[13]),
        .Q(px_data[14]),
        .R(1'b0));
  FDRE \vid_io_r_reg[14] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[14]),
        .Q(px_data[11]),
        .R(1'b0));
  FDRE \vid_io_r_reg[15] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[15]),
        .Q(px_data[7]),
        .R(1'b0));
  FDRE \vid_io_r_reg[16] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[16]),
        .Q(px_data[24]),
        .R(1'b0));
  FDRE \vid_io_r_reg[17] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[17]),
        .Q(px_data[20]),
        .R(1'b0));
  FDRE \vid_io_r_reg[18] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[18]),
        .Q(px_data[16]),
        .R(1'b0));
  FDRE \vid_io_r_reg[19] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[19]),
        .Q(px_data[12]),
        .R(1'b0));
  FDRE \vid_io_r_reg[1] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[1]),
        .Q(px_data[25]),
        .R(1'b0));
  FDRE \vid_io_r_reg[20] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[20]),
        .Q(px_data[8]),
        .R(1'b0));
  FDRE \vid_io_r_reg[21] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[21]),
        .Q(px_data[4]),
        .R(1'b0));
  FDRE \vid_io_r_reg[22] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[22]),
        .Q(px_data[27]),
        .R(1'b0));
  FDRE \vid_io_r_reg[23] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[23]),
        .Q(px_data[23]),
        .R(1'b0));
  FDRE \vid_io_r_reg[2] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[2]),
        .Q(px_data[21]),
        .R(1'b0));
  FDRE \vid_io_r_reg[3] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[3]),
        .Q(px_data[17]),
        .R(1'b0));
  FDRE \vid_io_r_reg[4] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[4]),
        .Q(px_data[13]),
        .R(1'b0));
  FDRE \vid_io_r_reg[5] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[5]),
        .Q(px_data[9]),
        .R(1'b0));
  FDRE \vid_io_r_reg[6] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[6]),
        .Q(px_data[19]),
        .R(1'b0));
  FDRE \vid_io_r_reg[7] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[7]),
        .Q(px_data[15]),
        .R(1'b0));
  FDRE \vid_io_r_reg[8] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[8]),
        .Q(px_data[5]),
        .R(1'b0));
  FDRE \vid_io_r_reg[9] 
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_io_in[9]),
        .Q(px_data[1]),
        .R(1'b0));
  FDRE vid_vs_r_reg
       (.C(ref_clk),
        .CE(1'b1),
        .D(vid_vsync),
        .Q(px_data[6]),
        .R(1'b0));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_channel_7to1
   (dataout_p,
    dataout_n,
    clkout_p,
    clkout_n,
    px_clk,
    px_data,
    Q,
    tx_clkdiv2,
    tx_clkdiv4);
  output [3:0]dataout_p;
  output [3:0]dataout_n;
  output clkout_p;
  output clkout_n;
  input px_clk;
  input [26:0]px_data;
  input [0:0]Q;
  input tx_clkdiv2;
  input tx_clkdiv4;

  wire [0:0]Q;
  wire RST0;
  wire clear;
  wire clkout_n;
  wire clkout_p;
  wire [3:0]dataout_n;
  wire [3:0]dataout_p;
  wire px_clk;
  wire [26:0]px_data;
  wire tx_clkdiv2;
  wire tx_clkdiv4;
  wire \tx_enable_sync_reg_n_0_[0] ;
  wire \tx_enable_sync_reg_n_0_[1] ;
  wire \tx_enable_sync_reg_n_0_[2] ;
  wire \tx_enable_sync_reg_n_0_[3] ;
  wire \tx_enable_sync_reg_n_0_[4] ;
  wire \tx_enable_sync_reg_n_0_[5] ;
  wire \tx_enable_sync_reg_n_0_[6] ;
  wire \tx_enable_sync_reg_n_0_[7] ;
  wire [3:0]wr_addr_reg;

  FDCE \tx_enable_sync_reg[0] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .CLR(clear),
        .D(\tx_enable_sync_reg_n_0_[1] ),
        .Q(\tx_enable_sync_reg_n_0_[0] ));
  FDCE \tx_enable_sync_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .CLR(clear),
        .D(\tx_enable_sync_reg_n_0_[2] ),
        .Q(\tx_enable_sync_reg_n_0_[1] ));
  FDCE \tx_enable_sync_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .CLR(clear),
        .D(\tx_enable_sync_reg_n_0_[3] ),
        .Q(\tx_enable_sync_reg_n_0_[2] ));
  FDCE \tx_enable_sync_reg[3] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .CLR(clear),
        .D(\tx_enable_sync_reg_n_0_[4] ),
        .Q(\tx_enable_sync_reg_n_0_[3] ));
  FDCE \tx_enable_sync_reg[4] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .CLR(clear),
        .D(\tx_enable_sync_reg_n_0_[5] ),
        .Q(\tx_enable_sync_reg_n_0_[4] ));
  FDCE \tx_enable_sync_reg[5] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .CLR(clear),
        .D(\tx_enable_sync_reg_n_0_[6] ),
        .Q(\tx_enable_sync_reg_n_0_[5] ));
  FDCE \tx_enable_sync_reg[6] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .CLR(clear),
        .D(\tx_enable_sync_reg_n_0_[7] ),
        .Q(\tx_enable_sync_reg_n_0_[6] ));
  FDCE \tx_enable_sync_reg[7] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .CLR(clear),
        .D(1'b1),
        .Q(\tx_enable_sync_reg_n_0_[7] ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_piso_7to1 txc_piso
       (.Q(Q),
        .RST0(RST0),
        .\bit[0].mem_0 (wr_addr_reg),
        .clkout_n(clkout_n),
        .clkout_p(clkout_p),
        .px_clk(px_clk),
        .tx_clkdiv2(tx_clkdiv2),
        .tx_clkdiv4(tx_clkdiv4),
        .\tx_data_reg[0]_0 (\tx_enable_sync_reg_n_0_[0] ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_piso_7to1_0 \txd[0].piso 
       (.Q(Q),
        .RST0(RST0),
        .SR(clear),
        .dataout_n(dataout_n[0]),
        .dataout_p(dataout_p[0]),
        .out(wr_addr_reg),
        .px_clk(px_clk),
        .px_data({px_data[23],px_data[19],px_data[15],px_data[11],px_data[7],px_data[3],px_data[0]}),
        .tx_clkdiv2(tx_clkdiv2),
        .tx_clkdiv4(tx_clkdiv4),
        .\tx_data_reg[0]_0 (\tx_enable_sync_reg_n_0_[0] ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_piso_7to1_1 \txd[1].piso 
       (.Q(Q),
        .RST0(RST0),
        .dataout_n(dataout_n[1]),
        .dataout_p(dataout_p[1]),
        .out(wr_addr_reg),
        .px_clk(px_clk),
        .px_data({px_data[24],px_data[20],px_data[16],px_data[12],px_data[8],px_data[4],px_data[1]}),
        .tx_clkdiv2(tx_clkdiv2),
        .tx_clkdiv4(tx_clkdiv4),
        .\tx_data_reg[0]_0 (\tx_enable_sync_reg_n_0_[0] ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_piso_7to1_2 \txd[2].piso 
       (.Q(Q),
        .RST0(RST0),
        .dataout_n(dataout_n[2]),
        .dataout_p(dataout_p[2]),
        .out(wr_addr_reg),
        .px_clk(px_clk),
        .px_data({px_data[25],px_data[21],px_data[17],px_data[13],px_data[9],px_data[5],px_data[2]}),
        .tx_clkdiv2(tx_clkdiv2),
        .tx_clkdiv4(tx_clkdiv4),
        .\tx_data_reg[0]_0 (\tx_enable_sync_reg_n_0_[0] ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_piso_7to1_3 \txd[3].piso 
       (.Q(Q),
        .RST0(RST0),
        .dataout_n(dataout_n[3]),
        .dataout_p(dataout_p[3]),
        .out(wr_addr_reg),
        .px_clk(px_clk),
        .px_data({px_data[26],px_data[22],px_data[18],px_data[14],px_data[10],px_data[6]}),
        .tx_clkdiv2(tx_clkdiv2),
        .tx_clkdiv4(tx_clkdiv4),
        .\tx_data_reg[0]_0 (\tx_enable_sync_reg_n_0_[0] ));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_clkgen_7to1
   (cmt_locked,
    px_clk,
    tx_clkdiv2,
    tx_clkdiv4,
    ref_clk,
    reset);
  output cmt_locked;
  output px_clk;
  output tx_clkdiv2;
  output tx_clkdiv4;
  input ref_clk;
  input reset;

  wire cmt_locked;
  wire px_clk;
  wire px_pllmmcm;
  wire ref_clk;
  wire reset;
  wire tx_clkdiv2;
  wire tx_clkdiv4;
  wire tx_pllmmcm_div2;
  wire NLW_tx_mmcm_CDDCDONE_UNCONNECTED;
  wire NLW_tx_mmcm_CLKFBOUTB_UNCONNECTED;
  wire NLW_tx_mmcm_CLKFBSTOPPED_UNCONNECTED;
  wire NLW_tx_mmcm_CLKINSTOPPED_UNCONNECTED;
  wire NLW_tx_mmcm_CLKOUT0B_UNCONNECTED;
  wire NLW_tx_mmcm_CLKOUT1_UNCONNECTED;
  wire NLW_tx_mmcm_CLKOUT1B_UNCONNECTED;
  wire NLW_tx_mmcm_CLKOUT2_UNCONNECTED;
  wire NLW_tx_mmcm_CLKOUT2B_UNCONNECTED;
  wire NLW_tx_mmcm_CLKOUT3_UNCONNECTED;
  wire NLW_tx_mmcm_CLKOUT3B_UNCONNECTED;
  wire NLW_tx_mmcm_CLKOUT4_UNCONNECTED;
  wire NLW_tx_mmcm_CLKOUT5_UNCONNECTED;
  wire NLW_tx_mmcm_CLKOUT6_UNCONNECTED;
  wire NLW_tx_mmcm_DRDY_UNCONNECTED;
  wire NLW_tx_mmcm_PSDONE_UNCONNECTED;
  wire [15:0]NLW_tx_mmcm_DO_UNCONNECTED;

  (* BOX_TYPE = "PRIMITIVE" *) 
  (* XILINX_LEGACY_PRIM = "BUFG" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:CE" *) 
  BUFGCE #(
    .CE_TYPE("ASYNC"),
    .SIM_DEVICE("ULTRASCALE_PLUS")) 
    bg_px
       (.CE(1'b1),
        .I(px_pllmmcm),
        .O(px_clk));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* XILINX_LEGACY_PRIM = "BUFG" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:CE" *) 
  BUFGCE #(
    .CE_TYPE("ASYNC"),
    .SIM_DEVICE("ULTRASCALE_PLUS")) 
    bg_txdiv2
       (.CE(1'b1),
        .I(tx_pllmmcm_div2),
        .O(tx_clkdiv2));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFGCE_DIV #(
    .BUFGCE_DIVIDE(2),
    .CE_TYPE("SYNC"),
    .HARDSYNC_CLR("FALSE"),
    .IS_CE_INVERTED(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_I_INVERTED(1'b0),
    .SIM_DEVICE("ULTRASCALE"),
    .STARTUP_SYNC("FALSE")) 
    bg_txdiv4
       (.CE(1'b1),
        .CLR(1'b0),
        .I(tx_pllmmcm_div2),
        .O(tx_clkdiv4));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* XILINX_LEGACY_PRIM = "MMCME3_BASE" *) 
  (* XILINX_TRANSFORM_PINMAP = "GND:PSINCDEC,PSEN,PSCLK,DWE,DI[9],DI[8],DI[7],DI[6],DI[5],DI[4],DI[3],DI[2],DI[1],DI[15],DI[14],DI[13],DI[12],DI[11],DI[10],DI[0],DEN,DCLK,DADDR[6],DADDR[5],DADDR[4],DADDR[3],DADDR[2],DADDR[1],DADDR[0],CLKIN2,CDDCREQ VCC:CLKINSEL" *) 
  MMCME4_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT_F(14.000000),
    .CLKFBOUT_PHASE(0.000000),
    .CLKFBOUT_USE_FINE_PS("FALSE"),
    .CLKIN1_PERIOD(12.500000),
    .CLKIN2_PERIOD(0.000000),
    .CLKOUT0_DIVIDE_F(4.000000),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(0.000000),
    .CLKOUT0_USE_FINE_PS("FALSE"),
    .CLKOUT1_DIVIDE(1),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(0.000000),
    .CLKOUT1_USE_FINE_PS("FALSE"),
    .CLKOUT2_DIVIDE(1),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(0.000000),
    .CLKOUT2_USE_FINE_PS("FALSE"),
    .CLKOUT3_DIVIDE(1),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(0.000000),
    .CLKOUT3_USE_FINE_PS("FALSE"),
    .CLKOUT4_CASCADE("FALSE"),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT4_USE_FINE_PS("FALSE"),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .CLKOUT5_USE_FINE_PS("FALSE"),
    .CLKOUT6_DIVIDE(1),
    .CLKOUT6_DUTY_CYCLE(0.500000),
    .CLKOUT6_PHASE(0.000000),
    .CLKOUT6_USE_FINE_PS("FALSE"),
    .COMPENSATION("ZHOLD"),
    .DIVCLK_DIVIDE(1),
    .IS_CLKFBIN_INVERTED(1'b0),
    .IS_CLKIN1_INVERTED(1'b0),
    .IS_PWRDWN_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .REF_JITTER1(0.100000),
    .REF_JITTER2(0.010000),
    .SS_EN("FALSE"),
    .SS_MODE("CENTER_HIGH"),
    .SS_MOD_PERIOD(10000),
    .STARTUP_WAIT("FALSE")) 
    tx_mmcm
       (.CDDCDONE(NLW_tx_mmcm_CDDCDONE_UNCONNECTED),
        .CDDCREQ(1'b0),
        .CLKFBIN(px_clk),
        .CLKFBOUT(px_pllmmcm),
        .CLKFBOUTB(NLW_tx_mmcm_CLKFBOUTB_UNCONNECTED),
        .CLKFBSTOPPED(NLW_tx_mmcm_CLKFBSTOPPED_UNCONNECTED),
        .CLKIN1(ref_clk),
        .CLKIN2(1'b0),
        .CLKINSEL(1'b1),
        .CLKINSTOPPED(NLW_tx_mmcm_CLKINSTOPPED_UNCONNECTED),
        .CLKOUT0(tx_pllmmcm_div2),
        .CLKOUT0B(NLW_tx_mmcm_CLKOUT0B_UNCONNECTED),
        .CLKOUT1(NLW_tx_mmcm_CLKOUT1_UNCONNECTED),
        .CLKOUT1B(NLW_tx_mmcm_CLKOUT1B_UNCONNECTED),
        .CLKOUT2(NLW_tx_mmcm_CLKOUT2_UNCONNECTED),
        .CLKOUT2B(NLW_tx_mmcm_CLKOUT2B_UNCONNECTED),
        .CLKOUT3(NLW_tx_mmcm_CLKOUT3_UNCONNECTED),
        .CLKOUT3B(NLW_tx_mmcm_CLKOUT3B_UNCONNECTED),
        .CLKOUT4(NLW_tx_mmcm_CLKOUT4_UNCONNECTED),
        .CLKOUT5(NLW_tx_mmcm_CLKOUT5_UNCONNECTED),
        .CLKOUT6(NLW_tx_mmcm_CLKOUT6_UNCONNECTED),
        .DADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DCLK(1'b0),
        .DEN(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(NLW_tx_mmcm_DO_UNCONNECTED[15:0]),
        .DRDY(NLW_tx_mmcm_DRDY_UNCONNECTED),
        .DWE(1'b0),
        .LOCKED(cmt_locked),
        .PSCLK(1'b0),
        .PSDONE(NLW_tx_mmcm_PSDONE_UNCONNECTED),
        .PSEN(1'b0),
        .PSINCDEC(1'b0),
        .PWRDWN(1'b0),
        .RST(reset));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_piso_7to1
   (RST0,
    clkout_p,
    clkout_n,
    px_clk,
    Q,
    \bit[0].mem_0 ,
    tx_clkdiv2,
    tx_clkdiv4,
    \tx_data_reg[0]_0 );
  output RST0;
  output clkout_p;
  output clkout_n;
  input px_clk;
  input [0:0]Q;
  input [3:0]\bit[0].mem_0 ;
  input tx_clkdiv2;
  input tx_clkdiv4;
  input [0:0]\tx_data_reg[0]_0 ;

  wire \FSM_sequential_rd_state[0]_inv_i_1__3_n_0 ;
  wire \FSM_sequential_rd_state[1]_i_1__3_n_0 ;
  wire \FSM_sequential_rd_state[2]_i_1__3_n_0 ;
  wire [0:0]Q;
  wire RST0;
  wire [3:0]\bit[0].mem_0 ;
  wire clkout_n;
  wire clkout_p;
  wire oserdes_out;
  wire [3:0]p_0_in__3;
  wire px_clk;
  wire rd_addr;
  wire [3:0]rd_addr_reg;
  wire [6:0]rd_curr;
  wire [6:1]rd_last;
  wire [2:1]rd_state__0;
  wire tx_clkdiv2;
  wire tx_clkdiv4;
  wire [3:0]tx_data;
  wire \tx_data[0]_i_2__3_n_0 ;
  wire \tx_data[0]_i_3__3_n_0 ;
  wire \tx_data[1]_i_2__3_n_0 ;
  wire \tx_data[1]_i_3__3_n_0 ;
  wire \tx_data[2]_i_2__3_n_0 ;
  wire \tx_data[2]_i_3__3_n_0 ;
  wire \tx_data[3]_i_1__3_n_0 ;
  wire \tx_data[3]_i_3__3_n_0 ;
  wire \tx_data[3]_i_4__3_n_0 ;
  wire [0:0]\tx_data_reg[0]_0 ;
  wire \tx_data_reg_n_0_[0] ;
  wire \tx_data_reg_n_0_[1] ;
  wire \tx_data_reg_n_0_[2] ;
  wire \tx_data_reg_n_0_[3] ;
  wire \NLW_bit[0].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[1].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[2].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[3].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[4].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[5].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[6].mem_SPO_UNCONNECTED ;
  wire NLW_oserdes_cm_T_OUT_UNCONNECTED;

  LUT3 #(
    .INIT(8'h93)) 
    \FSM_sequential_rd_state[0]_inv_i_1__3 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[0]_inv_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h39)) 
    \FSM_sequential_rd_state[1]_i_1__3 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[1]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h72)) 
    \FSM_sequential_rd_state[2]_i_1__3 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[2]_i_1__3_n_0 ));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  (* inverted = "yes" *) 
  FDSE \FSM_sequential_rd_state_reg[0]_inv 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[0]_inv_i_1__3_n_0 ),
        .Q(rd_addr),
        .S(RST0));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  FDRE \FSM_sequential_rd_state_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[1]_i_1__3_n_0 ),
        .Q(rd_state__0[1]),
        .R(RST0));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  FDRE \FSM_sequential_rd_state_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[2]_i_1__3_n_0 ),
        .Q(rd_state__0[2]),
        .R(RST0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[0].mem 
       (.A0(\bit[0].mem_0 [0]),
        .A1(\bit[0].mem_0 [1]),
        .A2(\bit[0].mem_0 [2]),
        .A3(\bit[0].mem_0 [3]),
        .A4(1'b0),
        .D(1'b1),
        .DPO(rd_curr[0]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[0].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[1].mem 
       (.A0(\bit[0].mem_0 [0]),
        .A1(\bit[0].mem_0 [1]),
        .A2(\bit[0].mem_0 [2]),
        .A3(\bit[0].mem_0 [3]),
        .A4(1'b0),
        .D(1'b1),
        .DPO(rd_curr[1]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[1].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[2].mem 
       (.A0(\bit[0].mem_0 [0]),
        .A1(\bit[0].mem_0 [1]),
        .A2(\bit[0].mem_0 [2]),
        .A3(\bit[0].mem_0 [3]),
        .A4(1'b0),
        .D(1'b0),
        .DPO(rd_curr[2]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[2].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[3].mem 
       (.A0(\bit[0].mem_0 [0]),
        .A1(\bit[0].mem_0 [1]),
        .A2(\bit[0].mem_0 [2]),
        .A3(\bit[0].mem_0 [3]),
        .A4(1'b0),
        .D(1'b0),
        .DPO(rd_curr[3]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[3].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[4].mem 
       (.A0(\bit[0].mem_0 [0]),
        .A1(\bit[0].mem_0 [1]),
        .A2(\bit[0].mem_0 [2]),
        .A3(\bit[0].mem_0 [3]),
        .A4(1'b0),
        .D(1'b0),
        .DPO(rd_curr[4]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[4].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[5].mem 
       (.A0(\bit[0].mem_0 [0]),
        .A1(\bit[0].mem_0 [1]),
        .A2(\bit[0].mem_0 [2]),
        .A3(\bit[0].mem_0 [3]),
        .A4(1'b0),
        .D(1'b1),
        .DPO(rd_curr[5]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[5].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[6].mem 
       (.A0(\bit[0].mem_0 [0]),
        .A1(\bit[0].mem_0 [1]),
        .A2(\bit[0].mem_0 [2]),
        .A3(\bit[0].mem_0 [3]),
        .A4(1'b0),
        .D(1'b1),
        .DPO(rd_curr[6]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[6].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* XILINX_LEGACY_PRIM = "OBUFDS" *) 
  OBUFDS #(
    .IOSTANDARD("DEFAULT")) 
    io_clk_out
       (.I(oserdes_out),
        .O(clkout_p),
        .OB(clkout_n));
  (* BOX_TYPE = "PRIMITIVE" *) 
  OSERDESE3 #(
    .DATA_WIDTH(4),
    .INIT(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .ODDR_MODE("FALSE"),
    .OSERDES_D_BYPASS("FALSE"),
    .OSERDES_T_BYPASS("FALSE"),
    .SIM_DEVICE("ULTRASCALE_PLUS"),
    .SIM_VERSION(2.000000)) 
    oserdes_cm
       (.CLK(tx_clkdiv2),
        .CLKDIV(tx_clkdiv4),
        .D({1'b0,1'b0,1'b0,1'b0,\tx_data_reg_n_0_[3] ,\tx_data_reg_n_0_[2] ,\tx_data_reg_n_0_[1] ,\tx_data_reg_n_0_[0] }),
        .OQ(oserdes_out),
        .RST(RST0),
        .T(1'b0),
        .T_OUT(NLW_oserdes_cm_T_OUT_UNCONNECTED));
  LUT1 #(
    .INIT(2'h1)) 
    oserdes_cm_i_1
       (.I0(\tx_data_reg[0]_0 ),
        .O(RST0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \rd_addr[0]_i_1__3 
       (.I0(rd_addr_reg[0]),
        .O(p_0_in__3[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_addr[1]_i_1 
       (.I0(rd_addr_reg[1]),
        .I1(rd_addr_reg[0]),
        .O(p_0_in__3[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \rd_addr[2]_i_1__3 
       (.I0(rd_addr_reg[2]),
        .I1(rd_addr_reg[1]),
        .I2(rd_addr_reg[0]),
        .O(p_0_in__3[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \rd_addr[3]_i_1__3 
       (.I0(rd_addr_reg[3]),
        .I1(rd_addr_reg[1]),
        .I2(rd_addr_reg[0]),
        .I3(rd_addr_reg[2]),
        .O(p_0_in__3[3]));
  FDRE \rd_addr_reg[0] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__3[0]),
        .Q(rd_addr_reg[0]),
        .R(RST0));
  FDRE \rd_addr_reg[1] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__3[1]),
        .Q(rd_addr_reg[1]),
        .R(RST0));
  FDRE \rd_addr_reg[2] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__3[2]),
        .Q(rd_addr_reg[2]),
        .R(RST0));
  FDRE \rd_addr_reg[3] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__3[3]),
        .Q(rd_addr_reg[3]),
        .R(RST0));
  FDRE \rd_last_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[1]),
        .Q(rd_last[1]),
        .R(1'b0));
  FDRE \rd_last_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[2]),
        .Q(rd_last[2]),
        .R(1'b0));
  FDRE \rd_last_reg[3] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[3]),
        .Q(rd_last[3]),
        .R(1'b0));
  FDRE \rd_last_reg[4] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[4]),
        .Q(rd_last[4]),
        .R(1'b0));
  FDRE \rd_last_reg[5] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[5]),
        .Q(rd_last[5]),
        .R(1'b0));
  FDRE \rd_last_reg[6] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[6]),
        .Q(rd_last[6]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[0]_i_2__3 
       (.I0(rd_last[5]),
        .I1(rd_last[1]),
        .I2(rd_state__0[1]),
        .I3(rd_last[4]),
        .I4(rd_addr),
        .I5(rd_curr[0]),
        .O(\tx_data[0]_i_2__3_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[0]_i_3__3 
       (.I0(rd_last[3]),
        .I1(rd_state__0[1]),
        .I2(rd_last[6]),
        .I3(rd_addr),
        .I4(rd_last[2]),
        .O(\tx_data[0]_i_3__3_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[1]_i_2__3 
       (.I0(rd_last[6]),
        .I1(rd_last[2]),
        .I2(rd_state__0[1]),
        .I3(rd_last[5]),
        .I4(rd_addr),
        .I5(rd_curr[1]),
        .O(\tx_data[1]_i_2__3_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[1]_i_3__3 
       (.I0(rd_last[4]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[0]),
        .I3(rd_addr),
        .I4(rd_last[3]),
        .O(\tx_data[1]_i_3__3_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[2]_i_2__3 
       (.I0(rd_curr[0]),
        .I1(rd_last[3]),
        .I2(rd_state__0[1]),
        .I3(rd_last[6]),
        .I4(rd_addr),
        .I5(rd_curr[2]),
        .O(\tx_data[2]_i_2__3_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[2]_i_3__3 
       (.I0(rd_last[5]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[1]),
        .I3(rd_addr),
        .I4(rd_last[4]),
        .O(\tx_data[2]_i_3__3_n_0 ));
  LUT4 #(
    .INIT(16'hDF00)) 
    \tx_data[3]_i_1__3 
       (.I0(rd_state__0[2]),
        .I1(rd_addr),
        .I2(rd_state__0[1]),
        .I3(\tx_data_reg[0]_0 ),
        .O(\tx_data[3]_i_1__3_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[3]_i_3__3 
       (.I0(rd_curr[1]),
        .I1(rd_last[4]),
        .I2(rd_state__0[1]),
        .I3(rd_curr[0]),
        .I4(rd_addr),
        .I5(rd_curr[3]),
        .O(\tx_data[3]_i_3__3_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[3]_i_4__3 
       (.I0(rd_last[6]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[2]),
        .I3(rd_addr),
        .I4(rd_last[5]),
        .O(\tx_data[3]_i_4__3_n_0 ));
  FDRE \tx_data_reg[0] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__3_n_0 ),
        .D(tx_data[0]),
        .Q(\tx_data_reg_n_0_[0] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[0]_i_1__3 
       (.I0(\tx_data[0]_i_2__3_n_0 ),
        .I1(\tx_data[0]_i_3__3_n_0 ),
        .O(tx_data[0]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[1] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__3_n_0 ),
        .D(tx_data[1]),
        .Q(\tx_data_reg_n_0_[1] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[1]_i_1__3 
       (.I0(\tx_data[1]_i_2__3_n_0 ),
        .I1(\tx_data[1]_i_3__3_n_0 ),
        .O(tx_data[1]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[2] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__3_n_0 ),
        .D(tx_data[2]),
        .Q(\tx_data_reg_n_0_[2] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[2]_i_1__3 
       (.I0(\tx_data[2]_i_2__3_n_0 ),
        .I1(\tx_data[2]_i_3__3_n_0 ),
        .O(tx_data[2]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[3] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__3_n_0 ),
        .D(tx_data[3]),
        .Q(\tx_data_reg_n_0_[3] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[3]_i_2__3 
       (.I0(\tx_data[3]_i_3__3_n_0 ),
        .I1(\tx_data[3]_i_4__3_n_0 ),
        .O(tx_data[3]),
        .S(rd_state__0[2]));
endmodule

(* ORIG_REF_NAME = "tx_piso_7to1" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_piso_7to1_0
   (out,
    dataout_p,
    dataout_n,
    SR,
    px_clk,
    px_data,
    Q,
    tx_clkdiv2,
    tx_clkdiv4,
    RST0,
    \tx_data_reg[0]_0 );
  output [3:0]out;
  output [0:0]dataout_p;
  output [0:0]dataout_n;
  output [0:0]SR;
  input px_clk;
  input [6:0]px_data;
  input [0:0]Q;
  input tx_clkdiv2;
  input tx_clkdiv4;
  input RST0;
  input [0:0]\tx_data_reg[0]_0 ;

  wire \FSM_sequential_rd_state[0]_inv_i_1_n_0 ;
  wire \FSM_sequential_rd_state[1]_i_1_n_0 ;
  wire \FSM_sequential_rd_state[2]_i_1_n_0 ;
  wire [0:0]Q;
  wire RST0;
  wire [0:0]SR;
  wire [0:0]dataout_n;
  wire [0:0]dataout_p;
  wire oserdes_out;
  wire [3:0]out;
  wire [3:0]p_0_in;
  wire [3:0]p_0_in__4;
  wire px_clk;
  wire [6:0]px_data;
  wire rd_addr;
  wire [3:0]rd_addr_reg;
  wire [6:0]rd_curr;
  wire [6:1]rd_last;
  wire [2:1]rd_state__0;
  wire tx_clkdiv2;
  wire tx_clkdiv4;
  wire [3:0]tx_data;
  wire \tx_data[0]_i_2_n_0 ;
  wire \tx_data[0]_i_3_n_0 ;
  wire \tx_data[1]_i_2_n_0 ;
  wire \tx_data[1]_i_3_n_0 ;
  wire \tx_data[2]_i_2_n_0 ;
  wire \tx_data[2]_i_3_n_0 ;
  wire \tx_data[3]_i_1_n_0 ;
  wire \tx_data[3]_i_3_n_0 ;
  wire \tx_data[3]_i_4_n_0 ;
  wire [0:0]\tx_data_reg[0]_0 ;
  wire \tx_data_reg_n_0_[0] ;
  wire \tx_data_reg_n_0_[1] ;
  wire \tx_data_reg_n_0_[2] ;
  wire \tx_data_reg_n_0_[3] ;
  wire \NLW_bit[0].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[1].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[2].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[3].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[4].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[5].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[6].mem_SPO_UNCONNECTED ;
  wire NLW_oserdes_cm_T_OUT_UNCONNECTED;

  LUT3 #(
    .INIT(8'h93)) 
    \FSM_sequential_rd_state[0]_inv_i_1 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[0]_inv_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h39)) 
    \FSM_sequential_rd_state[1]_i_1 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h72)) 
    \FSM_sequential_rd_state[2]_i_1 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[2]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  (* inverted = "yes" *) 
  FDSE \FSM_sequential_rd_state_reg[0]_inv 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[0]_inv_i_1_n_0 ),
        .Q(rd_addr),
        .S(RST0));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  FDRE \FSM_sequential_rd_state_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[1]_i_1_n_0 ),
        .Q(rd_state__0[1]),
        .R(RST0));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  FDRE \FSM_sequential_rd_state_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[2]_i_1_n_0 ),
        .Q(rd_state__0[2]),
        .R(RST0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[0].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[0]),
        .DPO(rd_curr[0]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[0].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[1].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[1]),
        .DPO(rd_curr[1]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[1].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[2].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[2]),
        .DPO(rd_curr[2]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[2].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[3].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[3]),
        .DPO(rd_curr[3]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[3].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[4].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[4]),
        .DPO(rd_curr[4]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[4].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[5].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[5]),
        .DPO(rd_curr[5]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[5].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[6].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[6]),
        .DPO(rd_curr[6]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[6].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* XILINX_LEGACY_PRIM = "OBUFDS" *) 
  OBUFDS #(
    .IOSTANDARD("DEFAULT")) 
    io_clk_out
       (.I(oserdes_out),
        .O(dataout_p),
        .OB(dataout_n));
  (* BOX_TYPE = "PRIMITIVE" *) 
  OSERDESE3 #(
    .DATA_WIDTH(4),
    .INIT(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .ODDR_MODE("FALSE"),
    .OSERDES_D_BYPASS("FALSE"),
    .OSERDES_T_BYPASS("FALSE"),
    .SIM_DEVICE("ULTRASCALE_PLUS"),
    .SIM_VERSION(2.000000)) 
    oserdes_cm
       (.CLK(tx_clkdiv2),
        .CLKDIV(tx_clkdiv4),
        .D({1'b0,1'b0,1'b0,1'b0,\tx_data_reg_n_0_[3] ,\tx_data_reg_n_0_[2] ,\tx_data_reg_n_0_[1] ,\tx_data_reg_n_0_[0] }),
        .OQ(oserdes_out),
        .RST(RST0),
        .T(1'b0),
        .T_OUT(NLW_oserdes_cm_T_OUT_UNCONNECTED));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \rd_addr[0]_i_1 
       (.I0(rd_addr_reg[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_addr[1]_i_1__3 
       (.I0(rd_addr_reg[1]),
        .I1(rd_addr_reg[0]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \rd_addr[2]_i_1 
       (.I0(rd_addr_reg[2]),
        .I1(rd_addr_reg[1]),
        .I2(rd_addr_reg[0]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \rd_addr[3]_i_1 
       (.I0(rd_addr_reg[3]),
        .I1(rd_addr_reg[1]),
        .I2(rd_addr_reg[0]),
        .I3(rd_addr_reg[2]),
        .O(p_0_in[3]));
  FDRE \rd_addr_reg[0] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in[0]),
        .Q(rd_addr_reg[0]),
        .R(RST0));
  FDRE \rd_addr_reg[1] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in[1]),
        .Q(rd_addr_reg[1]),
        .R(RST0));
  FDRE \rd_addr_reg[2] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in[2]),
        .Q(rd_addr_reg[2]),
        .R(RST0));
  FDRE \rd_addr_reg[3] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in[3]),
        .Q(rd_addr_reg[3]),
        .R(RST0));
  FDRE \rd_last_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[1]),
        .Q(rd_last[1]),
        .R(1'b0));
  FDRE \rd_last_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[2]),
        .Q(rd_last[2]),
        .R(1'b0));
  FDRE \rd_last_reg[3] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[3]),
        .Q(rd_last[3]),
        .R(1'b0));
  FDRE \rd_last_reg[4] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[4]),
        .Q(rd_last[4]),
        .R(1'b0));
  FDRE \rd_last_reg[5] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[5]),
        .Q(rd_last[5]),
        .R(1'b0));
  FDRE \rd_last_reg[6] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[6]),
        .Q(rd_last[6]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[0]_i_2 
       (.I0(rd_last[5]),
        .I1(rd_last[1]),
        .I2(rd_state__0[1]),
        .I3(rd_last[4]),
        .I4(rd_addr),
        .I5(rd_curr[0]),
        .O(\tx_data[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[0]_i_3 
       (.I0(rd_last[3]),
        .I1(rd_state__0[1]),
        .I2(rd_last[6]),
        .I3(rd_addr),
        .I4(rd_last[2]),
        .O(\tx_data[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[1]_i_2 
       (.I0(rd_last[6]),
        .I1(rd_last[2]),
        .I2(rd_state__0[1]),
        .I3(rd_last[5]),
        .I4(rd_addr),
        .I5(rd_curr[1]),
        .O(\tx_data[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[1]_i_3 
       (.I0(rd_last[4]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[0]),
        .I3(rd_addr),
        .I4(rd_last[3]),
        .O(\tx_data[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[2]_i_2 
       (.I0(rd_curr[0]),
        .I1(rd_last[3]),
        .I2(rd_state__0[1]),
        .I3(rd_last[6]),
        .I4(rd_addr),
        .I5(rd_curr[2]),
        .O(\tx_data[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[2]_i_3 
       (.I0(rd_last[5]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[1]),
        .I3(rd_addr),
        .I4(rd_last[4]),
        .O(\tx_data[2]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hDF00)) 
    \tx_data[3]_i_1 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .I3(\tx_data_reg[0]_0 ),
        .O(\tx_data[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[3]_i_3 
       (.I0(rd_curr[1]),
        .I1(rd_last[4]),
        .I2(rd_state__0[1]),
        .I3(rd_curr[0]),
        .I4(rd_addr),
        .I5(rd_curr[3]),
        .O(\tx_data[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[3]_i_4 
       (.I0(rd_last[6]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[2]),
        .I3(rd_addr),
        .I4(rd_last[5]),
        .O(\tx_data[3]_i_4_n_0 ));
  FDRE \tx_data_reg[0] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1_n_0 ),
        .D(tx_data[0]),
        .Q(\tx_data_reg_n_0_[0] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[0]_i_1 
       (.I0(\tx_data[0]_i_2_n_0 ),
        .I1(\tx_data[0]_i_3_n_0 ),
        .O(tx_data[0]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[1] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1_n_0 ),
        .D(tx_data[1]),
        .Q(\tx_data_reg_n_0_[1] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[1]_i_1 
       (.I0(\tx_data[1]_i_2_n_0 ),
        .I1(\tx_data[1]_i_3_n_0 ),
        .O(tx_data[1]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[2] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1_n_0 ),
        .D(tx_data[2]),
        .Q(\tx_data_reg_n_0_[2] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[2]_i_1 
       (.I0(\tx_data[2]_i_2_n_0 ),
        .I1(\tx_data[2]_i_3_n_0 ),
        .O(tx_data[2]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[3] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1_n_0 ),
        .D(tx_data[3]),
        .Q(\tx_data_reg_n_0_[3] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[3]_i_2 
       (.I0(\tx_data[3]_i_3_n_0 ),
        .I1(\tx_data[3]_i_4_n_0 ),
        .O(tx_data[3]),
        .S(rd_state__0[2]));
  LUT1 #(
    .INIT(2'h1)) 
    \tx_enable_sync[7]_i_1 
       (.I0(Q),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \wr_addr[0]_i_1 
       (.I0(out[0]),
        .O(p_0_in__4[0]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \wr_addr[1]_i_1 
       (.I0(out[0]),
        .I1(out[1]),
        .O(p_0_in__4[1]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \wr_addr[2]_i_1 
       (.I0(out[0]),
        .I1(out[1]),
        .I2(out[2]),
        .O(p_0_in__4[2]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \wr_addr[3]_i_1 
       (.I0(out[1]),
        .I1(out[0]),
        .I2(out[2]),
        .I3(out[3]),
        .O(p_0_in__4[3]));
  FDRE \wr_addr_reg[0] 
       (.C(px_clk),
        .CE(1'b1),
        .D(p_0_in__4[0]),
        .Q(out[0]),
        .R(SR));
  FDRE \wr_addr_reg[1] 
       (.C(px_clk),
        .CE(1'b1),
        .D(p_0_in__4[1]),
        .Q(out[1]),
        .R(SR));
  FDRE \wr_addr_reg[2] 
       (.C(px_clk),
        .CE(1'b1),
        .D(p_0_in__4[2]),
        .Q(out[2]),
        .R(SR));
  FDRE \wr_addr_reg[3] 
       (.C(px_clk),
        .CE(1'b1),
        .D(p_0_in__4[3]),
        .Q(out[3]),
        .R(SR));
endmodule

(* ORIG_REF_NAME = "tx_piso_7to1" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_piso_7to1_1
   (dataout_p,
    dataout_n,
    px_clk,
    px_data,
    Q,
    out,
    tx_clkdiv2,
    tx_clkdiv4,
    RST0,
    \tx_data_reg[0]_0 );
  output [0:0]dataout_p;
  output [0:0]dataout_n;
  input px_clk;
  input [6:0]px_data;
  input [0:0]Q;
  input [3:0]out;
  input tx_clkdiv2;
  input tx_clkdiv4;
  input RST0;
  input [0:0]\tx_data_reg[0]_0 ;

  wire \FSM_sequential_rd_state[0]_inv_i_1__0_n_0 ;
  wire \FSM_sequential_rd_state[1]_i_1__0_n_0 ;
  wire \FSM_sequential_rd_state[2]_i_1__0_n_0 ;
  wire [0:0]Q;
  wire RST0;
  wire [0:0]dataout_n;
  wire [0:0]dataout_p;
  wire oserdes_out;
  wire [3:0]out;
  wire [3:0]p_0_in__0;
  wire px_clk;
  wire [6:0]px_data;
  wire rd_addr;
  wire [3:0]rd_addr_reg;
  wire [6:0]rd_curr;
  wire [6:1]rd_last;
  wire [2:1]rd_state__0;
  wire tx_clkdiv2;
  wire tx_clkdiv4;
  wire [3:0]tx_data;
  wire \tx_data[0]_i_2__0_n_0 ;
  wire \tx_data[0]_i_3__0_n_0 ;
  wire \tx_data[1]_i_2__0_n_0 ;
  wire \tx_data[1]_i_3__0_n_0 ;
  wire \tx_data[2]_i_2__0_n_0 ;
  wire \tx_data[2]_i_3__0_n_0 ;
  wire \tx_data[3]_i_1__0_n_0 ;
  wire \tx_data[3]_i_3__0_n_0 ;
  wire \tx_data[3]_i_4__0_n_0 ;
  wire [0:0]\tx_data_reg[0]_0 ;
  wire \tx_data_reg_n_0_[0] ;
  wire \tx_data_reg_n_0_[1] ;
  wire \tx_data_reg_n_0_[2] ;
  wire \tx_data_reg_n_0_[3] ;
  wire \NLW_bit[0].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[1].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[2].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[3].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[4].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[5].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[6].mem_SPO_UNCONNECTED ;
  wire NLW_oserdes_cm_T_OUT_UNCONNECTED;

  LUT3 #(
    .INIT(8'h93)) 
    \FSM_sequential_rd_state[0]_inv_i_1__0 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[0]_inv_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h39)) 
    \FSM_sequential_rd_state[1]_i_1__0 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h72)) 
    \FSM_sequential_rd_state[2]_i_1__0 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[2]_i_1__0_n_0 ));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  (* inverted = "yes" *) 
  FDSE \FSM_sequential_rd_state_reg[0]_inv 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[0]_inv_i_1__0_n_0 ),
        .Q(rd_addr),
        .S(RST0));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  FDRE \FSM_sequential_rd_state_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[1]_i_1__0_n_0 ),
        .Q(rd_state__0[1]),
        .R(RST0));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  FDRE \FSM_sequential_rd_state_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[2]_i_1__0_n_0 ),
        .Q(rd_state__0[2]),
        .R(RST0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[0].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[0]),
        .DPO(rd_curr[0]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[0].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[1].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[1]),
        .DPO(rd_curr[1]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[1].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[2].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[2]),
        .DPO(rd_curr[2]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[2].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[3].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[3]),
        .DPO(rd_curr[3]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[3].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[4].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[4]),
        .DPO(rd_curr[4]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[4].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[5].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[5]),
        .DPO(rd_curr[5]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[5].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[6].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[6]),
        .DPO(rd_curr[6]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[6].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* XILINX_LEGACY_PRIM = "OBUFDS" *) 
  OBUFDS #(
    .IOSTANDARD("DEFAULT")) 
    io_clk_out
       (.I(oserdes_out),
        .O(dataout_p),
        .OB(dataout_n));
  (* BOX_TYPE = "PRIMITIVE" *) 
  OSERDESE3 #(
    .DATA_WIDTH(4),
    .INIT(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .ODDR_MODE("FALSE"),
    .OSERDES_D_BYPASS("FALSE"),
    .OSERDES_T_BYPASS("FALSE"),
    .SIM_DEVICE("ULTRASCALE_PLUS"),
    .SIM_VERSION(2.000000)) 
    oserdes_cm
       (.CLK(tx_clkdiv2),
        .CLKDIV(tx_clkdiv4),
        .D({1'b0,1'b0,1'b0,1'b0,\tx_data_reg_n_0_[3] ,\tx_data_reg_n_0_[2] ,\tx_data_reg_n_0_[1] ,\tx_data_reg_n_0_[0] }),
        .OQ(oserdes_out),
        .RST(RST0),
        .T(1'b0),
        .T_OUT(NLW_oserdes_cm_T_OUT_UNCONNECTED));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \rd_addr[0]_i_1__0 
       (.I0(rd_addr_reg[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_addr[1]_i_1__2 
       (.I0(rd_addr_reg[1]),
        .I1(rd_addr_reg[0]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \rd_addr[2]_i_1__0 
       (.I0(rd_addr_reg[2]),
        .I1(rd_addr_reg[1]),
        .I2(rd_addr_reg[0]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \rd_addr[3]_i_1__0 
       (.I0(rd_addr_reg[3]),
        .I1(rd_addr_reg[1]),
        .I2(rd_addr_reg[0]),
        .I3(rd_addr_reg[2]),
        .O(p_0_in__0[3]));
  FDRE \rd_addr_reg[0] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__0[0]),
        .Q(rd_addr_reg[0]),
        .R(RST0));
  FDRE \rd_addr_reg[1] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__0[1]),
        .Q(rd_addr_reg[1]),
        .R(RST0));
  FDRE \rd_addr_reg[2] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__0[2]),
        .Q(rd_addr_reg[2]),
        .R(RST0));
  FDRE \rd_addr_reg[3] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__0[3]),
        .Q(rd_addr_reg[3]),
        .R(RST0));
  FDRE \rd_last_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[1]),
        .Q(rd_last[1]),
        .R(1'b0));
  FDRE \rd_last_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[2]),
        .Q(rd_last[2]),
        .R(1'b0));
  FDRE \rd_last_reg[3] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[3]),
        .Q(rd_last[3]),
        .R(1'b0));
  FDRE \rd_last_reg[4] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[4]),
        .Q(rd_last[4]),
        .R(1'b0));
  FDRE \rd_last_reg[5] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[5]),
        .Q(rd_last[5]),
        .R(1'b0));
  FDRE \rd_last_reg[6] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[6]),
        .Q(rd_last[6]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[0]_i_2__0 
       (.I0(rd_last[5]),
        .I1(rd_last[1]),
        .I2(rd_state__0[1]),
        .I3(rd_last[4]),
        .I4(rd_addr),
        .I5(rd_curr[0]),
        .O(\tx_data[0]_i_2__0_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[0]_i_3__0 
       (.I0(rd_last[3]),
        .I1(rd_state__0[1]),
        .I2(rd_last[6]),
        .I3(rd_addr),
        .I4(rd_last[2]),
        .O(\tx_data[0]_i_3__0_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[1]_i_2__0 
       (.I0(rd_last[6]),
        .I1(rd_last[2]),
        .I2(rd_state__0[1]),
        .I3(rd_last[5]),
        .I4(rd_addr),
        .I5(rd_curr[1]),
        .O(\tx_data[1]_i_2__0_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[1]_i_3__0 
       (.I0(rd_last[4]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[0]),
        .I3(rd_addr),
        .I4(rd_last[3]),
        .O(\tx_data[1]_i_3__0_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[2]_i_2__0 
       (.I0(rd_curr[0]),
        .I1(rd_last[3]),
        .I2(rd_state__0[1]),
        .I3(rd_last[6]),
        .I4(rd_addr),
        .I5(rd_curr[2]),
        .O(\tx_data[2]_i_2__0_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[2]_i_3__0 
       (.I0(rd_last[5]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[1]),
        .I3(rd_addr),
        .I4(rd_last[4]),
        .O(\tx_data[2]_i_3__0_n_0 ));
  LUT4 #(
    .INIT(16'hDF00)) 
    \tx_data[3]_i_1__0 
       (.I0(rd_state__0[2]),
        .I1(rd_addr),
        .I2(rd_state__0[1]),
        .I3(\tx_data_reg[0]_0 ),
        .O(\tx_data[3]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[3]_i_3__0 
       (.I0(rd_curr[1]),
        .I1(rd_last[4]),
        .I2(rd_state__0[1]),
        .I3(rd_curr[0]),
        .I4(rd_addr),
        .I5(rd_curr[3]),
        .O(\tx_data[3]_i_3__0_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[3]_i_4__0 
       (.I0(rd_last[6]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[2]),
        .I3(rd_addr),
        .I4(rd_last[5]),
        .O(\tx_data[3]_i_4__0_n_0 ));
  FDRE \tx_data_reg[0] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__0_n_0 ),
        .D(tx_data[0]),
        .Q(\tx_data_reg_n_0_[0] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[0]_i_1__0 
       (.I0(\tx_data[0]_i_2__0_n_0 ),
        .I1(\tx_data[0]_i_3__0_n_0 ),
        .O(tx_data[0]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[1] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__0_n_0 ),
        .D(tx_data[1]),
        .Q(\tx_data_reg_n_0_[1] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[1]_i_1__0 
       (.I0(\tx_data[1]_i_2__0_n_0 ),
        .I1(\tx_data[1]_i_3__0_n_0 ),
        .O(tx_data[1]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[2] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__0_n_0 ),
        .D(tx_data[2]),
        .Q(\tx_data_reg_n_0_[2] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[2]_i_1__0 
       (.I0(\tx_data[2]_i_2__0_n_0 ),
        .I1(\tx_data[2]_i_3__0_n_0 ),
        .O(tx_data[2]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[3] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__0_n_0 ),
        .D(tx_data[3]),
        .Q(\tx_data_reg_n_0_[3] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[3]_i_2__0 
       (.I0(\tx_data[3]_i_3__0_n_0 ),
        .I1(\tx_data[3]_i_4__0_n_0 ),
        .O(tx_data[3]),
        .S(rd_state__0[2]));
endmodule

(* ORIG_REF_NAME = "tx_piso_7to1" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_piso_7to1_2
   (dataout_p,
    dataout_n,
    px_clk,
    px_data,
    Q,
    out,
    tx_clkdiv2,
    tx_clkdiv4,
    RST0,
    \tx_data_reg[0]_0 );
  output [0:0]dataout_p;
  output [0:0]dataout_n;
  input px_clk;
  input [6:0]px_data;
  input [0:0]Q;
  input [3:0]out;
  input tx_clkdiv2;
  input tx_clkdiv4;
  input RST0;
  input [0:0]\tx_data_reg[0]_0 ;

  wire \FSM_sequential_rd_state[0]_inv_i_1__1_n_0 ;
  wire \FSM_sequential_rd_state[1]_i_1__1_n_0 ;
  wire \FSM_sequential_rd_state[2]_i_1__1_n_0 ;
  wire [0:0]Q;
  wire RST0;
  wire [0:0]dataout_n;
  wire [0:0]dataout_p;
  wire oserdes_out;
  wire [3:0]out;
  wire [3:0]p_0_in__1;
  wire px_clk;
  wire [6:0]px_data;
  wire rd_addr;
  wire [3:0]rd_addr_reg;
  wire [6:0]rd_curr;
  wire [6:1]rd_last;
  wire [2:1]rd_state__0;
  wire tx_clkdiv2;
  wire tx_clkdiv4;
  wire [3:0]tx_data;
  wire \tx_data[0]_i_2__1_n_0 ;
  wire \tx_data[0]_i_3__1_n_0 ;
  wire \tx_data[1]_i_2__1_n_0 ;
  wire \tx_data[1]_i_3__1_n_0 ;
  wire \tx_data[2]_i_2__1_n_0 ;
  wire \tx_data[2]_i_3__1_n_0 ;
  wire \tx_data[3]_i_1__1_n_0 ;
  wire \tx_data[3]_i_3__1_n_0 ;
  wire \tx_data[3]_i_4__1_n_0 ;
  wire [0:0]\tx_data_reg[0]_0 ;
  wire \tx_data_reg_n_0_[0] ;
  wire \tx_data_reg_n_0_[1] ;
  wire \tx_data_reg_n_0_[2] ;
  wire \tx_data_reg_n_0_[3] ;
  wire \NLW_bit[0].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[1].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[2].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[3].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[4].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[5].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[6].mem_SPO_UNCONNECTED ;
  wire NLW_oserdes_cm_T_OUT_UNCONNECTED;

  LUT3 #(
    .INIT(8'h93)) 
    \FSM_sequential_rd_state[0]_inv_i_1__1 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[0]_inv_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h39)) 
    \FSM_sequential_rd_state[1]_i_1__1 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[1]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h72)) 
    \FSM_sequential_rd_state[2]_i_1__1 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[2]_i_1__1_n_0 ));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  (* inverted = "yes" *) 
  FDSE \FSM_sequential_rd_state_reg[0]_inv 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[0]_inv_i_1__1_n_0 ),
        .Q(rd_addr),
        .S(RST0));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  FDRE \FSM_sequential_rd_state_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[1]_i_1__1_n_0 ),
        .Q(rd_state__0[1]),
        .R(RST0));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  FDRE \FSM_sequential_rd_state_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[2]_i_1__1_n_0 ),
        .Q(rd_state__0[2]),
        .R(RST0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[0].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[0]),
        .DPO(rd_curr[0]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[0].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[1].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[1]),
        .DPO(rd_curr[1]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[1].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[2].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[2]),
        .DPO(rd_curr[2]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[2].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[3].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[3]),
        .DPO(rd_curr[3]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[3].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[4].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[4]),
        .DPO(rd_curr[4]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[4].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[5].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[5]),
        .DPO(rd_curr[5]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[5].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[6].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[6]),
        .DPO(rd_curr[6]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[6].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* XILINX_LEGACY_PRIM = "OBUFDS" *) 
  OBUFDS #(
    .IOSTANDARD("DEFAULT")) 
    io_clk_out
       (.I(oserdes_out),
        .O(dataout_p),
        .OB(dataout_n));
  (* BOX_TYPE = "PRIMITIVE" *) 
  OSERDESE3 #(
    .DATA_WIDTH(4),
    .INIT(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .ODDR_MODE("FALSE"),
    .OSERDES_D_BYPASS("FALSE"),
    .OSERDES_T_BYPASS("FALSE"),
    .SIM_DEVICE("ULTRASCALE_PLUS"),
    .SIM_VERSION(2.000000)) 
    oserdes_cm
       (.CLK(tx_clkdiv2),
        .CLKDIV(tx_clkdiv4),
        .D({1'b0,1'b0,1'b0,1'b0,\tx_data_reg_n_0_[3] ,\tx_data_reg_n_0_[2] ,\tx_data_reg_n_0_[1] ,\tx_data_reg_n_0_[0] }),
        .OQ(oserdes_out),
        .RST(RST0),
        .T(1'b0),
        .T_OUT(NLW_oserdes_cm_T_OUT_UNCONNECTED));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \rd_addr[0]_i_1__1 
       (.I0(rd_addr_reg[0]),
        .O(p_0_in__1[0]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_addr[1]_i_1__1 
       (.I0(rd_addr_reg[1]),
        .I1(rd_addr_reg[0]),
        .O(p_0_in__1[1]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \rd_addr[2]_i_1__1 
       (.I0(rd_addr_reg[2]),
        .I1(rd_addr_reg[1]),
        .I2(rd_addr_reg[0]),
        .O(p_0_in__1[2]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \rd_addr[3]_i_1__1 
       (.I0(rd_addr_reg[3]),
        .I1(rd_addr_reg[1]),
        .I2(rd_addr_reg[0]),
        .I3(rd_addr_reg[2]),
        .O(p_0_in__1[3]));
  FDRE \rd_addr_reg[0] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__1[0]),
        .Q(rd_addr_reg[0]),
        .R(RST0));
  FDRE \rd_addr_reg[1] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__1[1]),
        .Q(rd_addr_reg[1]),
        .R(RST0));
  FDRE \rd_addr_reg[2] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__1[2]),
        .Q(rd_addr_reg[2]),
        .R(RST0));
  FDRE \rd_addr_reg[3] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__1[3]),
        .Q(rd_addr_reg[3]),
        .R(RST0));
  FDRE \rd_last_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[1]),
        .Q(rd_last[1]),
        .R(1'b0));
  FDRE \rd_last_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[2]),
        .Q(rd_last[2]),
        .R(1'b0));
  FDRE \rd_last_reg[3] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[3]),
        .Q(rd_last[3]),
        .R(1'b0));
  FDRE \rd_last_reg[4] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[4]),
        .Q(rd_last[4]),
        .R(1'b0));
  FDRE \rd_last_reg[5] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[5]),
        .Q(rd_last[5]),
        .R(1'b0));
  FDRE \rd_last_reg[6] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[6]),
        .Q(rd_last[6]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[0]_i_2__1 
       (.I0(rd_last[5]),
        .I1(rd_last[1]),
        .I2(rd_state__0[1]),
        .I3(rd_last[4]),
        .I4(rd_addr),
        .I5(rd_curr[0]),
        .O(\tx_data[0]_i_2__1_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[0]_i_3__1 
       (.I0(rd_last[3]),
        .I1(rd_state__0[1]),
        .I2(rd_last[6]),
        .I3(rd_addr),
        .I4(rd_last[2]),
        .O(\tx_data[0]_i_3__1_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[1]_i_2__1 
       (.I0(rd_last[6]),
        .I1(rd_last[2]),
        .I2(rd_state__0[1]),
        .I3(rd_last[5]),
        .I4(rd_addr),
        .I5(rd_curr[1]),
        .O(\tx_data[1]_i_2__1_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[1]_i_3__1 
       (.I0(rd_last[4]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[0]),
        .I3(rd_addr),
        .I4(rd_last[3]),
        .O(\tx_data[1]_i_3__1_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[2]_i_2__1 
       (.I0(rd_curr[0]),
        .I1(rd_last[3]),
        .I2(rd_state__0[1]),
        .I3(rd_last[6]),
        .I4(rd_addr),
        .I5(rd_curr[2]),
        .O(\tx_data[2]_i_2__1_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[2]_i_3__1 
       (.I0(rd_last[5]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[1]),
        .I3(rd_addr),
        .I4(rd_last[4]),
        .O(\tx_data[2]_i_3__1_n_0 ));
  LUT4 #(
    .INIT(16'hDF00)) 
    \tx_data[3]_i_1__1 
       (.I0(rd_state__0[2]),
        .I1(rd_addr),
        .I2(rd_state__0[1]),
        .I3(\tx_data_reg[0]_0 ),
        .O(\tx_data[3]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[3]_i_3__1 
       (.I0(rd_curr[1]),
        .I1(rd_last[4]),
        .I2(rd_state__0[1]),
        .I3(rd_curr[0]),
        .I4(rd_addr),
        .I5(rd_curr[3]),
        .O(\tx_data[3]_i_3__1_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[3]_i_4__1 
       (.I0(rd_last[6]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[2]),
        .I3(rd_addr),
        .I4(rd_last[5]),
        .O(\tx_data[3]_i_4__1_n_0 ));
  FDRE \tx_data_reg[0] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__1_n_0 ),
        .D(tx_data[0]),
        .Q(\tx_data_reg_n_0_[0] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[0]_i_1__1 
       (.I0(\tx_data[0]_i_2__1_n_0 ),
        .I1(\tx_data[0]_i_3__1_n_0 ),
        .O(tx_data[0]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[1] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__1_n_0 ),
        .D(tx_data[1]),
        .Q(\tx_data_reg_n_0_[1] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[1]_i_1__1 
       (.I0(\tx_data[1]_i_2__1_n_0 ),
        .I1(\tx_data[1]_i_3__1_n_0 ),
        .O(tx_data[1]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[2] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__1_n_0 ),
        .D(tx_data[2]),
        .Q(\tx_data_reg_n_0_[2] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[2]_i_1__1 
       (.I0(\tx_data[2]_i_2__1_n_0 ),
        .I1(\tx_data[2]_i_3__1_n_0 ),
        .O(tx_data[2]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[3] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__1_n_0 ),
        .D(tx_data[3]),
        .Q(\tx_data_reg_n_0_[3] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[3]_i_2__1 
       (.I0(\tx_data[3]_i_3__1_n_0 ),
        .I1(\tx_data[3]_i_4__1_n_0 ),
        .O(tx_data[3]),
        .S(rd_state__0[2]));
endmodule

(* ORIG_REF_NAME = "tx_piso_7to1" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tx_piso_7to1_3
   (dataout_p,
    dataout_n,
    px_clk,
    Q,
    out,
    px_data,
    tx_clkdiv2,
    tx_clkdiv4,
    RST0,
    \tx_data_reg[0]_0 );
  output [0:0]dataout_p;
  output [0:0]dataout_n;
  input px_clk;
  input [0:0]Q;
  input [3:0]out;
  input [5:0]px_data;
  input tx_clkdiv2;
  input tx_clkdiv4;
  input RST0;
  input [0:0]\tx_data_reg[0]_0 ;

  wire \FSM_sequential_rd_state[0]_inv_i_1__2_n_0 ;
  wire \FSM_sequential_rd_state[1]_i_1__2_n_0 ;
  wire \FSM_sequential_rd_state[2]_i_1__2_n_0 ;
  wire [0:0]Q;
  wire RST0;
  wire [0:0]dataout_n;
  wire [0:0]dataout_p;
  wire oserdes_out;
  wire [3:0]out;
  wire [3:0]p_0_in__2;
  wire px_clk;
  wire [5:0]px_data;
  wire rd_addr;
  wire [3:0]rd_addr_reg;
  wire [6:0]rd_curr;
  wire [6:1]rd_last;
  wire [2:1]rd_state__0;
  wire tx_clkdiv2;
  wire tx_clkdiv4;
  wire [3:0]tx_data;
  wire \tx_data[0]_i_2__2_n_0 ;
  wire \tx_data[0]_i_3__2_n_0 ;
  wire \tx_data[1]_i_2__2_n_0 ;
  wire \tx_data[1]_i_3__2_n_0 ;
  wire \tx_data[2]_i_2__2_n_0 ;
  wire \tx_data[2]_i_3__2_n_0 ;
  wire \tx_data[3]_i_1__2_n_0 ;
  wire \tx_data[3]_i_3__2_n_0 ;
  wire \tx_data[3]_i_4__2_n_0 ;
  wire [0:0]\tx_data_reg[0]_0 ;
  wire \tx_data_reg_n_0_[0] ;
  wire \tx_data_reg_n_0_[1] ;
  wire \tx_data_reg_n_0_[2] ;
  wire \tx_data_reg_n_0_[3] ;
  wire \NLW_bit[0].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[1].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[2].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[3].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[4].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[5].mem_SPO_UNCONNECTED ;
  wire \NLW_bit[6].mem_SPO_UNCONNECTED ;
  wire NLW_oserdes_cm_T_OUT_UNCONNECTED;

  LUT3 #(
    .INIT(8'h93)) 
    \FSM_sequential_rd_state[0]_inv_i_1__2 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[0]_inv_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h39)) 
    \FSM_sequential_rd_state[1]_i_1__2 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[1]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h72)) 
    \FSM_sequential_rd_state[2]_i_1__2 
       (.I0(rd_state__0[1]),
        .I1(rd_addr),
        .I2(rd_state__0[2]),
        .O(\FSM_sequential_rd_state[2]_i_1__2_n_0 ));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  (* inverted = "yes" *) 
  FDSE \FSM_sequential_rd_state_reg[0]_inv 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[0]_inv_i_1__2_n_0 ),
        .Q(rd_addr),
        .S(RST0));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  FDRE \FSM_sequential_rd_state_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[1]_i_1__2_n_0 ),
        .Q(rd_state__0[1]),
        .R(RST0));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110," *) 
  FDRE \FSM_sequential_rd_state_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(\FSM_sequential_rd_state[2]_i_1__2_n_0 ),
        .Q(rd_state__0[2]),
        .R(RST0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[0].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(1'b0),
        .DPO(rd_curr[0]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[0].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[1].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[0]),
        .DPO(rd_curr[1]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[1].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[2].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[1]),
        .DPO(rd_curr[2]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[2].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[3].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[2]),
        .DPO(rd_curr[3]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[3].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[4].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[3]),
        .DPO(rd_curr[4]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[4].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[5].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[4]),
        .DPO(rd_curr[5]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[5].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  RAM32X1D #(
    .INIT(32'h00000000),
    .IS_WCLK_INVERTED(1'b0)) 
    \bit[6].mem 
       (.A0(out[0]),
        .A1(out[1]),
        .A2(out[2]),
        .A3(out[3]),
        .A4(1'b0),
        .D(px_data[5]),
        .DPO(rd_curr[6]),
        .DPRA0(rd_addr_reg[0]),
        .DPRA1(rd_addr_reg[1]),
        .DPRA2(rd_addr_reg[2]),
        .DPRA3(rd_addr_reg[3]),
        .DPRA4(1'b0),
        .SPO(\NLW_bit[6].mem_SPO_UNCONNECTED ),
        .WCLK(px_clk),
        .WE(Q));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* XILINX_LEGACY_PRIM = "OBUFDS" *) 
  OBUFDS #(
    .IOSTANDARD("DEFAULT")) 
    io_clk_out
       (.I(oserdes_out),
        .O(dataout_p),
        .OB(dataout_n));
  (* BOX_TYPE = "PRIMITIVE" *) 
  OSERDESE3 #(
    .DATA_WIDTH(4),
    .INIT(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .ODDR_MODE("FALSE"),
    .OSERDES_D_BYPASS("FALSE"),
    .OSERDES_T_BYPASS("FALSE"),
    .SIM_DEVICE("ULTRASCALE_PLUS"),
    .SIM_VERSION(2.000000)) 
    oserdes_cm
       (.CLK(tx_clkdiv2),
        .CLKDIV(tx_clkdiv4),
        .D({1'b0,1'b0,1'b0,1'b0,\tx_data_reg_n_0_[3] ,\tx_data_reg_n_0_[2] ,\tx_data_reg_n_0_[1] ,\tx_data_reg_n_0_[0] }),
        .OQ(oserdes_out),
        .RST(RST0),
        .T(1'b0),
        .T_OUT(NLW_oserdes_cm_T_OUT_UNCONNECTED));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \rd_addr[0]_i_1__2 
       (.I0(rd_addr_reg[0]),
        .O(p_0_in__2[0]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rd_addr[1]_i_1__0 
       (.I0(rd_addr_reg[1]),
        .I1(rd_addr_reg[0]),
        .O(p_0_in__2[1]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \rd_addr[2]_i_1__2 
       (.I0(rd_addr_reg[2]),
        .I1(rd_addr_reg[1]),
        .I2(rd_addr_reg[0]),
        .O(p_0_in__2[2]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \rd_addr[3]_i_1__2 
       (.I0(rd_addr_reg[3]),
        .I1(rd_addr_reg[1]),
        .I2(rd_addr_reg[0]),
        .I3(rd_addr_reg[2]),
        .O(p_0_in__2[3]));
  FDRE \rd_addr_reg[0] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__2[0]),
        .Q(rd_addr_reg[0]),
        .R(RST0));
  FDRE \rd_addr_reg[1] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__2[1]),
        .Q(rd_addr_reg[1]),
        .R(RST0));
  FDRE \rd_addr_reg[2] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__2[2]),
        .Q(rd_addr_reg[2]),
        .R(RST0));
  FDRE \rd_addr_reg[3] 
       (.C(tx_clkdiv4),
        .CE(rd_addr),
        .D(p_0_in__2[3]),
        .Q(rd_addr_reg[3]),
        .R(RST0));
  FDRE \rd_last_reg[1] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[1]),
        .Q(rd_last[1]),
        .R(1'b0));
  FDRE \rd_last_reg[2] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[2]),
        .Q(rd_last[2]),
        .R(1'b0));
  FDRE \rd_last_reg[3] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[3]),
        .Q(rd_last[3]),
        .R(1'b0));
  FDRE \rd_last_reg[4] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[4]),
        .Q(rd_last[4]),
        .R(1'b0));
  FDRE \rd_last_reg[5] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[5]),
        .Q(rd_last[5]),
        .R(1'b0));
  FDRE \rd_last_reg[6] 
       (.C(tx_clkdiv4),
        .CE(1'b1),
        .D(rd_curr[6]),
        .Q(rd_last[6]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[0]_i_2__2 
       (.I0(rd_last[5]),
        .I1(rd_last[1]),
        .I2(rd_state__0[1]),
        .I3(rd_last[4]),
        .I4(rd_addr),
        .I5(rd_curr[0]),
        .O(\tx_data[0]_i_2__2_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[0]_i_3__2 
       (.I0(rd_last[3]),
        .I1(rd_state__0[1]),
        .I2(rd_last[6]),
        .I3(rd_addr),
        .I4(rd_last[2]),
        .O(\tx_data[0]_i_3__2_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[1]_i_2__2 
       (.I0(rd_last[6]),
        .I1(rd_last[2]),
        .I2(rd_state__0[1]),
        .I3(rd_last[5]),
        .I4(rd_addr),
        .I5(rd_curr[1]),
        .O(\tx_data[1]_i_2__2_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[1]_i_3__2 
       (.I0(rd_last[4]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[0]),
        .I3(rd_addr),
        .I4(rd_last[3]),
        .O(\tx_data[1]_i_3__2_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[2]_i_2__2 
       (.I0(rd_curr[0]),
        .I1(rd_last[3]),
        .I2(rd_state__0[1]),
        .I3(rd_last[6]),
        .I4(rd_addr),
        .I5(rd_curr[2]),
        .O(\tx_data[2]_i_2__2_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[2]_i_3__2 
       (.I0(rd_last[5]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[1]),
        .I3(rd_addr),
        .I4(rd_last[4]),
        .O(\tx_data[2]_i_3__2_n_0 ));
  LUT4 #(
    .INIT(16'hDF00)) 
    \tx_data[3]_i_1__2 
       (.I0(rd_state__0[2]),
        .I1(rd_addr),
        .I2(rd_state__0[1]),
        .I3(\tx_data_reg[0]_0 ),
        .O(\tx_data[3]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    \tx_data[3]_i_3__2 
       (.I0(rd_curr[1]),
        .I1(rd_last[4]),
        .I2(rd_state__0[1]),
        .I3(rd_curr[0]),
        .I4(rd_addr),
        .I5(rd_curr[3]),
        .O(\tx_data[3]_i_3__2_n_0 ));
  LUT5 #(
    .INIT(32'hBBB888B8)) 
    \tx_data[3]_i_4__2 
       (.I0(rd_last[6]),
        .I1(rd_state__0[1]),
        .I2(rd_curr[2]),
        .I3(rd_addr),
        .I4(rd_last[5]),
        .O(\tx_data[3]_i_4__2_n_0 ));
  FDRE \tx_data_reg[0] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__2_n_0 ),
        .D(tx_data[0]),
        .Q(\tx_data_reg_n_0_[0] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[0]_i_1__2 
       (.I0(\tx_data[0]_i_2__2_n_0 ),
        .I1(\tx_data[0]_i_3__2_n_0 ),
        .O(tx_data[0]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[1] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__2_n_0 ),
        .D(tx_data[1]),
        .Q(\tx_data_reg_n_0_[1] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[1]_i_1__2 
       (.I0(\tx_data[1]_i_2__2_n_0 ),
        .I1(\tx_data[1]_i_3__2_n_0 ),
        .O(tx_data[1]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[2] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__2_n_0 ),
        .D(tx_data[2]),
        .Q(\tx_data_reg_n_0_[2] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[2]_i_1__2 
       (.I0(\tx_data[2]_i_2__2_n_0 ),
        .I1(\tx_data[2]_i_3__2_n_0 ),
        .O(tx_data[2]),
        .S(rd_state__0[2]));
  FDRE \tx_data_reg[3] 
       (.C(tx_clkdiv4),
        .CE(\tx_data[3]_i_1__2_n_0 ),
        .D(tx_data[3]),
        .Q(\tx_data_reg_n_0_[3] ),
        .R(1'b0));
  MUXF7 \tx_data_reg[3]_i_2__2 
       (.I0(\tx_data[3]_i_3__2_n_0 ),
        .I1(\tx_data[3]_i_4__2_n_0 ),
        .O(tx_data[3]),
        .S(rd_state__0[2]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
