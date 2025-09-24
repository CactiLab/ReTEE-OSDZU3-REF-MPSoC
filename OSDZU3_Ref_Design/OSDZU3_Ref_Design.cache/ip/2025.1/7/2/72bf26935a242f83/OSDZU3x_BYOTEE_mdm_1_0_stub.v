// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
// Date        : Fri Sep  5 20:55:22 2025
// Host        : e-ubuntu running 64-bit Ubuntu 24.04.3 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ OSDZU3x_BYOTEE_mdm_1_0_stub.v
// Design      : OSDZU3x_BYOTEE_mdm_1_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu3eg-sfvc784-1-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "OSDZU3x_BYOTEE_mdm_1_0,MDM,{}" *) (* core_generation_info = "OSDZU3x_BYOTEE_mdm_1_0,MDM,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mdm,x_ipVersion=3.2,x_ipCoreRevision=28,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_FAMILY=zynquplus,C_DEVICE=xczu3eg,C_JTAG_CHAIN=2,C_USE_BSCAN=0,C_BSCANID=76547328,C_DEBUG_INTERFACE=0,C_USE_CONFIG_RESET=0,C_AVOID_PRIMITIVES=0,C_INTERCONNECT=2,C_MB_DBG_PORTS=1,C_USE_UART=1,C_DBG_REG_ACCESS=1,C_DBG_MEM_ACCESS=1,C_USE_CROSS_TRIGGER=0,C_EXT_TRIG_RESET_VALUE=0xF1234,C_TRACE_OUTPUT=3,C_TRACE_DATA_WIDTH=32,C_TRACE_CLK_FREQ_HZ=200000000,C_TRACE_CLK_OUT_PHASE=90,C_TRACE_ASYNC_RESET=0,C_TRACE_PROTOCOL=1,C_TRACE_ID=110,C_S_AXI_ADDR_WIDTH=5,C_S_AXI_DATA_WIDTH=32,C_S_AXI_ACLK_FREQ_HZ=99999001,C_M_AXI_ADDR_WIDTH=32,C_M_AXI_DATA_WIDTH=32,C_M_AXI_THREAD_ID_WIDTH=1,C_ADDR_SIZE=32,C_DATA_SIZE=32,C_LMB_PROTOCOL=0,C_M_AXIS_DATA_WIDTH=32,C_M_AXIS_ID_WIDTH=7}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "MDM,Vivado 2025.1" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(S_AXI_ACLK, S_AXI_ARESETN, M_AXI_ACLK, 
  M_AXI_ARESETN, Interrupt, Debug_SYS_Rst, S_AXI_AWADDR, S_AXI_AWVALID, S_AXI_AWREADY, 
  S_AXI_WDATA, S_AXI_WSTRB, S_AXI_WVALID, S_AXI_WREADY, S_AXI_BRESP, S_AXI_BVALID, 
  S_AXI_BREADY, S_AXI_ARADDR, S_AXI_ARVALID, S_AXI_ARREADY, S_AXI_RDATA, S_AXI_RRESP, 
  S_AXI_RVALID, S_AXI_RREADY, M_AXI_AWID, M_AXI_AWADDR, M_AXI_AWLEN, M_AXI_AWSIZE, 
  M_AXI_AWBURST, M_AXI_AWLOCK, M_AXI_AWCACHE, M_AXI_AWPROT, M_AXI_AWQOS, M_AXI_AWVALID, 
  M_AXI_AWREADY, M_AXI_WDATA, M_AXI_WSTRB, M_AXI_WLAST, M_AXI_WVALID, M_AXI_WREADY, 
  M_AXI_BRESP, M_AXI_BID, M_AXI_BVALID, M_AXI_BREADY, M_AXI_ARID, M_AXI_ARADDR, M_AXI_ARLEN, 
  M_AXI_ARSIZE, M_AXI_ARBURST, M_AXI_ARLOCK, M_AXI_ARCACHE, M_AXI_ARPROT, M_AXI_ARQOS, 
  M_AXI_ARVALID, M_AXI_ARREADY, M_AXI_RID, M_AXI_RDATA, M_AXI_RRESP, M_AXI_RLAST, M_AXI_RVALID, 
  M_AXI_RREADY, LMB_Data_Addr_0, LMB_Addr_Strobe_0, LMB_Ready_0, LMB_Byte_Enable_0, 
  LMB_Data_Read_0, LMB_Data_Write_0, LMB_Read_Strobe_0, LMB_Write_Strobe_0, LMB_CE_0, 
  LMB_UE_0, LMB_Wait_0, Dbg_Clk_0, Dbg_TDI_0, Dbg_TDO_0, Dbg_Reg_En_0, Dbg_Capture_0, 
  Dbg_Shift_0, Dbg_Update_0, Dbg_Rst_0, Dbg_TrClk_0, Dbg_TrData_0, Dbg_TrReady_0, 
  Dbg_TrValid_0, Dbg_Disable_0)
