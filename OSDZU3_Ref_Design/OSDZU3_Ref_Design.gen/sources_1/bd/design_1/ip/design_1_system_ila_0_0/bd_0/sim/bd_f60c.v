//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Command: generate_target bd_f60c.bd
//Design : bd_f60c
//Purpose: IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "bd_f60c,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_f60c,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SBD,synth_mode=None}" *) (* HW_HANDOFF = "design_1_system_ila_0_0.hwdef" *) 
module bd_f60c
   (SLOT_0_AXIS_tdata,
    SLOT_0_AXIS_tdest,
    SLOT_0_AXIS_tid,
    SLOT_0_AXIS_tkeep,
    SLOT_0_AXIS_tlast,
    SLOT_0_AXIS_tready,
    SLOT_0_AXIS_tstrb,
    SLOT_0_AXIS_tuser,
    SLOT_0_AXIS_tvalid,
    SLOT_1_AXIS_tdata,
    SLOT_1_AXIS_tdest,
    SLOT_1_AXIS_tid,
    SLOT_1_AXIS_tkeep,
    SLOT_1_AXIS_tlast,
    SLOT_1_AXIS_tready,
    SLOT_1_AXIS_tstrb,
    SLOT_1_AXIS_tuser,
    SLOT_1_AXIS_tvalid,
    SLOT_2_AXIS_tdata,
    SLOT_2_AXIS_tdest,
    SLOT_2_AXIS_tid,
    SLOT_2_AXIS_tkeep,
    SLOT_2_AXIS_tlast,
    SLOT_2_AXIS_tready,
    SLOT_2_AXIS_tstrb,
    SLOT_2_AXIS_tuser,
    SLOT_2_AXIS_tvalid,
    clk,
    probe0,
    resetn);
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TDATA" *) (* X_INTERFACE_MODE = "Monitor SlaveType" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME SLOT_0_AXIS, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk1, FREQ_HZ 199998001, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 1, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 3, TDEST_WIDTH 1, TID_WIDTH 1, TUSER_WIDTH 1" *) input [23:0]SLOT_0_AXIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TDEST" *) input [0:0]SLOT_0_AXIS_tdest;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TID" *) input [0:0]SLOT_0_AXIS_tid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TKEEP" *) input [2:0]SLOT_0_AXIS_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TLAST" *) input SLOT_0_AXIS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TREADY" *) input SLOT_0_AXIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TSTRB" *) input [2:0]SLOT_0_AXIS_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TUSER" *) input [0:0]SLOT_0_AXIS_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TVALID" *) input SLOT_0_AXIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_1_AXIS TDATA" *) (* X_INTERFACE_MODE = "Monitor SlaveType" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME SLOT_1_AXIS, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk1, FREQ_HZ 199998001, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 1, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 4, TDEST_WIDTH 1, TID_WIDTH 1, TUSER_WIDTH 1" *) input [31:0]SLOT_1_AXIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_1_AXIS TDEST" *) input [0:0]SLOT_1_AXIS_tdest;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_1_AXIS TID" *) input [0:0]SLOT_1_AXIS_tid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_1_AXIS TKEEP" *) input [3:0]SLOT_1_AXIS_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_1_AXIS TLAST" *) input SLOT_1_AXIS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_1_AXIS TREADY" *) input SLOT_1_AXIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_1_AXIS TSTRB" *) input [3:0]SLOT_1_AXIS_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_1_AXIS TUSER" *) input [0:0]SLOT_1_AXIS_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_1_AXIS TVALID" *) input SLOT_1_AXIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_2_AXIS TDATA" *) (* X_INTERFACE_MODE = "Monitor SlaveType" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME SLOT_2_AXIS, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk1, FREQ_HZ 199998001, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 1, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 3, TDEST_WIDTH 1, TID_WIDTH 1, TUSER_WIDTH 1" *) input [23:0]SLOT_2_AXIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_2_AXIS TDEST" *) input [0:0]SLOT_2_AXIS_tdest;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_2_AXIS TID" *) input [0:0]SLOT_2_AXIS_tid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_2_AXIS TKEEP" *) input [2:0]SLOT_2_AXIS_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_2_AXIS TLAST" *) input SLOT_2_AXIS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_2_AXIS TREADY" *) input SLOT_2_AXIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_2_AXIS TSTRB" *) input [2:0]SLOT_2_AXIS_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_2_AXIS TUSER" *) input [0:0]SLOT_2_AXIS_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_2_AXIS TVALID" *) input SLOT_2_AXIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, ASSOCIATED_BUSIF SLOT_0_AXIS:SLOT_1_AXIS:SLOT_2_AXIS, ASSOCIATED_RESET resetn, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk1, FREQ_HZ 199998001, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input clk;
  input [0:0]probe0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input resetn;

  wire [23:0]SLOT_0_AXIS_tdata;
  wire [0:0]SLOT_0_AXIS_tdest;
  wire [0:0]SLOT_0_AXIS_tid;
  wire [2:0]SLOT_0_AXIS_tkeep;
  wire SLOT_0_AXIS_tlast;
  wire SLOT_0_AXIS_tready;
  wire [2:0]SLOT_0_AXIS_tstrb;
  wire [0:0]SLOT_0_AXIS_tuser;
  wire SLOT_0_AXIS_tvalid;
  wire [31:0]SLOT_1_AXIS_tdata;
  wire [0:0]SLOT_1_AXIS_tdest;
  wire [0:0]SLOT_1_AXIS_tid;
  wire [3:0]SLOT_1_AXIS_tkeep;
  wire SLOT_1_AXIS_tlast;
  wire SLOT_1_AXIS_tready;
  wire [3:0]SLOT_1_AXIS_tstrb;
  wire [0:0]SLOT_1_AXIS_tuser;
  wire SLOT_1_AXIS_tvalid;
  wire [23:0]SLOT_2_AXIS_tdata;
  wire [0:0]SLOT_2_AXIS_tdest;
  wire [0:0]SLOT_2_AXIS_tid;
  wire [2:0]SLOT_2_AXIS_tkeep;
  wire SLOT_2_AXIS_tlast;
  wire SLOT_2_AXIS_tready;
  wire [2:0]SLOT_2_AXIS_tstrb;
  wire [0:0]SLOT_2_AXIS_tuser;
  wire SLOT_2_AXIS_tvalid;
  wire clk;
  wire [23:0]net_slot_0_axis_tdata;
  wire [0:0]net_slot_0_axis_tdest;
  wire [0:0]net_slot_0_axis_tid;
  wire [2:0]net_slot_0_axis_tkeep;
  wire net_slot_0_axis_tlast;
  wire net_slot_0_axis_tready;
  wire [2:0]net_slot_0_axis_tstrb;
  wire [0:0]net_slot_0_axis_tuser;
  wire net_slot_0_axis_tvalid;
  wire [31:0]net_slot_1_axis_tdata;
  wire [0:0]net_slot_1_axis_tdest;
  wire [0:0]net_slot_1_axis_tid;
  wire [3:0]net_slot_1_axis_tkeep;
  wire net_slot_1_axis_tlast;
  wire net_slot_1_axis_tready;
  wire [3:0]net_slot_1_axis_tstrb;
  wire [0:0]net_slot_1_axis_tuser;
  wire net_slot_1_axis_tvalid;
  wire [23:0]net_slot_2_axis_tdata;
  wire [0:0]net_slot_2_axis_tdest;
  wire [0:0]net_slot_2_axis_tid;
  wire [2:0]net_slot_2_axis_tkeep;
  wire net_slot_2_axis_tlast;
  wire net_slot_2_axis_tready;
  wire [2:0]net_slot_2_axis_tstrb;
  wire [0:0]net_slot_2_axis_tuser;
  wire net_slot_2_axis_tvalid;
  wire [0:0]probe0;
  wire resetn;

  bd_f60c_g_inst_0 g_inst
       (.aclk(clk),
        .aresetn(resetn),
        .m_slot_0_axis_tdata(net_slot_0_axis_tdata),
        .m_slot_0_axis_tdest(net_slot_0_axis_tdest),
        .m_slot_0_axis_tid(net_slot_0_axis_tid),
        .m_slot_0_axis_tkeep(net_slot_0_axis_tkeep),
        .m_slot_0_axis_tlast(net_slot_0_axis_tlast),
        .m_slot_0_axis_tready(net_slot_0_axis_tready),
        .m_slot_0_axis_tstrb(net_slot_0_axis_tstrb),
        .m_slot_0_axis_tuser(net_slot_0_axis_tuser),
        .m_slot_0_axis_tvalid(net_slot_0_axis_tvalid),
        .m_slot_1_axis_tdata(net_slot_1_axis_tdata),
        .m_slot_1_axis_tdest(net_slot_1_axis_tdest),
        .m_slot_1_axis_tid(net_slot_1_axis_tid),
        .m_slot_1_axis_tkeep(net_slot_1_axis_tkeep),
        .m_slot_1_axis_tlast(net_slot_1_axis_tlast),
        .m_slot_1_axis_tready(net_slot_1_axis_tready),
        .m_slot_1_axis_tstrb(net_slot_1_axis_tstrb),
        .m_slot_1_axis_tuser(net_slot_1_axis_tuser),
        .m_slot_1_axis_tvalid(net_slot_1_axis_tvalid),
        .m_slot_2_axis_tdata(net_slot_2_axis_tdata),
        .m_slot_2_axis_tdest(net_slot_2_axis_tdest),
        .m_slot_2_axis_tid(net_slot_2_axis_tid),
        .m_slot_2_axis_tkeep(net_slot_2_axis_tkeep),
        .m_slot_2_axis_tlast(net_slot_2_axis_tlast),
        .m_slot_2_axis_tready(net_slot_2_axis_tready),
        .m_slot_2_axis_tstrb(net_slot_2_axis_tstrb),
        .m_slot_2_axis_tuser(net_slot_2_axis_tuser),
        .m_slot_2_axis_tvalid(net_slot_2_axis_tvalid),
        .slot_0_axis_tdata(SLOT_0_AXIS_tdata),
        .slot_0_axis_tdest(SLOT_0_AXIS_tdest),
        .slot_0_axis_tid(SLOT_0_AXIS_tid),
        .slot_0_axis_tkeep(SLOT_0_AXIS_tkeep),
        .slot_0_axis_tlast(SLOT_0_AXIS_tlast),
        .slot_0_axis_tready(SLOT_0_AXIS_tready),
        .slot_0_axis_tstrb(SLOT_0_AXIS_tstrb),
        .slot_0_axis_tuser(SLOT_0_AXIS_tuser),
        .slot_0_axis_tvalid(SLOT_0_AXIS_tvalid),
        .slot_1_axis_tdata(SLOT_1_AXIS_tdata),
        .slot_1_axis_tdest(SLOT_1_AXIS_tdest),
        .slot_1_axis_tid(SLOT_1_AXIS_tid),
        .slot_1_axis_tkeep(SLOT_1_AXIS_tkeep),
        .slot_1_axis_tlast(SLOT_1_AXIS_tlast),
        .slot_1_axis_tready(SLOT_1_AXIS_tready),
        .slot_1_axis_tstrb(SLOT_1_AXIS_tstrb),
        .slot_1_axis_tuser(SLOT_1_AXIS_tuser),
        .slot_1_axis_tvalid(SLOT_1_AXIS_tvalid),
        .slot_2_axis_tdata(SLOT_2_AXIS_tdata),
        .slot_2_axis_tdest(SLOT_2_AXIS_tdest),
        .slot_2_axis_tid(SLOT_2_AXIS_tid),
        .slot_2_axis_tkeep(SLOT_2_AXIS_tkeep),
        .slot_2_axis_tlast(SLOT_2_AXIS_tlast),
        .slot_2_axis_tready(SLOT_2_AXIS_tready),
        .slot_2_axis_tstrb(SLOT_2_AXIS_tstrb),
        .slot_2_axis_tuser(SLOT_2_AXIS_tuser),
        .slot_2_axis_tvalid(SLOT_2_AXIS_tvalid));
  bd_f60c_ila_lib_0 ila_lib
       (.clk(clk),
        .probe0(probe0),
        .probe1(net_slot_0_axis_tdata),
        .probe10(net_slot_1_axis_tdata),
        .probe11(net_slot_1_axis_tdest),
        .probe12(net_slot_1_axis_tid),
        .probe13(net_slot_1_axis_tkeep),
        .probe14(net_slot_1_axis_tstrb),
        .probe15(net_slot_1_axis_tuser),
        .probe16(net_slot_1_axis_tvalid),
        .probe17(net_slot_1_axis_tready),
        .probe18(net_slot_1_axis_tlast),
        .probe19(net_slot_2_axis_tdata),
        .probe2(net_slot_0_axis_tdest),
        .probe20(net_slot_2_axis_tdest),
        .probe21(net_slot_2_axis_tid),
        .probe22(net_slot_2_axis_tkeep),
        .probe23(net_slot_2_axis_tstrb),
        .probe24(net_slot_2_axis_tuser),
        .probe25(net_slot_2_axis_tvalid),
        .probe26(net_slot_2_axis_tready),
        .probe27(net_slot_2_axis_tlast),
        .probe3(net_slot_0_axis_tid),
        .probe4(net_slot_0_axis_tkeep),
        .probe5(net_slot_0_axis_tstrb),
        .probe6(net_slot_0_axis_tuser),
        .probe7(net_slot_0_axis_tvalid),
        .probe8(net_slot_0_axis_tready),
        .probe9(net_slot_0_axis_tlast));
endmodule
