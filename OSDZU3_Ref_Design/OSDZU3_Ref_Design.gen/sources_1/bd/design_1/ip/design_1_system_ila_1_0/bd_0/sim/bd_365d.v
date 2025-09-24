//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Command: generate_target bd_365d.bd
//Design : bd_365d
//Purpose: IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "bd_365d,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_365d,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SBD,synth_mode=None}" *) (* HW_HANDOFF = "design_1_system_ila_1_0.hwdef" *) 
module bd_365d
   (SLOT_0_VIDEO_TIMING_active_video,
    SLOT_0_VIDEO_TIMING_hblank,
    SLOT_0_VIDEO_TIMING_hsync,
    SLOT_0_VIDEO_TIMING_vblank,
    SLOT_0_VIDEO_TIMING_vsync,
    SLOT_1_VID_IO_active_video,
    SLOT_1_VID_IO_data,
    SLOT_1_VID_IO_field,
    SLOT_1_VID_IO_hblank,
    SLOT_1_VID_IO_hsync,
    SLOT_1_VID_IO_vblank,
    SLOT_1_VID_IO_vsync,
    clk,
    probe0,
    probe1,
    probe2);
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 SLOT_0_VIDEO_TIMING ACTIVE_VIDEO" *) (* X_INTERFACE_MODE = "Monitor SlaveType" *) input SLOT_0_VIDEO_TIMING_active_video;
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 SLOT_0_VIDEO_TIMING HBLANK" *) input SLOT_0_VIDEO_TIMING_hblank;
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 SLOT_0_VIDEO_TIMING HSYNC" *) input SLOT_0_VIDEO_TIMING_hsync;
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 SLOT_0_VIDEO_TIMING VBLANK" *) input SLOT_0_VIDEO_TIMING_vblank;
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 SLOT_0_VIDEO_TIMING VSYNC" *) input SLOT_0_VIDEO_TIMING_vsync;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 SLOT_1_VID_IO ACTIVE_VIDEO" *) (* X_INTERFACE_MODE = "Monitor SlaveType" *) input SLOT_1_VID_IO_active_video;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 SLOT_1_VID_IO DATA" *) input [23:0]SLOT_1_VID_IO_data;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 SLOT_1_VID_IO FIELD" *) input SLOT_1_VID_IO_field;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 SLOT_1_VID_IO HBLANK" *) input SLOT_1_VID_IO_hblank;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 SLOT_1_VID_IO HSYNC" *) input SLOT_1_VID_IO_hsync;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 SLOT_1_VID_IO VBLANK" *) input SLOT_1_VID_IO_vblank;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 SLOT_1_VID_IO VSYNC" *) input SLOT_1_VID_IO_vsync;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk2, FREQ_HZ 59999401, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input clk;
  input [0:0]probe0;
  input [0:0]probe1;
  input [0:0]probe2;

  wire SLOT_0_VIDEO_TIMING_active_video;
  wire SLOT_0_VIDEO_TIMING_hblank;
  wire SLOT_0_VIDEO_TIMING_hsync;
  wire SLOT_0_VIDEO_TIMING_vblank;
  wire SLOT_0_VIDEO_TIMING_vsync;
  wire SLOT_1_VID_IO_active_video;
  wire [23:0]SLOT_1_VID_IO_data;
  wire SLOT_1_VID_IO_field;
  wire SLOT_1_VID_IO_hblank;
  wire SLOT_1_VID_IO_hsync;
  wire SLOT_1_VID_IO_vblank;
  wire SLOT_1_VID_IO_vsync;
  wire clk;
  wire [0:0]probe0;
  wire [0:0]probe1;
  wire [0:0]probe2;

  bd_365d_ila_lib_0 ila_lib
       (.clk(clk),
        .probe0(probe0),
        .probe1(probe1),
        .probe10(SLOT_1_VID_IO_field),
        .probe11(SLOT_1_VID_IO_hblank),
        .probe12(SLOT_1_VID_IO_hsync),
        .probe13(SLOT_1_VID_IO_vblank),
        .probe14(SLOT_1_VID_IO_vsync),
        .probe2(probe2),
        .probe3(SLOT_0_VIDEO_TIMING_active_video),
        .probe4(SLOT_0_VIDEO_TIMING_hblank),
        .probe5(SLOT_0_VIDEO_TIMING_hsync),
        .probe6(SLOT_0_VIDEO_TIMING_vblank),
        .probe7(SLOT_0_VIDEO_TIMING_vsync),
        .probe8(SLOT_1_VID_IO_active_video),
        .probe9(SLOT_1_VID_IO_data));
endmodule