/* synthesis syn_black_box black_box_pad_pin="S_AXI_ARESETN,M_AXI_ARESETN,Interrupt,Debug_SYS_Rst,S_AXI_AWADDR[4:0],S_AXI_AWVALID,S_AXI_AWREADY,S_AXI_WDATA[31:0],S_AXI_WSTRB[3:0],S_AXI_WVALID,S_AXI_WREADY,S_AXI_BRESP[1:0],S_AXI_BVALID,S_AXI_BREADY,S_AXI_ARADDR[4:0],S_AXI_ARVALID,S_AXI_ARREADY,S_AXI_RDATA[31:0],S_AXI_RRESP[1:0],S_AXI_RVALID,S_AXI_RREADY,M_AXI_AWID[0:0],M_AXI_AWADDR[31:0],M_AXI_AWLEN[7:0],M_AXI_AWSIZE[2:0],M_AXI_AWBURST[1:0],M_AXI_AWLOCK,M_AXI_AWCACHE[3:0],M_AXI_AWPROT[2:0],M_AXI_AWQOS[3:0],M_AXI_AWVALID,M_AXI_AWREADY,M_AXI_WDATA[31:0],M_AXI_WSTRB[3:0],M_AXI_WLAST,M_AXI_WVALID,M_AXI_WREADY,M_AXI_BRESP[1:0],M_AXI_BID[0:0],M_AXI_BVALID,M_AXI_BREADY,M_AXI_ARID[0:0],M_AXI_ARADDR[31:0],M_AXI_ARLEN[7:0],M_AXI_ARSIZE[2:0],M_AXI_ARBURST[1:0],M_AXI_ARLOCK,M_AXI_ARCACHE[3:0],M_AXI_ARPROT[2:0],M_AXI_ARQOS[3:0],M_AXI_ARVALID,M_AXI_ARREADY,M_AXI_RID[0:0],M_AXI_RDATA[31:0],M_AXI_RRESP[1:0],M_AXI_RLAST,M_AXI_RVALID,M_AXI_RREADY,LMB_Data_Addr_0[0:31],LMB_Addr_Strobe_0,LMB_Ready_0,LMB_Byte_Enable_0[0:3],LMB_Data_Read_0[0:31],LMB_Data_Write_0[0:31],LMB_Read_Strobe_0,LMB_Write_Strobe_0,LMB_CE_0,LMB_UE_0,LMB_Wait_0,Dbg_TDI_0,Dbg_TDO_0,Dbg_Reg_En_0[0:7],Dbg_Capture_0,Dbg_Shift_0,Dbg_Rst_0,Dbg_TrData_0[0:35],Dbg_TrReady_0,Dbg_TrValid_0,Dbg_Disable_0" */
/* synthesis syn_force_seq_prim="S_AXI_ACLK" */
/* synthesis syn_force_seq_prim="M_AXI_ACLK" */
/* synthesis syn_force_seq_prim="Dbg_Clk_0" */
/* synthesis syn_force_seq_prim="Dbg_Update_0" */
/* synthesis syn_force_seq_prim="Dbg_TrClk_0" */;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.S_AXI_ACLK CLK" *) (* x_interface_mode = "slave CLK.S_AXI_ACLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.S_AXI_ACLK, ASSOCIATED_BUSIF S_AXI:MBDEBUG_AXI_0:MBDEBUG_AXI_1:MBDEBUG_AXI_2:MBDEBUG_AXI_3:MBDEBUG_AXI_4:MBDEBUG_AXI_5:MBDEBUG_AXI_6:MBDEBUG_AXI_7:MBDEBUG_AXI_8:MBDEBUG_AXI_9:MBDEBUG_AXI_10:MBDEBUG_AXI_11:MBDEBUG_AXI_12:MBDEBUG_AXI_13:MBDEBUG_AXI_14:MBDEBUG_AXI_15:MBDEBUG_AXI_16:MBDEBUG_AXI_17:MBDEBUG_AXI_18:MBDEBUG_AXI_19:MBDEBUG_AXI_20:MBDEBUG_AXI_21:MBDEBUG_AXI_22:MBDEBUG_AXI_23:MBDEBUG_AXI_24:MBDEBUG_AXI_25:MBDEBUG_AXI_26:MBDEBUG_AXI_27:MBDEBUG_AXI_28:MBDEBUG_AXI_29:MBDEBUG_AXI_30:MBDEBUG_AXI_31, ASSOCIATED_RESET S_AXI_ARESETN, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1_pl_clk0, INSERT_VIP 0" *) input S_AXI_ACLK /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.S_AXI_ARESETN RST" *) (* x_interface_mode = "slave RST.S_AXI_ARESETN" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.S_AXI_ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input S_AXI_ARESETN;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.M_AXI_ACLK CLK" *) (* x_interface_mode = "slave CLK.M_AXI_ACLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.M_AXI_ACLK, ASSOCIATED_BUSIF M_AXI:LMB_0:LMB_1:LMB_2:LMB_3:LMB_4:LMB_5:LMB_6:LMB_7:LMB_8:LMB_9:LMB_10:LMB_11:LMB_12:LMB_13:LMB_14:LMB_15:LMB_16:LMB_17:LMB_18:LMB_19:LMB_20:LMB_21:LMB_22:LMB_23:LMB_24:LMB_25:LMB_26:LMB_27:LMB_28:LMB_29:LMB_30:LMB_31, ASSOCIATED_RESET M_AXI_ARESETN, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1_pl_clk0, INSERT_VIP 0" *) input M_AXI_ACLK /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.M_AXI_ARESETN RST" *) (* x_interface_mode = "slave RST.M_AXI_ARESETN" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.M_AXI_ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input M_AXI_ARESETN;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 INTERRUPT.INTERRUPT INTERRUPT" *) (* x_interface_mode = "master INTERRUPT.INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME INTERRUPT.INTERRUPT, SENSITIVITY EDGE_RISING, SUGGESTED_PRIORITY HIGH, PortWidth 1" *) output Interrupt;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.Debug_SYS_Rst RST" *) (* x_interface_mode = "master RST.Debug_SYS_Rst" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.Debug_SYS_Rst, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) output Debug_SYS_Rst;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *) (* x_interface_mode = "slave S_AXI" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 99999001, ID_WIDTH 0, ADDR_WIDTH 5, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [4:0]S_AXI_AWADDR;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *) input S_AXI_AWVALID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *) output S_AXI_AWREADY;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WDATA" *) input [31:0]S_AXI_WDATA;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *) input [3:0]S_AXI_WSTRB;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *) input S_AXI_WVALID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *) output S_AXI_WREADY;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *) output [1:0]S_AXI_BRESP;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *) output S_AXI_BVALID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *) input S_AXI_BREADY;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *) input [4:0]S_AXI_ARADDR;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *) input S_AXI_ARVALID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *) output S_AXI_ARREADY;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *) output [31:0]S_AXI_RDATA;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *) output [1:0]S_AXI_RRESP;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *) output S_AXI_RVALID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *) input S_AXI_RREADY;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWID" *) (* x_interface_mode = "master M_AXI" *) (* x_interface_parameter = "XIL_INTERFACENAME M_AXI, ID_WIDTH 0, READ_WRITE_MODE READ_WRITE, SUPPORTS_NARROW_BURST 0, ADDR_WIDTH 32, PROTOCOL AXI4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, WUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, RUSER_BITS_PER_BYTE 0, BUSER_WIDTH 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, DATA_WIDTH 32, MAX_BURST_LENGTH 32, HAS_BURST 1, FREQ_HZ 99999001, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.0, CLK_DOMAIN OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1_pl_clk0, INSERT_VIP 0" *) output [0:0]M_AXI_AWID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWADDR" *) output [31:0]M_AXI_AWADDR;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWLEN" *) output [7:0]M_AXI_AWLEN;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWSIZE" *) output [2:0]M_AXI_AWSIZE;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWBURST" *) output [1:0]M_AXI_AWBURST;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWLOCK" *) output M_AXI_AWLOCK;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWCACHE" *) output [3:0]M_AXI_AWCACHE;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWPROT" *) output [2:0]M_AXI_AWPROT;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWQOS" *) output [3:0]M_AXI_AWQOS;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWVALID" *) output M_AXI_AWVALID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI AWREADY" *) input M_AXI_AWREADY;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI WDATA" *) output [31:0]M_AXI_WDATA;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI WSTRB" *) output [3:0]M_AXI_WSTRB;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI WLAST" *) output M_AXI_WLAST;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI WVALID" *) output M_AXI_WVALID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI WREADY" *) input M_AXI_WREADY;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI BRESP" *) input [1:0]M_AXI_BRESP;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI BID" *) input [0:0]M_AXI_BID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI BVALID" *) input M_AXI_BVALID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI BREADY" *) output M_AXI_BREADY;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARID" *) output [0:0]M_AXI_ARID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARADDR" *) output [31:0]M_AXI_ARADDR;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARLEN" *) output [7:0]M_AXI_ARLEN;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARSIZE" *) output [2:0]M_AXI_ARSIZE;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARBURST" *) output [1:0]M_AXI_ARBURST;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARLOCK" *) output M_AXI_ARLOCK;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARCACHE" *) output [3:0]M_AXI_ARCACHE;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARPROT" *) output [2:0]M_AXI_ARPROT;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARQOS" *) output [3:0]M_AXI_ARQOS;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARVALID" *) output M_AXI_ARVALID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI ARREADY" *) input M_AXI_ARREADY;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI RID" *) input [0:0]M_AXI_RID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI RDATA" *) input [31:0]M_AXI_RDATA;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI RRESP" *) input [1:0]M_AXI_RRESP;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI RLAST" *) input M_AXI_RLAST;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI RVALID" *) input M_AXI_RVALID;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 M_AXI RREADY" *) output M_AXI_RREADY;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 ABUS" *) (* x_interface_mode = "master LMB_0" *) (* x_interface_parameter = "XIL_INTERFACENAME LMB_0, ADDR_WIDTH 32, DATA_WIDTH 32, PROTOCOL STANDARD, READ_WRITE_MODE READ_WRITE" *) output [0:31]LMB_Data_Addr_0;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 ADDRSTROBE" *) output LMB_Addr_Strobe_0;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 READY" *) input LMB_Ready_0;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 BE" *) output [0:3]LMB_Byte_Enable_0;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 READDBUS" *) input [0:31]LMB_Data_Read_0;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 WRITEDBUS" *) output [0:31]LMB_Data_Write_0;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 READSTROBE" *) output LMB_Read_Strobe_0;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 WRITESTROBE" *) output LMB_Write_Strobe_0;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 CE" *) input LMB_CE_0;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 UE" *) input LMB_UE_0;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 LMB_0 WAIT" *) input LMB_Wait_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 CLK" *) (* x_interface_mode = "master MBDEBUG_0" *) output Dbg_Clk_0 /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TDI" *) output Dbg_TDI_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TDO" *) input Dbg_TDO_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 REG_EN" *) output [0:7]Dbg_Reg_En_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 CAPTURE" *) output Dbg_Capture_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 SHIFT" *) output Dbg_Shift_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 UPDATE" *) output Dbg_Update_0 /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RST" *) output Dbg_Rst_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRCLK" *) output Dbg_TrClk_0 /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRDATA" *) input [0:35]Dbg_TrData_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRREADY" *) output Dbg_TrReady_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRVALID" *) input Dbg_TrValid_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 DISABLE" *) output Dbg_Disable_0;
endmodule
