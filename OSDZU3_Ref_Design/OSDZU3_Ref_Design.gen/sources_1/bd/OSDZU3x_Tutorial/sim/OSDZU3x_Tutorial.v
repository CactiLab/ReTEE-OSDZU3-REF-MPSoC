//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
//Date        : Mon Sep  8 15:43:19 2025
//Host        : e-ubuntu running 64-bit Ubuntu 24.04.3 LTS
//Command     : generate_target OSDZU3x_Tutorial.bd
//Design      : OSDZU3x_Tutorial
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "OSDZU3x_Tutorial,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=OSDZU3x_Tutorial,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=17,numReposBlks=16,numNonXlnxBlks=0,numHierBlks=1,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=4,da_board_cnt=4,da_clkrst_cnt=3,da_microblaze_riscv_cnt=1,da_zynq_ultra_ps_e_cnt=1,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "OSDZU3x_Tutorial.hwdef" *) 
module OSDZU3x_Tutorial
   (dip_switches_8bits_tri_i,
    leds_8bits_tri_o,
    push_buttons_3bits_tri_i);
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 dip_switches_8bits TRI_I" *) (* X_INTERFACE_MODE = "Master" *) input [7:0]dip_switches_8bits_tri_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 leds_8bits TRI_O" *) (* X_INTERFACE_MODE = "Master" *) output [7:0]leds_8bits_tri_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 push_buttons_3bits TRI_I" *) (* X_INTERFACE_MODE = "Master" *) input [2:0]push_buttons_3bits_tri_i;

  wire axi_gpio_0_ip2intc_irpt;
  wire [8:0]axi_smc_M00_AXI_ARADDR;
  wire axi_smc_M00_AXI_ARREADY;
  wire axi_smc_M00_AXI_ARVALID;
  wire [8:0]axi_smc_M00_AXI_AWADDR;
  wire axi_smc_M00_AXI_AWREADY;
  wire axi_smc_M00_AXI_AWVALID;
  wire axi_smc_M00_AXI_BREADY;
  wire [1:0]axi_smc_M00_AXI_BRESP;
  wire axi_smc_M00_AXI_BVALID;
  wire [31:0]axi_smc_M00_AXI_RDATA;
  wire axi_smc_M00_AXI_RREADY;
  wire [1:0]axi_smc_M00_AXI_RRESP;
  wire axi_smc_M00_AXI_RVALID;
  wire [31:0]axi_smc_M00_AXI_WDATA;
  wire axi_smc_M00_AXI_WREADY;
  wire [3:0]axi_smc_M00_AXI_WSTRB;
  wire axi_smc_M00_AXI_WVALID;
  wire [8:0]axi_smc_M01_AXI_ARADDR;
  wire axi_smc_M01_AXI_ARREADY;
  wire axi_smc_M01_AXI_ARVALID;
  wire [8:0]axi_smc_M01_AXI_AWADDR;
  wire axi_smc_M01_AXI_AWREADY;
  wire axi_smc_M01_AXI_AWVALID;
  wire axi_smc_M01_AXI_BREADY;
  wire [1:0]axi_smc_M01_AXI_BRESP;
  wire axi_smc_M01_AXI_BVALID;
  wire [31:0]axi_smc_M01_AXI_RDATA;
  wire axi_smc_M01_AXI_RREADY;
  wire [1:0]axi_smc_M01_AXI_RRESP;
  wire axi_smc_M01_AXI_RVALID;
  wire [31:0]axi_smc_M01_AXI_WDATA;
  wire axi_smc_M01_AXI_WREADY;
  wire [3:0]axi_smc_M01_AXI_WSTRB;
  wire axi_smc_M01_AXI_WVALID;
  wire [8:0]axi_smc_M02_AXI_ARADDR;
  wire axi_smc_M02_AXI_ARREADY;
  wire axi_smc_M02_AXI_ARVALID;
  wire [8:0]axi_smc_M02_AXI_AWADDR;
  wire axi_smc_M02_AXI_AWREADY;
  wire axi_smc_M02_AXI_AWVALID;
  wire axi_smc_M02_AXI_BREADY;
  wire [1:0]axi_smc_M02_AXI_BRESP;
  wire axi_smc_M02_AXI_BVALID;
  wire [31:0]axi_smc_M02_AXI_RDATA;
  wire axi_smc_M02_AXI_RREADY;
  wire [1:0]axi_smc_M02_AXI_RRESP;
  wire axi_smc_M02_AXI_RVALID;
  wire [31:0]axi_smc_M02_AXI_WDATA;
  wire axi_smc_M02_AXI_WREADY;
  wire [3:0]axi_smc_M02_AXI_WSTRB;
  wire axi_smc_M02_AXI_WVALID;
  wire [3:0]axi_smc_M03_AXI_ARADDR;
  wire axi_smc_M03_AXI_ARREADY;
  wire axi_smc_M03_AXI_ARVALID;
  wire [3:0]axi_smc_M03_AXI_AWADDR;
  wire axi_smc_M03_AXI_AWREADY;
  wire axi_smc_M03_AXI_AWVALID;
  wire axi_smc_M03_AXI_BREADY;
  wire [1:0]axi_smc_M03_AXI_BRESP;
  wire axi_smc_M03_AXI_BVALID;
  wire [31:0]axi_smc_M03_AXI_RDATA;
  wire axi_smc_M03_AXI_RREADY;
  wire [1:0]axi_smc_M03_AXI_RRESP;
  wire axi_smc_M03_AXI_RVALID;
  wire [31:0]axi_smc_M03_AXI_WDATA;
  wire axi_smc_M03_AXI_WREADY;
  wire [3:0]axi_smc_M03_AXI_WSTRB;
  wire axi_smc_M03_AXI_WVALID;
  wire [7:0]dip_switches_8bits_tri_i;
  wire [7:0]leds_8bits_tri_o;
  wire [31:0]mdm_1_M_AXI_ARADDR;
  wire [1:0]mdm_1_M_AXI_ARBURST;
  wire [3:0]mdm_1_M_AXI_ARCACHE;
  wire [7:0]mdm_1_M_AXI_ARLEN;
  wire mdm_1_M_AXI_ARLOCK;
  wire [2:0]mdm_1_M_AXI_ARPROT;
  wire [3:0]mdm_1_M_AXI_ARQOS;
  wire mdm_1_M_AXI_ARREADY;
  wire [2:0]mdm_1_M_AXI_ARSIZE;
  wire mdm_1_M_AXI_ARVALID;
  wire [31:0]mdm_1_M_AXI_AWADDR;
  wire [1:0]mdm_1_M_AXI_AWBURST;
  wire [3:0]mdm_1_M_AXI_AWCACHE;
  wire [7:0]mdm_1_M_AXI_AWLEN;
  wire mdm_1_M_AXI_AWLOCK;
  wire [2:0]mdm_1_M_AXI_AWPROT;
  wire [3:0]mdm_1_M_AXI_AWQOS;
  wire mdm_1_M_AXI_AWREADY;
  wire [2:0]mdm_1_M_AXI_AWSIZE;
  wire mdm_1_M_AXI_AWVALID;
  wire mdm_1_M_AXI_BREADY;
  wire [1:0]mdm_1_M_AXI_BRESP;
  wire mdm_1_M_AXI_BVALID;
  wire [31:0]mdm_1_M_AXI_RDATA;
  wire mdm_1_M_AXI_RLAST;
  wire mdm_1_M_AXI_RREADY;
  wire [1:0]mdm_1_M_AXI_RRESP;
  wire mdm_1_M_AXI_RVALID;
  wire [31:0]mdm_1_M_AXI_WDATA;
  wire mdm_1_M_AXI_WLAST;
  wire mdm_1_M_AXI_WREADY;
  wire [3:0]mdm_1_M_AXI_WSTRB;
  wire mdm_1_M_AXI_WVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DP_ARADDR;
  wire [2:0]microblaze_riscv_0_M_AXI_DP_ARPROT;
  wire microblaze_riscv_0_M_AXI_DP_ARREADY;
  wire microblaze_riscv_0_M_AXI_DP_ARVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DP_AWADDR;
  wire [2:0]microblaze_riscv_0_M_AXI_DP_AWPROT;
  wire microblaze_riscv_0_M_AXI_DP_AWREADY;
  wire microblaze_riscv_0_M_AXI_DP_AWVALID;
  wire microblaze_riscv_0_M_AXI_DP_BREADY;
  wire [1:0]microblaze_riscv_0_M_AXI_DP_BRESP;
  wire microblaze_riscv_0_M_AXI_DP_BVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DP_RDATA;
  wire microblaze_riscv_0_M_AXI_DP_RREADY;
  wire [1:0]microblaze_riscv_0_M_AXI_DP_RRESP;
  wire microblaze_riscv_0_M_AXI_DP_RVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DP_WDATA;
  wire microblaze_riscv_0_M_AXI_DP_WREADY;
  wire [3:0]microblaze_riscv_0_M_AXI_DP_WSTRB;
  wire microblaze_riscv_0_M_AXI_DP_WVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_IP_ARADDR;
  wire [2:0]microblaze_riscv_0_M_AXI_IP_ARPROT;
  wire microblaze_riscv_0_M_AXI_IP_ARREADY;
  wire microblaze_riscv_0_M_AXI_IP_ARVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_IP_RDATA;
  wire microblaze_riscv_0_M_AXI_IP_RREADY;
  wire [1:0]microblaze_riscv_0_M_AXI_IP_RRESP;
  wire microblaze_riscv_0_M_AXI_IP_RVALID;
  wire microblaze_riscv_0_debug_CAPTURE;
  wire microblaze_riscv_0_debug_CLK;
  wire microblaze_riscv_0_debug_DISABLE;
  wire [0:7]microblaze_riscv_0_debug_REG_EN;
  wire microblaze_riscv_0_debug_RST;
  wire microblaze_riscv_0_debug_SHIFT;
  wire microblaze_riscv_0_debug_TDI;
  wire microblaze_riscv_0_debug_TDO;
  wire microblaze_riscv_0_debug_UPDATE;
  wire [0:31]microblaze_riscv_0_dlmb_1_ABUS;
  wire microblaze_riscv_0_dlmb_1_ADDRSTROBE;
  wire [0:3]microblaze_riscv_0_dlmb_1_BE;
  wire microblaze_riscv_0_dlmb_1_CE;
  wire [0:31]microblaze_riscv_0_dlmb_1_READDBUS;
  wire microblaze_riscv_0_dlmb_1_READSTROBE;
  wire microblaze_riscv_0_dlmb_1_READY;
  wire microblaze_riscv_0_dlmb_1_UE;
  wire microblaze_riscv_0_dlmb_1_WAIT;
  wire [0:31]microblaze_riscv_0_dlmb_1_WRITEDBUS;
  wire microblaze_riscv_0_dlmb_1_WRITESTROBE;
  wire [0:31]microblaze_riscv_0_ilmb_1_ABUS;
  wire microblaze_riscv_0_ilmb_1_ADDRSTROBE;
  wire microblaze_riscv_0_ilmb_1_CE;
  wire [0:31]microblaze_riscv_0_ilmb_1_READDBUS;
  wire microblaze_riscv_0_ilmb_1_READSTROBE;
  wire microblaze_riscv_0_ilmb_1_READY;
  wire microblaze_riscv_0_ilmb_1_UE;
  wire microblaze_riscv_0_ilmb_1_WAIT;
  wire [0:1]microblaze_riscv_0_interrupt_ACK;
  wire [31:0]microblaze_riscv_0_interrupt_ADDRESS;
  wire microblaze_riscv_0_interrupt_INTERRUPT;
  wire [1:0]microblaze_riscv_0_intr;
  wire [2:0]push_buttons_3bits_tri_i;
  wire [0:0]rst_clk_wiz_1_100M_bus_struct_reset;
  wire rst_clk_wiz_1_100M_mb_reset;
  wire [0:0]rst_clk_wiz_1_100M_peripheral_aresetn;
  wire [31:0]smartconnect_0_M00_AXI_ARADDR;
  wire [1:0]smartconnect_0_M00_AXI_ARBURST;
  wire [3:0]smartconnect_0_M00_AXI_ARCACHE;
  wire [2:0]smartconnect_0_M00_AXI_ARID;
  wire [7:0]smartconnect_0_M00_AXI_ARLEN;
  wire [0:0]smartconnect_0_M00_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M00_AXI_ARPROT;
  wire [3:0]smartconnect_0_M00_AXI_ARQOS;
  wire smartconnect_0_M00_AXI_ARREADY;
  wire [2:0]smartconnect_0_M00_AXI_ARSIZE;
  wire [113:0]smartconnect_0_M00_AXI_ARUSER;
  wire smartconnect_0_M00_AXI_ARVALID;
  wire [31:0]smartconnect_0_M00_AXI_AWADDR;
  wire [1:0]smartconnect_0_M00_AXI_AWBURST;
  wire [3:0]smartconnect_0_M00_AXI_AWCACHE;
  wire [2:0]smartconnect_0_M00_AXI_AWID;
  wire [7:0]smartconnect_0_M00_AXI_AWLEN;
  wire [0:0]smartconnect_0_M00_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M00_AXI_AWPROT;
  wire [3:0]smartconnect_0_M00_AXI_AWQOS;
  wire smartconnect_0_M00_AXI_AWREADY;
  wire [2:0]smartconnect_0_M00_AXI_AWSIZE;
  wire [113:0]smartconnect_0_M00_AXI_AWUSER;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire [2:0]smartconnect_0_M00_AXI_BID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire [113:0]smartconnect_0_M00_AXI_BUSER;
  wire smartconnect_0_M00_AXI_BVALID;
  wire [63:0]smartconnect_0_M00_AXI_RDATA;
  wire [2:0]smartconnect_0_M00_AXI_RID;
  wire smartconnect_0_M00_AXI_RLAST;
  wire smartconnect_0_M00_AXI_RREADY;
  wire [1:0]smartconnect_0_M00_AXI_RRESP;
  wire [13:0]smartconnect_0_M00_AXI_RUSER;
  wire smartconnect_0_M00_AXI_RVALID;
  wire [63:0]smartconnect_0_M00_AXI_WDATA;
  wire smartconnect_0_M00_AXI_WLAST;
  wire smartconnect_0_M00_AXI_WREADY;
  wire [7:0]smartconnect_0_M00_AXI_WSTRB;
  wire [13:0]smartconnect_0_M00_AXI_WUSER;
  wire smartconnect_0_M00_AXI_WVALID;
  wire [48:0]smartconnect_0_M01_AXI_ARADDR;
  wire [1:0]smartconnect_0_M01_AXI_ARBURST;
  wire [3:0]smartconnect_0_M01_AXI_ARCACHE;
  wire [7:0]smartconnect_0_M01_AXI_ARLEN;
  wire [0:0]smartconnect_0_M01_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M01_AXI_ARPROT;
  wire [3:0]smartconnect_0_M01_AXI_ARQOS;
  wire smartconnect_0_M01_AXI_ARREADY;
  wire [2:0]smartconnect_0_M01_AXI_ARSIZE;
  wire smartconnect_0_M01_AXI_ARVALID;
  wire [48:0]smartconnect_0_M01_AXI_AWADDR;
  wire [1:0]smartconnect_0_M01_AXI_AWBURST;
  wire [3:0]smartconnect_0_M01_AXI_AWCACHE;
  wire [7:0]smartconnect_0_M01_AXI_AWLEN;
  wire [0:0]smartconnect_0_M01_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M01_AXI_AWPROT;
  wire [3:0]smartconnect_0_M01_AXI_AWQOS;
  wire smartconnect_0_M01_AXI_AWREADY;
  wire [2:0]smartconnect_0_M01_AXI_AWSIZE;
  wire smartconnect_0_M01_AXI_AWVALID;
  wire smartconnect_0_M01_AXI_BREADY;
  wire [1:0]smartconnect_0_M01_AXI_BRESP;
  wire smartconnect_0_M01_AXI_BVALID;
  wire [63:0]smartconnect_0_M01_AXI_RDATA;
  wire smartconnect_0_M01_AXI_RLAST;
  wire smartconnect_0_M01_AXI_RREADY;
  wire [1:0]smartconnect_0_M01_AXI_RRESP;
  wire smartconnect_0_M01_AXI_RVALID;
  wire [63:0]smartconnect_0_M01_AXI_WDATA;
  wire smartconnect_0_M01_AXI_WLAST;
  wire smartconnect_0_M01_AXI_WREADY;
  wire [7:0]smartconnect_0_M01_AXI_WSTRB;
  wire smartconnect_0_M01_AXI_WVALID;
  wire [8:0]smartconnect_0_M02_AXI_ARADDR;
  wire smartconnect_0_M02_AXI_ARREADY;
  wire smartconnect_0_M02_AXI_ARVALID;
  wire [8:0]smartconnect_0_M02_AXI_AWADDR;
  wire smartconnect_0_M02_AXI_AWREADY;
  wire smartconnect_0_M02_AXI_AWVALID;
  wire smartconnect_0_M02_AXI_BREADY;
  wire [1:0]smartconnect_0_M02_AXI_BRESP;
  wire smartconnect_0_M02_AXI_BVALID;
  wire [31:0]smartconnect_0_M02_AXI_RDATA;
  wire smartconnect_0_M02_AXI_RREADY;
  wire [1:0]smartconnect_0_M02_AXI_RRESP;
  wire smartconnect_0_M02_AXI_RVALID;
  wire [31:0]smartconnect_0_M02_AXI_WDATA;
  wire smartconnect_0_M02_AXI_WREADY;
  wire [3:0]smartconnect_0_M02_AXI_WSTRB;
  wire smartconnect_0_M02_AXI_WVALID;
  wire [39:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARADDR;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARBURST;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARCACHE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARID;
  wire [7:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLEN;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLOCK;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARPROT;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARQOS;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARREADY;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARSIZE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARUSER;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARVALID;
  wire [39:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWADDR;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWBURST;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWCACHE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWID;
  wire [7:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLEN;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLOCK;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWPROT;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWQOS;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWREADY;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWSIZE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWUSER;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWVALID;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BID;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BREADY;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BRESP;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BVALID;
  wire [63:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RDATA;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RID;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RLAST;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RREADY;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RRESP;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RVALID;
  wire [63:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WDATA;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WLAST;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WREADY;
  wire [7:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WSTRB;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WVALID;
  wire zynq_ultra_ps_e_0_pl_clk0;
  wire zynq_ultra_ps_e_0_pl_resetn0;

  OSDZU3x_Tutorial_axi_gpio_0_0 axi_gpio_0
       (.gpio_io_i(push_buttons_3bits_tri_i),
        .ip2intc_irpt(axi_gpio_0_ip2intc_irpt),
        .s_axi_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_araddr(axi_smc_M00_AXI_ARADDR),
        .s_axi_aresetn(rst_clk_wiz_1_100M_peripheral_aresetn),
        .s_axi_arready(axi_smc_M00_AXI_ARREADY),
        .s_axi_arvalid(axi_smc_M00_AXI_ARVALID),
        .s_axi_awaddr(axi_smc_M00_AXI_AWADDR),
        .s_axi_awready(axi_smc_M00_AXI_AWREADY),
        .s_axi_awvalid(axi_smc_M00_AXI_AWVALID),
        .s_axi_bready(axi_smc_M00_AXI_BREADY),
        .s_axi_bresp(axi_smc_M00_AXI_BRESP),
        .s_axi_bvalid(axi_smc_M00_AXI_BVALID),
        .s_axi_rdata(axi_smc_M00_AXI_RDATA),
        .s_axi_rready(axi_smc_M00_AXI_RREADY),
        .s_axi_rresp(axi_smc_M00_AXI_RRESP),
        .s_axi_rvalid(axi_smc_M00_AXI_RVALID),
        .s_axi_wdata(axi_smc_M00_AXI_WDATA),
        .s_axi_wready(axi_smc_M00_AXI_WREADY),
        .s_axi_wstrb(axi_smc_M00_AXI_WSTRB),
        .s_axi_wvalid(axi_smc_M00_AXI_WVALID));
  OSDZU3x_Tutorial_axi_gpio_1_0 axi_gpio_1
       (.gpio_io_o(leds_8bits_tri_o),
        .s_axi_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_araddr(axi_smc_M01_AXI_ARADDR),
        .s_axi_aresetn(rst_clk_wiz_1_100M_peripheral_aresetn),
        .s_axi_arready(axi_smc_M01_AXI_ARREADY),
        .s_axi_arvalid(axi_smc_M01_AXI_ARVALID),
        .s_axi_awaddr(axi_smc_M01_AXI_AWADDR),
        .s_axi_awready(axi_smc_M01_AXI_AWREADY),
        .s_axi_awvalid(axi_smc_M01_AXI_AWVALID),
        .s_axi_bready(axi_smc_M01_AXI_BREADY),
        .s_axi_bresp(axi_smc_M01_AXI_BRESP),
        .s_axi_bvalid(axi_smc_M01_AXI_BVALID),
        .s_axi_rdata(axi_smc_M01_AXI_RDATA),
        .s_axi_rready(axi_smc_M01_AXI_RREADY),
        .s_axi_rresp(axi_smc_M01_AXI_RRESP),
        .s_axi_rvalid(axi_smc_M01_AXI_RVALID),
        .s_axi_wdata(axi_smc_M01_AXI_WDATA),
        .s_axi_wready(axi_smc_M01_AXI_WREADY),
        .s_axi_wstrb(axi_smc_M01_AXI_WSTRB),
        .s_axi_wvalid(axi_smc_M01_AXI_WVALID));
  OSDZU3x_Tutorial_axi_gpio_2_0 axi_gpio_2
       (.gpio_io_i(dip_switches_8bits_tri_i),
        .s_axi_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_araddr(axi_smc_M02_AXI_ARADDR),
        .s_axi_aresetn(rst_clk_wiz_1_100M_peripheral_aresetn),
        .s_axi_arready(axi_smc_M02_AXI_ARREADY),
        .s_axi_arvalid(axi_smc_M02_AXI_ARVALID),
        .s_axi_awaddr(axi_smc_M02_AXI_AWADDR),
        .s_axi_awready(axi_smc_M02_AXI_AWREADY),
        .s_axi_awvalid(axi_smc_M02_AXI_AWVALID),
        .s_axi_bready(axi_smc_M02_AXI_BREADY),
        .s_axi_bresp(axi_smc_M02_AXI_BRESP),
        .s_axi_bvalid(axi_smc_M02_AXI_BVALID),
        .s_axi_rdata(axi_smc_M02_AXI_RDATA),
        .s_axi_rready(axi_smc_M02_AXI_RREADY),
        .s_axi_rresp(axi_smc_M02_AXI_RRESP),
        .s_axi_rvalid(axi_smc_M02_AXI_RVALID),
        .s_axi_wdata(axi_smc_M02_AXI_WDATA),
        .s_axi_wready(axi_smc_M02_AXI_WREADY),
        .s_axi_wstrb(axi_smc_M02_AXI_WSTRB),
        .s_axi_wvalid(axi_smc_M02_AXI_WVALID));
  OSDZU3x_Tutorial_axi_smc_0 axi_smc
       (.M00_AXI_araddr(axi_smc_M00_AXI_ARADDR),
        .M00_AXI_arready(axi_smc_M00_AXI_ARREADY),
        .M00_AXI_arvalid(axi_smc_M00_AXI_ARVALID),
        .M00_AXI_awaddr(axi_smc_M00_AXI_AWADDR),
        .M00_AXI_awready(axi_smc_M00_AXI_AWREADY),
        .M00_AXI_awvalid(axi_smc_M00_AXI_AWVALID),
        .M00_AXI_bready(axi_smc_M00_AXI_BREADY),
        .M00_AXI_bresp(axi_smc_M00_AXI_BRESP),
        .M00_AXI_bvalid(axi_smc_M00_AXI_BVALID),
        .M00_AXI_rdata(axi_smc_M00_AXI_RDATA),
        .M00_AXI_rready(axi_smc_M00_AXI_RREADY),
        .M00_AXI_rresp(axi_smc_M00_AXI_RRESP),
        .M00_AXI_rvalid(axi_smc_M00_AXI_RVALID),
        .M00_AXI_wdata(axi_smc_M00_AXI_WDATA),
        .M00_AXI_wready(axi_smc_M00_AXI_WREADY),
        .M00_AXI_wstrb(axi_smc_M00_AXI_WSTRB),
        .M00_AXI_wvalid(axi_smc_M00_AXI_WVALID),
        .M01_AXI_araddr(axi_smc_M01_AXI_ARADDR),
        .M01_AXI_arready(axi_smc_M01_AXI_ARREADY),
        .M01_AXI_arvalid(axi_smc_M01_AXI_ARVALID),
        .M01_AXI_awaddr(axi_smc_M01_AXI_AWADDR),
        .M01_AXI_awready(axi_smc_M01_AXI_AWREADY),
        .M01_AXI_awvalid(axi_smc_M01_AXI_AWVALID),
        .M01_AXI_bready(axi_smc_M01_AXI_BREADY),
        .M01_AXI_bresp(axi_smc_M01_AXI_BRESP),
        .M01_AXI_bvalid(axi_smc_M01_AXI_BVALID),
        .M01_AXI_rdata(axi_smc_M01_AXI_RDATA),
        .M01_AXI_rready(axi_smc_M01_AXI_RREADY),
        .M01_AXI_rresp(axi_smc_M01_AXI_RRESP),
        .M01_AXI_rvalid(axi_smc_M01_AXI_RVALID),
        .M01_AXI_wdata(axi_smc_M01_AXI_WDATA),
        .M01_AXI_wready(axi_smc_M01_AXI_WREADY),
        .M01_AXI_wstrb(axi_smc_M01_AXI_WSTRB),
        .M01_AXI_wvalid(axi_smc_M01_AXI_WVALID),
        .M02_AXI_araddr(axi_smc_M02_AXI_ARADDR),
        .M02_AXI_arready(axi_smc_M02_AXI_ARREADY),
        .M02_AXI_arvalid(axi_smc_M02_AXI_ARVALID),
        .M02_AXI_awaddr(axi_smc_M02_AXI_AWADDR),
        .M02_AXI_awready(axi_smc_M02_AXI_AWREADY),
        .M02_AXI_awvalid(axi_smc_M02_AXI_AWVALID),
        .M02_AXI_bready(axi_smc_M02_AXI_BREADY),
        .M02_AXI_bresp(axi_smc_M02_AXI_BRESP),
        .M02_AXI_bvalid(axi_smc_M02_AXI_BVALID),
        .M02_AXI_rdata(axi_smc_M02_AXI_RDATA),
        .M02_AXI_rready(axi_smc_M02_AXI_RREADY),
        .M02_AXI_rresp(axi_smc_M02_AXI_RRESP),
        .M02_AXI_rvalid(axi_smc_M02_AXI_RVALID),
        .M02_AXI_wdata(axi_smc_M02_AXI_WDATA),
        .M02_AXI_wready(axi_smc_M02_AXI_WREADY),
        .M02_AXI_wstrb(axi_smc_M02_AXI_WSTRB),
        .M02_AXI_wvalid(axi_smc_M02_AXI_WVALID),
        .M03_AXI_araddr(axi_smc_M03_AXI_ARADDR),
        .M03_AXI_arready(axi_smc_M03_AXI_ARREADY),
        .M03_AXI_arvalid(axi_smc_M03_AXI_ARVALID),
        .M03_AXI_awaddr(axi_smc_M03_AXI_AWADDR),
        .M03_AXI_awready(axi_smc_M03_AXI_AWREADY),
        .M03_AXI_awvalid(axi_smc_M03_AXI_AWVALID),
        .M03_AXI_bready(axi_smc_M03_AXI_BREADY),
        .M03_AXI_bresp(axi_smc_M03_AXI_BRESP),
        .M03_AXI_bvalid(axi_smc_M03_AXI_BVALID),
        .M03_AXI_rdata(axi_smc_M03_AXI_RDATA),
        .M03_AXI_rready(axi_smc_M03_AXI_RREADY),
        .M03_AXI_rresp(axi_smc_M03_AXI_RRESP),
        .M03_AXI_rvalid(axi_smc_M03_AXI_RVALID),
        .M03_AXI_wdata(axi_smc_M03_AXI_WDATA),
        .M03_AXI_wready(axi_smc_M03_AXI_WREADY),
        .M03_AXI_wstrb(axi_smc_M03_AXI_WSTRB),
        .M03_AXI_wvalid(axi_smc_M03_AXI_WVALID),
        .S00_AXI_araddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARADDR),
        .S00_AXI_arburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARBURST),
        .S00_AXI_arcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARCACHE),
        .S00_AXI_arid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARID),
        .S00_AXI_arlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLEN),
        .S00_AXI_arlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLOCK),
        .S00_AXI_arprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARPROT),
        .S00_AXI_arqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARQOS),
        .S00_AXI_arready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARREADY),
        .S00_AXI_arsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARSIZE),
        .S00_AXI_aruser(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARUSER),
        .S00_AXI_arvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARVALID),
        .S00_AXI_awaddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWADDR),
        .S00_AXI_awburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWBURST),
        .S00_AXI_awcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWCACHE),
        .S00_AXI_awid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWID),
        .S00_AXI_awlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLEN),
        .S00_AXI_awlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLOCK),
        .S00_AXI_awprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWPROT),
        .S00_AXI_awqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWQOS),
        .S00_AXI_awready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWREADY),
        .S00_AXI_awsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWSIZE),
        .S00_AXI_awuser(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWUSER),
        .S00_AXI_awvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWVALID),
        .S00_AXI_bid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BID),
        .S00_AXI_bready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BREADY),
        .S00_AXI_bresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BRESP),
        .S00_AXI_bvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BVALID),
        .S00_AXI_rdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RDATA),
        .S00_AXI_rid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RID),
        .S00_AXI_rlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RLAST),
        .S00_AXI_rready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RREADY),
        .S00_AXI_rresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RRESP),
        .S00_AXI_rvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RVALID),
        .S00_AXI_wdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WDATA),
        .S00_AXI_wlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WLAST),
        .S00_AXI_wready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WREADY),
        .S00_AXI_wstrb(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WSTRB),
        .S00_AXI_wvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WVALID),
        .S01_AXI_araddr(smartconnect_0_M00_AXI_ARADDR),
        .S01_AXI_arburst(smartconnect_0_M00_AXI_ARBURST),
        .S01_AXI_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .S01_AXI_arid(smartconnect_0_M00_AXI_ARID),
        .S01_AXI_arlen(smartconnect_0_M00_AXI_ARLEN),
        .S01_AXI_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .S01_AXI_arprot(smartconnect_0_M00_AXI_ARPROT),
        .S01_AXI_arqos(smartconnect_0_M00_AXI_ARQOS),
        .S01_AXI_arready(smartconnect_0_M00_AXI_ARREADY),
        .S01_AXI_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .S01_AXI_aruser(smartconnect_0_M00_AXI_ARUSER),
        .S01_AXI_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .S01_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .S01_AXI_awburst(smartconnect_0_M00_AXI_AWBURST),
        .S01_AXI_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .S01_AXI_awid(smartconnect_0_M00_AXI_AWID),
        .S01_AXI_awlen(smartconnect_0_M00_AXI_AWLEN),
        .S01_AXI_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .S01_AXI_awprot(smartconnect_0_M00_AXI_AWPROT),
        .S01_AXI_awqos(smartconnect_0_M00_AXI_AWQOS),
        .S01_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .S01_AXI_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .S01_AXI_awuser(smartconnect_0_M00_AXI_AWUSER),
        .S01_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .S01_AXI_bid(smartconnect_0_M00_AXI_BID),
        .S01_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .S01_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .S01_AXI_buser(smartconnect_0_M00_AXI_BUSER),
        .S01_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .S01_AXI_rdata(smartconnect_0_M00_AXI_RDATA),
        .S01_AXI_rid(smartconnect_0_M00_AXI_RID),
        .S01_AXI_rlast(smartconnect_0_M00_AXI_RLAST),
        .S01_AXI_rready(smartconnect_0_M00_AXI_RREADY),
        .S01_AXI_rresp(smartconnect_0_M00_AXI_RRESP),
        .S01_AXI_ruser(smartconnect_0_M00_AXI_RUSER),
        .S01_AXI_rvalid(smartconnect_0_M00_AXI_RVALID),
        .S01_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .S01_AXI_wlast(smartconnect_0_M00_AXI_WLAST),
        .S01_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .S01_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .S01_AXI_wuser(smartconnect_0_M00_AXI_WUSER),
        .S01_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .aclk(zynq_ultra_ps_e_0_pl_clk0),
        .aresetn(rst_clk_wiz_1_100M_peripheral_aresetn));
  OSDZU3x_Tutorial_mdm_1_0 mdm_1
       (.Dbg_Capture_0(microblaze_riscv_0_debug_CAPTURE),
        .Dbg_Clk_0(microblaze_riscv_0_debug_CLK),
        .Dbg_Disable_0(microblaze_riscv_0_debug_DISABLE),
        .Dbg_Reg_En_0(microblaze_riscv_0_debug_REG_EN),
        .Dbg_Rst_0(microblaze_riscv_0_debug_RST),
        .Dbg_Shift_0(microblaze_riscv_0_debug_SHIFT),
        .Dbg_TDI_0(microblaze_riscv_0_debug_TDI),
        .Dbg_TDO_0(microblaze_riscv_0_debug_TDO),
        .Dbg_Update_0(microblaze_riscv_0_debug_UPDATE),
        .LMB_CE_0(1'b0),
        .LMB_Data_Read_0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LMB_Ready_0(1'b0),
        .LMB_UE_0(1'b0),
        .LMB_Wait_0(1'b0),
        .M_AXI_ACLK(zynq_ultra_ps_e_0_pl_clk0),
        .M_AXI_ARADDR(mdm_1_M_AXI_ARADDR),
        .M_AXI_ARBURST(mdm_1_M_AXI_ARBURST),
        .M_AXI_ARCACHE(mdm_1_M_AXI_ARCACHE),
        .M_AXI_ARESETN(rst_clk_wiz_1_100M_peripheral_aresetn),
        .M_AXI_ARLEN(mdm_1_M_AXI_ARLEN),
        .M_AXI_ARLOCK(mdm_1_M_AXI_ARLOCK),
        .M_AXI_ARPROT(mdm_1_M_AXI_ARPROT),
        .M_AXI_ARQOS(mdm_1_M_AXI_ARQOS),
        .M_AXI_ARREADY(mdm_1_M_AXI_ARREADY),
        .M_AXI_ARSIZE(mdm_1_M_AXI_ARSIZE),
        .M_AXI_ARVALID(mdm_1_M_AXI_ARVALID),
        .M_AXI_AWADDR(mdm_1_M_AXI_AWADDR),
        .M_AXI_AWBURST(mdm_1_M_AXI_AWBURST),
        .M_AXI_AWCACHE(mdm_1_M_AXI_AWCACHE),
        .M_AXI_AWLEN(mdm_1_M_AXI_AWLEN),
        .M_AXI_AWLOCK(mdm_1_M_AXI_AWLOCK),
        .M_AXI_AWPROT(mdm_1_M_AXI_AWPROT),
        .M_AXI_AWQOS(mdm_1_M_AXI_AWQOS),
        .M_AXI_AWREADY(mdm_1_M_AXI_AWREADY),
        .M_AXI_AWSIZE(mdm_1_M_AXI_AWSIZE),
        .M_AXI_AWVALID(mdm_1_M_AXI_AWVALID),
        .M_AXI_BID(1'b0),
        .M_AXI_BREADY(mdm_1_M_AXI_BREADY),
        .M_AXI_BRESP(mdm_1_M_AXI_BRESP),
        .M_AXI_BVALID(mdm_1_M_AXI_BVALID),
        .M_AXI_RDATA(mdm_1_M_AXI_RDATA),
        .M_AXI_RID(1'b0),
        .M_AXI_RLAST(mdm_1_M_AXI_RLAST),
        .M_AXI_RREADY(mdm_1_M_AXI_RREADY),
        .M_AXI_RRESP(mdm_1_M_AXI_RRESP),
        .M_AXI_RVALID(mdm_1_M_AXI_RVALID),
        .M_AXI_WDATA(mdm_1_M_AXI_WDATA),
        .M_AXI_WLAST(mdm_1_M_AXI_WLAST),
        .M_AXI_WREADY(mdm_1_M_AXI_WREADY),
        .M_AXI_WSTRB(mdm_1_M_AXI_WSTRB),
        .M_AXI_WVALID(mdm_1_M_AXI_WVALID),
        .S_AXI_ACLK(zynq_ultra_ps_e_0_pl_clk0),
        .S_AXI_ARADDR(axi_smc_M03_AXI_ARADDR),
        .S_AXI_ARESETN(rst_clk_wiz_1_100M_peripheral_aresetn),
        .S_AXI_ARREADY(axi_smc_M03_AXI_ARREADY),
        .S_AXI_ARVALID(axi_smc_M03_AXI_ARVALID),
        .S_AXI_AWADDR(axi_smc_M03_AXI_AWADDR),
        .S_AXI_AWREADY(axi_smc_M03_AXI_AWREADY),
        .S_AXI_AWVALID(axi_smc_M03_AXI_AWVALID),
        .S_AXI_BREADY(axi_smc_M03_AXI_BREADY),
        .S_AXI_BRESP(axi_smc_M03_AXI_BRESP),
        .S_AXI_BVALID(axi_smc_M03_AXI_BVALID),
        .S_AXI_RDATA(axi_smc_M03_AXI_RDATA),
        .S_AXI_RREADY(axi_smc_M03_AXI_RREADY),
        .S_AXI_RRESP(axi_smc_M03_AXI_RRESP),
        .S_AXI_RVALID(axi_smc_M03_AXI_RVALID),
        .S_AXI_WDATA(axi_smc_M03_AXI_WDATA),
        .S_AXI_WREADY(axi_smc_M03_AXI_WREADY),
        .S_AXI_WSTRB(axi_smc_M03_AXI_WSTRB),
        .S_AXI_WVALID(axi_smc_M03_AXI_WVALID));
  (* BMM_INFO_PROCESSOR = "riscv > OSDZU3x_Tutorial microblaze_riscv_0_local_memory/dlmb_bram_if_cntlr" *) 
  (* KEEP_HIERARCHY = "yes" *) 
  OSDZU3x_Tutorial_microblaze_riscv_0_1 microblaze_riscv_0
       (.Byte_Enable(microblaze_riscv_0_dlmb_1_BE),
        .Clk(zynq_ultra_ps_e_0_pl_clk0),
        .DCE(microblaze_riscv_0_dlmb_1_CE),
        .DReady(microblaze_riscv_0_dlmb_1_READY),
        .DUE(microblaze_riscv_0_dlmb_1_UE),
        .DWait(microblaze_riscv_0_dlmb_1_WAIT),
        .D_AS(microblaze_riscv_0_dlmb_1_ADDRSTROBE),
        .Data_Addr(microblaze_riscv_0_dlmb_1_ABUS),
        .Data_Read(microblaze_riscv_0_dlmb_1_READDBUS),
        .Data_Write(microblaze_riscv_0_dlmb_1_WRITEDBUS),
        .Dbg_Capture(microblaze_riscv_0_debug_CAPTURE),
        .Dbg_Clk(microblaze_riscv_0_debug_CLK),
        .Dbg_Disable(microblaze_riscv_0_debug_DISABLE),
        .Dbg_Reg_En(microblaze_riscv_0_debug_REG_EN),
        .Dbg_Shift(microblaze_riscv_0_debug_SHIFT),
        .Dbg_TDI(microblaze_riscv_0_debug_TDI),
        .Dbg_TDO(microblaze_riscv_0_debug_TDO),
        .Dbg_Update(microblaze_riscv_0_debug_UPDATE),
        .Debug_Rst(microblaze_riscv_0_debug_RST),
        .ICE(microblaze_riscv_0_ilmb_1_CE),
        .IFetch(microblaze_riscv_0_ilmb_1_READSTROBE),
        .IReady(microblaze_riscv_0_ilmb_1_READY),
        .IUE(microblaze_riscv_0_ilmb_1_UE),
        .IWAIT(microblaze_riscv_0_ilmb_1_WAIT),
        .I_AS(microblaze_riscv_0_ilmb_1_ADDRSTROBE),
        .Instr(microblaze_riscv_0_ilmb_1_READDBUS),
        .Instr_Addr(microblaze_riscv_0_ilmb_1_ABUS),
        .Interrupt(microblaze_riscv_0_interrupt_INTERRUPT),
        .Interrupt_Ack(microblaze_riscv_0_interrupt_ACK),
        .Interrupt_Address({microblaze_riscv_0_interrupt_ADDRESS[31],microblaze_riscv_0_interrupt_ADDRESS[30],microblaze_riscv_0_interrupt_ADDRESS[29],microblaze_riscv_0_interrupt_ADDRESS[28],microblaze_riscv_0_interrupt_ADDRESS[27],microblaze_riscv_0_interrupt_ADDRESS[26],microblaze_riscv_0_interrupt_ADDRESS[25],microblaze_riscv_0_interrupt_ADDRESS[24],microblaze_riscv_0_interrupt_ADDRESS[23],microblaze_riscv_0_interrupt_ADDRESS[22],microblaze_riscv_0_interrupt_ADDRESS[21],microblaze_riscv_0_interrupt_ADDRESS[20],microblaze_riscv_0_interrupt_ADDRESS[19],microblaze_riscv_0_interrupt_ADDRESS[18],microblaze_riscv_0_interrupt_ADDRESS[17],microblaze_riscv_0_interrupt_ADDRESS[16],microblaze_riscv_0_interrupt_ADDRESS[15],microblaze_riscv_0_interrupt_ADDRESS[14],microblaze_riscv_0_interrupt_ADDRESS[13],microblaze_riscv_0_interrupt_ADDRESS[12],microblaze_riscv_0_interrupt_ADDRESS[11],microblaze_riscv_0_interrupt_ADDRESS[10],microblaze_riscv_0_interrupt_ADDRESS[9],microblaze_riscv_0_interrupt_ADDRESS[8],microblaze_riscv_0_interrupt_ADDRESS[7],microblaze_riscv_0_interrupt_ADDRESS[6],microblaze_riscv_0_interrupt_ADDRESS[5],microblaze_riscv_0_interrupt_ADDRESS[4],microblaze_riscv_0_interrupt_ADDRESS[3],microblaze_riscv_0_interrupt_ADDRESS[2],microblaze_riscv_0_interrupt_ADDRESS[1],microblaze_riscv_0_interrupt_ADDRESS[0]}),
        .M_AXI_DP_ARADDR(microblaze_riscv_0_M_AXI_DP_ARADDR),
        .M_AXI_DP_ARPROT(microblaze_riscv_0_M_AXI_DP_ARPROT),
        .M_AXI_DP_ARREADY(microblaze_riscv_0_M_AXI_DP_ARREADY),
        .M_AXI_DP_ARVALID(microblaze_riscv_0_M_AXI_DP_ARVALID),
        .M_AXI_DP_AWADDR(microblaze_riscv_0_M_AXI_DP_AWADDR),
        .M_AXI_DP_AWPROT(microblaze_riscv_0_M_AXI_DP_AWPROT),
        .M_AXI_DP_AWREADY(microblaze_riscv_0_M_AXI_DP_AWREADY),
        .M_AXI_DP_AWVALID(microblaze_riscv_0_M_AXI_DP_AWVALID),
        .M_AXI_DP_BREADY(microblaze_riscv_0_M_AXI_DP_BREADY),
        .M_AXI_DP_BRESP(microblaze_riscv_0_M_AXI_DP_BRESP),
        .M_AXI_DP_BVALID(microblaze_riscv_0_M_AXI_DP_BVALID),
        .M_AXI_DP_RDATA(microblaze_riscv_0_M_AXI_DP_RDATA),
        .M_AXI_DP_RREADY(microblaze_riscv_0_M_AXI_DP_RREADY),
        .M_AXI_DP_RRESP(microblaze_riscv_0_M_AXI_DP_RRESP),
        .M_AXI_DP_RVALID(microblaze_riscv_0_M_AXI_DP_RVALID),
        .M_AXI_DP_WDATA(microblaze_riscv_0_M_AXI_DP_WDATA),
        .M_AXI_DP_WREADY(microblaze_riscv_0_M_AXI_DP_WREADY),
        .M_AXI_DP_WSTRB(microblaze_riscv_0_M_AXI_DP_WSTRB),
        .M_AXI_DP_WVALID(microblaze_riscv_0_M_AXI_DP_WVALID),
        .M_AXI_IP_ARADDR(microblaze_riscv_0_M_AXI_IP_ARADDR),
        .M_AXI_IP_ARPROT(microblaze_riscv_0_M_AXI_IP_ARPROT),
        .M_AXI_IP_ARREADY(microblaze_riscv_0_M_AXI_IP_ARREADY),
        .M_AXI_IP_ARVALID(microblaze_riscv_0_M_AXI_IP_ARVALID),
        .M_AXI_IP_AWREADY(1'b0),
        .M_AXI_IP_BRESP({1'b0,1'b0}),
        .M_AXI_IP_BVALID(1'b0),
        .M_AXI_IP_RDATA(microblaze_riscv_0_M_AXI_IP_RDATA),
        .M_AXI_IP_RREADY(microblaze_riscv_0_M_AXI_IP_RREADY),
        .M_AXI_IP_RRESP(microblaze_riscv_0_M_AXI_IP_RRESP),
        .M_AXI_IP_RVALID(microblaze_riscv_0_M_AXI_IP_RVALID),
        .M_AXI_IP_WREADY(1'b0),
        .Read_Strobe(microblaze_riscv_0_dlmb_1_READSTROBE),
        .Reset(rst_clk_wiz_1_100M_mb_reset),
        .Write_Strobe(microblaze_riscv_0_dlmb_1_WRITESTROBE));
  OSDZU3x_Tutorial_microblaze_riscv_0_axi_intc_0 microblaze_riscv_0_axi_intc
       (.interrupt_address(microblaze_riscv_0_interrupt_ADDRESS),
        .intr(microblaze_riscv_0_intr),
        .irq(microblaze_riscv_0_interrupt_INTERRUPT),
        .processor_ack({microblaze_riscv_0_interrupt_ACK[0],microblaze_riscv_0_interrupt_ACK[1]}),
        .processor_clk(zynq_ultra_ps_e_0_pl_clk0),
        .processor_rst(rst_clk_wiz_1_100M_mb_reset),
        .s_axi_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_araddr(smartconnect_0_M02_AXI_ARADDR),
        .s_axi_aresetn(rst_clk_wiz_1_100M_peripheral_aresetn),
        .s_axi_arready(smartconnect_0_M02_AXI_ARREADY),
        .s_axi_arvalid(smartconnect_0_M02_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_0_M02_AXI_AWADDR),
        .s_axi_awready(smartconnect_0_M02_AXI_AWREADY),
        .s_axi_awvalid(smartconnect_0_M02_AXI_AWVALID),
        .s_axi_bready(smartconnect_0_M02_AXI_BREADY),
        .s_axi_bresp(smartconnect_0_M02_AXI_BRESP),
        .s_axi_bvalid(smartconnect_0_M02_AXI_BVALID),
        .s_axi_rdata(smartconnect_0_M02_AXI_RDATA),
        .s_axi_rready(smartconnect_0_M02_AXI_RREADY),
        .s_axi_rresp(smartconnect_0_M02_AXI_RRESP),
        .s_axi_rvalid(smartconnect_0_M02_AXI_RVALID),
        .s_axi_wdata(smartconnect_0_M02_AXI_WDATA),
        .s_axi_wready(smartconnect_0_M02_AXI_WREADY),
        .s_axi_wstrb(smartconnect_0_M02_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_0_M02_AXI_WVALID));
  microblaze_riscv_0_local_memory_imp_9FN5A8 microblaze_riscv_0_local_memory
       (.DLMB_abus(microblaze_riscv_0_dlmb_1_ABUS),
        .DLMB_addrstrobe(microblaze_riscv_0_dlmb_1_ADDRSTROBE),
        .DLMB_be(microblaze_riscv_0_dlmb_1_BE),
        .DLMB_ce(microblaze_riscv_0_dlmb_1_CE),
        .DLMB_readdbus(microblaze_riscv_0_dlmb_1_READDBUS),
        .DLMB_readstrobe(microblaze_riscv_0_dlmb_1_READSTROBE),
        .DLMB_ready(microblaze_riscv_0_dlmb_1_READY),
        .DLMB_ue(microblaze_riscv_0_dlmb_1_UE),
        .DLMB_wait(microblaze_riscv_0_dlmb_1_WAIT),
        .DLMB_writedbus(microblaze_riscv_0_dlmb_1_WRITEDBUS),
        .DLMB_writestrobe(microblaze_riscv_0_dlmb_1_WRITESTROBE),
        .ILMB_abus(microblaze_riscv_0_ilmb_1_ABUS),
        .ILMB_addrstrobe(microblaze_riscv_0_ilmb_1_ADDRSTROBE),
        .ILMB_ce(microblaze_riscv_0_ilmb_1_CE),
        .ILMB_readdbus(microblaze_riscv_0_ilmb_1_READDBUS),
        .ILMB_readstrobe(microblaze_riscv_0_ilmb_1_READSTROBE),
        .ILMB_ready(microblaze_riscv_0_ilmb_1_READY),
        .ILMB_ue(microblaze_riscv_0_ilmb_1_UE),
        .ILMB_wait(microblaze_riscv_0_ilmb_1_WAIT),
        .LMB_Clk(zynq_ultra_ps_e_0_pl_clk0),
        .SYS_Rst(rst_clk_wiz_1_100M_bus_struct_reset));
  OSDZU3x_Tutorial_microblaze_riscv_0_xlconcat_0 microblaze_riscv_0_xlconcat
       (.In0(axi_gpio_0_ip2intc_irpt),
        .In1(1'b0),
        .dout(microblaze_riscv_0_intr));
  OSDZU3x_Tutorial_rst_clk_wiz_1_100M_0 rst_clk_wiz_1_100M
       (.aux_reset_in(1'b1),
        .bus_struct_reset(rst_clk_wiz_1_100M_bus_struct_reset),
        .dcm_locked(1'b1),
        .ext_reset_in(zynq_ultra_ps_e_0_pl_resetn0),
        .mb_debug_sys_rst(1'b0),
        .mb_reset(rst_clk_wiz_1_100M_mb_reset),
        .peripheral_aresetn(rst_clk_wiz_1_100M_peripheral_aresetn),
        .slowest_sync_clk(zynq_ultra_ps_e_0_pl_clk0));
  OSDZU3x_Tutorial_smartconnect_0_0 smartconnect_0
       (.M00_AXI_araddr(smartconnect_0_M00_AXI_ARADDR),
        .M00_AXI_arburst(smartconnect_0_M00_AXI_ARBURST),
        .M00_AXI_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .M00_AXI_arid(smartconnect_0_M00_AXI_ARID),
        .M00_AXI_arlen(smartconnect_0_M00_AXI_ARLEN),
        .M00_AXI_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .M00_AXI_arprot(smartconnect_0_M00_AXI_ARPROT),
        .M00_AXI_arqos(smartconnect_0_M00_AXI_ARQOS),
        .M00_AXI_arready(smartconnect_0_M00_AXI_ARREADY),
        .M00_AXI_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .M00_AXI_aruser(smartconnect_0_M00_AXI_ARUSER),
        .M00_AXI_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .M00_AXI_awburst(smartconnect_0_M00_AXI_AWBURST),
        .M00_AXI_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .M00_AXI_awid(smartconnect_0_M00_AXI_AWID),
        .M00_AXI_awlen(smartconnect_0_M00_AXI_AWLEN),
        .M00_AXI_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .M00_AXI_awprot(smartconnect_0_M00_AXI_AWPROT),
        .M00_AXI_awqos(smartconnect_0_M00_AXI_AWQOS),
        .M00_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .M00_AXI_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .M00_AXI_awuser(smartconnect_0_M00_AXI_AWUSER),
        .M00_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .M00_AXI_bid(smartconnect_0_M00_AXI_BID),
        .M00_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .M00_AXI_buser(smartconnect_0_M00_AXI_BUSER),
        .M00_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_0_M00_AXI_RDATA),
        .M00_AXI_rid(smartconnect_0_M00_AXI_RID),
        .M00_AXI_rlast(smartconnect_0_M00_AXI_RLAST),
        .M00_AXI_rready(smartconnect_0_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_0_M00_AXI_RRESP),
        .M00_AXI_ruser(smartconnect_0_M00_AXI_RUSER),
        .M00_AXI_rvalid(smartconnect_0_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .M00_AXI_wlast(smartconnect_0_M00_AXI_WLAST),
        .M00_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .M00_AXI_wuser(smartconnect_0_M00_AXI_WUSER),
        .M00_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .M01_AXI_araddr(smartconnect_0_M01_AXI_ARADDR),
        .M01_AXI_arburst(smartconnect_0_M01_AXI_ARBURST),
        .M01_AXI_arcache(smartconnect_0_M01_AXI_ARCACHE),
        .M01_AXI_arlen(smartconnect_0_M01_AXI_ARLEN),
        .M01_AXI_arlock(smartconnect_0_M01_AXI_ARLOCK),
        .M01_AXI_arprot(smartconnect_0_M01_AXI_ARPROT),
        .M01_AXI_arqos(smartconnect_0_M01_AXI_ARQOS),
        .M01_AXI_arready(smartconnect_0_M01_AXI_ARREADY),
        .M01_AXI_arsize(smartconnect_0_M01_AXI_ARSIZE),
        .M01_AXI_arvalid(smartconnect_0_M01_AXI_ARVALID),
        .M01_AXI_awaddr(smartconnect_0_M01_AXI_AWADDR),
        .M01_AXI_awburst(smartconnect_0_M01_AXI_AWBURST),
        .M01_AXI_awcache(smartconnect_0_M01_AXI_AWCACHE),
        .M01_AXI_awlen(smartconnect_0_M01_AXI_AWLEN),
        .M01_AXI_awlock(smartconnect_0_M01_AXI_AWLOCK),
        .M01_AXI_awprot(smartconnect_0_M01_AXI_AWPROT),
        .M01_AXI_awqos(smartconnect_0_M01_AXI_AWQOS),
        .M01_AXI_awready(smartconnect_0_M01_AXI_AWREADY),
        .M01_AXI_awsize(smartconnect_0_M01_AXI_AWSIZE),
        .M01_AXI_awvalid(smartconnect_0_M01_AXI_AWVALID),
        .M01_AXI_bready(smartconnect_0_M01_AXI_BREADY),
        .M01_AXI_bresp(smartconnect_0_M01_AXI_BRESP),
        .M01_AXI_bvalid(smartconnect_0_M01_AXI_BVALID),
        .M01_AXI_rdata(smartconnect_0_M01_AXI_RDATA),
        .M01_AXI_rlast(smartconnect_0_M01_AXI_RLAST),
        .M01_AXI_rready(smartconnect_0_M01_AXI_RREADY),
        .M01_AXI_rresp(smartconnect_0_M01_AXI_RRESP),
        .M01_AXI_rvalid(smartconnect_0_M01_AXI_RVALID),
        .M01_AXI_wdata(smartconnect_0_M01_AXI_WDATA),
        .M01_AXI_wlast(smartconnect_0_M01_AXI_WLAST),
        .M01_AXI_wready(smartconnect_0_M01_AXI_WREADY),
        .M01_AXI_wstrb(smartconnect_0_M01_AXI_WSTRB),
        .M01_AXI_wvalid(smartconnect_0_M01_AXI_WVALID),
        .M02_AXI_araddr(smartconnect_0_M02_AXI_ARADDR),
        .M02_AXI_arready(smartconnect_0_M02_AXI_ARREADY),
        .M02_AXI_arvalid(smartconnect_0_M02_AXI_ARVALID),
        .M02_AXI_awaddr(smartconnect_0_M02_AXI_AWADDR),
        .M02_AXI_awready(smartconnect_0_M02_AXI_AWREADY),
        .M02_AXI_awvalid(smartconnect_0_M02_AXI_AWVALID),
        .M02_AXI_bready(smartconnect_0_M02_AXI_BREADY),
        .M02_AXI_bresp(smartconnect_0_M02_AXI_BRESP),
        .M02_AXI_bvalid(smartconnect_0_M02_AXI_BVALID),
        .M02_AXI_rdata(smartconnect_0_M02_AXI_RDATA),
        .M02_AXI_rready(smartconnect_0_M02_AXI_RREADY),
        .M02_AXI_rresp(smartconnect_0_M02_AXI_RRESP),
        .M02_AXI_rvalid(smartconnect_0_M02_AXI_RVALID),
        .M02_AXI_wdata(smartconnect_0_M02_AXI_WDATA),
        .M02_AXI_wready(smartconnect_0_M02_AXI_WREADY),
        .M02_AXI_wstrb(smartconnect_0_M02_AXI_WSTRB),
        .M02_AXI_wvalid(smartconnect_0_M02_AXI_WVALID),
        .S00_AXI_araddr(microblaze_riscv_0_M_AXI_DP_ARADDR),
        .S00_AXI_arprot(microblaze_riscv_0_M_AXI_DP_ARPROT),
        .S00_AXI_arready(microblaze_riscv_0_M_AXI_DP_ARREADY),
        .S00_AXI_arvalid(microblaze_riscv_0_M_AXI_DP_ARVALID),
        .S00_AXI_awaddr(microblaze_riscv_0_M_AXI_DP_AWADDR),
        .S00_AXI_awprot(microblaze_riscv_0_M_AXI_DP_AWPROT),
        .S00_AXI_awready(microblaze_riscv_0_M_AXI_DP_AWREADY),
        .S00_AXI_awvalid(microblaze_riscv_0_M_AXI_DP_AWVALID),
        .S00_AXI_bready(microblaze_riscv_0_M_AXI_DP_BREADY),
        .S00_AXI_bresp(microblaze_riscv_0_M_AXI_DP_BRESP),
        .S00_AXI_bvalid(microblaze_riscv_0_M_AXI_DP_BVALID),
        .S00_AXI_rdata(microblaze_riscv_0_M_AXI_DP_RDATA),
        .S00_AXI_rready(microblaze_riscv_0_M_AXI_DP_RREADY),
        .S00_AXI_rresp(microblaze_riscv_0_M_AXI_DP_RRESP),
        .S00_AXI_rvalid(microblaze_riscv_0_M_AXI_DP_RVALID),
        .S00_AXI_wdata(microblaze_riscv_0_M_AXI_DP_WDATA),
        .S00_AXI_wready(microblaze_riscv_0_M_AXI_DP_WREADY),
        .S00_AXI_wstrb(microblaze_riscv_0_M_AXI_DP_WSTRB),
        .S00_AXI_wvalid(microblaze_riscv_0_M_AXI_DP_WVALID),
        .S01_AXI_araddr(microblaze_riscv_0_M_AXI_IP_ARADDR),
        .S01_AXI_arprot(microblaze_riscv_0_M_AXI_IP_ARPROT),
        .S01_AXI_arready(microblaze_riscv_0_M_AXI_IP_ARREADY),
        .S01_AXI_arvalid(microblaze_riscv_0_M_AXI_IP_ARVALID),
        .S01_AXI_rdata(microblaze_riscv_0_M_AXI_IP_RDATA),
        .S01_AXI_rready(microblaze_riscv_0_M_AXI_IP_RREADY),
        .S01_AXI_rresp(microblaze_riscv_0_M_AXI_IP_RRESP),
        .S01_AXI_rvalid(microblaze_riscv_0_M_AXI_IP_RVALID),
        .S02_AXI_araddr(mdm_1_M_AXI_ARADDR),
        .S02_AXI_arburst(mdm_1_M_AXI_ARBURST),
        .S02_AXI_arcache(mdm_1_M_AXI_ARCACHE),
        .S02_AXI_arlen(mdm_1_M_AXI_ARLEN),
        .S02_AXI_arlock(mdm_1_M_AXI_ARLOCK),
        .S02_AXI_arprot(mdm_1_M_AXI_ARPROT),
        .S02_AXI_arqos(mdm_1_M_AXI_ARQOS),
        .S02_AXI_arready(mdm_1_M_AXI_ARREADY),
        .S02_AXI_arsize(mdm_1_M_AXI_ARSIZE),
        .S02_AXI_arvalid(mdm_1_M_AXI_ARVALID),
        .S02_AXI_awaddr(mdm_1_M_AXI_AWADDR),
        .S02_AXI_awburst(mdm_1_M_AXI_AWBURST),
        .S02_AXI_awcache(mdm_1_M_AXI_AWCACHE),
        .S02_AXI_awlen(mdm_1_M_AXI_AWLEN),
        .S02_AXI_awlock(mdm_1_M_AXI_AWLOCK),
        .S02_AXI_awprot(mdm_1_M_AXI_AWPROT),
        .S02_AXI_awqos(mdm_1_M_AXI_AWQOS),
        .S02_AXI_awready(mdm_1_M_AXI_AWREADY),
        .S02_AXI_awsize(mdm_1_M_AXI_AWSIZE),
        .S02_AXI_awvalid(mdm_1_M_AXI_AWVALID),
        .S02_AXI_bready(mdm_1_M_AXI_BREADY),
        .S02_AXI_bresp(mdm_1_M_AXI_BRESP),
        .S02_AXI_bvalid(mdm_1_M_AXI_BVALID),
        .S02_AXI_rdata(mdm_1_M_AXI_RDATA),
        .S02_AXI_rlast(mdm_1_M_AXI_RLAST),
        .S02_AXI_rready(mdm_1_M_AXI_RREADY),
        .S02_AXI_rresp(mdm_1_M_AXI_RRESP),
        .S02_AXI_rvalid(mdm_1_M_AXI_RVALID),
        .S02_AXI_wdata(mdm_1_M_AXI_WDATA),
        .S02_AXI_wlast(mdm_1_M_AXI_WLAST),
        .S02_AXI_wready(mdm_1_M_AXI_WREADY),
        .S02_AXI_wstrb(mdm_1_M_AXI_WSTRB),
        .S02_AXI_wvalid(mdm_1_M_AXI_WVALID),
        .aclk(zynq_ultra_ps_e_0_pl_clk0),
        .aclk1(zynq_ultra_ps_e_0_pl_clk0),
        .aresetn(rst_clk_wiz_1_100M_peripheral_aresetn));
  OSDZU3x_Tutorial_zynq_ultra_ps_e_0_0 zynq_ultra_ps_e_0
       (.maxigp2_araddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARADDR),
        .maxigp2_arburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARBURST),
        .maxigp2_arcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARCACHE),
        .maxigp2_arid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARID),
        .maxigp2_arlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLEN),
        .maxigp2_arlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLOCK),
        .maxigp2_arprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARPROT),
        .maxigp2_arqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARQOS),
        .maxigp2_arready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARREADY),
        .maxigp2_arsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARSIZE),
        .maxigp2_aruser(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARUSER),
        .maxigp2_arvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARVALID),
        .maxigp2_awaddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWADDR),
        .maxigp2_awburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWBURST),
        .maxigp2_awcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWCACHE),
        .maxigp2_awid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWID),
        .maxigp2_awlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLEN),
        .maxigp2_awlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLOCK),
        .maxigp2_awprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWPROT),
        .maxigp2_awqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWQOS),
        .maxigp2_awready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWREADY),
        .maxigp2_awsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWSIZE),
        .maxigp2_awuser(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWUSER),
        .maxigp2_awvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWVALID),
        .maxigp2_bid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BID),
        .maxigp2_bready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BREADY),
        .maxigp2_bresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BRESP),
        .maxigp2_bvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BVALID),
        .maxigp2_rdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RDATA),
        .maxigp2_rid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RID),
        .maxigp2_rlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RLAST),
        .maxigp2_rready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RREADY),
        .maxigp2_rresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RRESP),
        .maxigp2_rvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RVALID),
        .maxigp2_wdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WDATA),
        .maxigp2_wlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WLAST),
        .maxigp2_wready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WREADY),
        .maxigp2_wstrb(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WSTRB),
        .maxigp2_wvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WVALID),
        .maxihpm0_lpd_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .pl_clk0(zynq_ultra_ps_e_0_pl_clk0),
        .pl_resetn0(zynq_ultra_ps_e_0_pl_resetn0),
        .saxi_lpd_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .saxigp6_araddr(smartconnect_0_M01_AXI_ARADDR),
        .saxigp6_arburst(smartconnect_0_M01_AXI_ARBURST),
        .saxigp6_arcache(smartconnect_0_M01_AXI_ARCACHE),
        .saxigp6_arid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .saxigp6_arlen(smartconnect_0_M01_AXI_ARLEN),
        .saxigp6_arlock(smartconnect_0_M01_AXI_ARLOCK),
        .saxigp6_arprot(smartconnect_0_M01_AXI_ARPROT),
        .saxigp6_arqos(smartconnect_0_M01_AXI_ARQOS),
        .saxigp6_arready(smartconnect_0_M01_AXI_ARREADY),
        .saxigp6_arsize(smartconnect_0_M01_AXI_ARSIZE),
        .saxigp6_aruser(1'b0),
        .saxigp6_arvalid(smartconnect_0_M01_AXI_ARVALID),
        .saxigp6_awaddr(smartconnect_0_M01_AXI_AWADDR),
        .saxigp6_awburst(smartconnect_0_M01_AXI_AWBURST),
        .saxigp6_awcache(smartconnect_0_M01_AXI_AWCACHE),
        .saxigp6_awid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .saxigp6_awlen(smartconnect_0_M01_AXI_AWLEN),
        .saxigp6_awlock(smartconnect_0_M01_AXI_AWLOCK),
        .saxigp6_awprot(smartconnect_0_M01_AXI_AWPROT),
        .saxigp6_awqos(smartconnect_0_M01_AXI_AWQOS),
        .saxigp6_awready(smartconnect_0_M01_AXI_AWREADY),
        .saxigp6_awsize(smartconnect_0_M01_AXI_AWSIZE),
        .saxigp6_awuser(1'b0),
        .saxigp6_awvalid(smartconnect_0_M01_AXI_AWVALID),
        .saxigp6_bready(smartconnect_0_M01_AXI_BREADY),
        .saxigp6_bresp(smartconnect_0_M01_AXI_BRESP),
        .saxigp6_bvalid(smartconnect_0_M01_AXI_BVALID),
        .saxigp6_rdata(smartconnect_0_M01_AXI_RDATA),
        .saxigp6_rlast(smartconnect_0_M01_AXI_RLAST),
        .saxigp6_rready(smartconnect_0_M01_AXI_RREADY),
        .saxigp6_rresp(smartconnect_0_M01_AXI_RRESP),
        .saxigp6_rvalid(smartconnect_0_M01_AXI_RVALID),
        .saxigp6_wdata(smartconnect_0_M01_AXI_WDATA),
        .saxigp6_wlast(smartconnect_0_M01_AXI_WLAST),
        .saxigp6_wready(smartconnect_0_M01_AXI_WREADY),
        .saxigp6_wstrb(smartconnect_0_M01_AXI_WSTRB),
        .saxigp6_wvalid(smartconnect_0_M01_AXI_WVALID));
endmodule

module microblaze_riscv_0_local_memory_imp_9FN5A8
   (DLMB_abus,
    DLMB_addrstrobe,
    DLMB_be,
    DLMB_ce,
    DLMB_readdbus,
    DLMB_readstrobe,
    DLMB_ready,
    DLMB_ue,
    DLMB_wait,
    DLMB_writedbus,
    DLMB_writestrobe,
    ILMB_abus,
    ILMB_addrstrobe,
    ILMB_ce,
    ILMB_readdbus,
    ILMB_readstrobe,
    ILMB_ready,
    ILMB_ue,
    ILMB_wait,
    LMB_Clk,
    SYS_Rst);
  input [0:31]DLMB_abus;
  input DLMB_addrstrobe;
  input [0:3]DLMB_be;
  output DLMB_ce;
  output [0:31]DLMB_readdbus;
  input DLMB_readstrobe;
  output DLMB_ready;
  output DLMB_ue;
  output DLMB_wait;
  input [0:31]DLMB_writedbus;
  input DLMB_writestrobe;
  input [0:31]ILMB_abus;
  input ILMB_addrstrobe;
  output ILMB_ce;
  output [0:31]ILMB_readdbus;
  input ILMB_readstrobe;
  output ILMB_ready;
  output ILMB_ue;
  output ILMB_wait;
  input LMB_Clk;
  input SYS_Rst;

  wire [0:31]DLMB_abus;
  wire DLMB_addrstrobe;
  wire [0:3]DLMB_be;
  wire DLMB_ce;
  wire [0:31]DLMB_readdbus;
  wire DLMB_readstrobe;
  wire DLMB_ready;
  wire DLMB_ue;
  wire DLMB_wait;
  wire [0:31]DLMB_writedbus;
  wire DLMB_writestrobe;
  wire [0:31]ILMB_abus;
  wire ILMB_addrstrobe;
  wire ILMB_ce;
  wire [0:31]ILMB_readdbus;
  wire ILMB_readstrobe;
  wire ILMB_ready;
  wire ILMB_ue;
  wire ILMB_wait;
  wire LMB_Clk;
  wire SYS_Rst;
  wire [0:31]microblaze_riscv_0_dlmb_bus_ABUS;
  wire microblaze_riscv_0_dlmb_bus_ADDRSTROBE;
  wire [0:3]microblaze_riscv_0_dlmb_bus_BE;
  wire microblaze_riscv_0_dlmb_bus_CE;
  wire [0:31]microblaze_riscv_0_dlmb_bus_READDBUS;
  wire microblaze_riscv_0_dlmb_bus_READSTROBE;
  wire microblaze_riscv_0_dlmb_bus_READY;
  wire microblaze_riscv_0_dlmb_bus_UE;
  wire microblaze_riscv_0_dlmb_bus_WAIT;
  wire [0:31]microblaze_riscv_0_dlmb_bus_WRITEDBUS;
  wire microblaze_riscv_0_dlmb_bus_WRITESTROBE;
  wire [0:31]microblaze_riscv_0_dlmb_cntlr_ADDR;
  wire microblaze_riscv_0_dlmb_cntlr_CLK;
  wire [0:31]microblaze_riscv_0_dlmb_cntlr_DIN;
  wire [31:0]microblaze_riscv_0_dlmb_cntlr_DOUT;
  wire microblaze_riscv_0_dlmb_cntlr_EN;
  wire microblaze_riscv_0_dlmb_cntlr_RST;
  wire [0:3]microblaze_riscv_0_dlmb_cntlr_WE;
  wire [0:31]microblaze_riscv_0_ilmb_bus_ABUS;
  wire microblaze_riscv_0_ilmb_bus_ADDRSTROBE;
  wire [0:3]microblaze_riscv_0_ilmb_bus_BE;
  wire microblaze_riscv_0_ilmb_bus_CE;
  wire [0:31]microblaze_riscv_0_ilmb_bus_READDBUS;
  wire microblaze_riscv_0_ilmb_bus_READSTROBE;
  wire microblaze_riscv_0_ilmb_bus_READY;
  wire microblaze_riscv_0_ilmb_bus_UE;
  wire microblaze_riscv_0_ilmb_bus_WAIT;
  wire [0:31]microblaze_riscv_0_ilmb_bus_WRITEDBUS;
  wire microblaze_riscv_0_ilmb_bus_WRITESTROBE;
  wire [0:31]microblaze_riscv_0_ilmb_cntlr_ADDR;
  wire microblaze_riscv_0_ilmb_cntlr_CLK;
  wire [0:31]microblaze_riscv_0_ilmb_cntlr_DIN;
  wire [31:0]microblaze_riscv_0_ilmb_cntlr_DOUT;
  wire microblaze_riscv_0_ilmb_cntlr_EN;
  wire microblaze_riscv_0_ilmb_cntlr_RST;
  wire [0:3]microblaze_riscv_0_ilmb_cntlr_WE;

  (* BMM_INFO_ADDRESS_SPACE = "byte  0x00000000 32 > OSDZU3x_Tutorial microblaze_riscv_0_local_memory/lmb_bram" *) 
  (* KEEP_HIERARCHY = "yes" *) 
  OSDZU3x_Tutorial_dlmb_bram_if_cntlr_0 dlmb_bram_if_cntlr
       (.BRAM_Addr_A(microblaze_riscv_0_dlmb_cntlr_ADDR),
        .BRAM_Clk_A(microblaze_riscv_0_dlmb_cntlr_CLK),
        .BRAM_Din_A({microblaze_riscv_0_dlmb_cntlr_DOUT[31],microblaze_riscv_0_dlmb_cntlr_DOUT[30],microblaze_riscv_0_dlmb_cntlr_DOUT[29],microblaze_riscv_0_dlmb_cntlr_DOUT[28],microblaze_riscv_0_dlmb_cntlr_DOUT[27],microblaze_riscv_0_dlmb_cntlr_DOUT[26],microblaze_riscv_0_dlmb_cntlr_DOUT[25],microblaze_riscv_0_dlmb_cntlr_DOUT[24],microblaze_riscv_0_dlmb_cntlr_DOUT[23],microblaze_riscv_0_dlmb_cntlr_DOUT[22],microblaze_riscv_0_dlmb_cntlr_DOUT[21],microblaze_riscv_0_dlmb_cntlr_DOUT[20],microblaze_riscv_0_dlmb_cntlr_DOUT[19],microblaze_riscv_0_dlmb_cntlr_DOUT[18],microblaze_riscv_0_dlmb_cntlr_DOUT[17],microblaze_riscv_0_dlmb_cntlr_DOUT[16],microblaze_riscv_0_dlmb_cntlr_DOUT[15],microblaze_riscv_0_dlmb_cntlr_DOUT[14],microblaze_riscv_0_dlmb_cntlr_DOUT[13],microblaze_riscv_0_dlmb_cntlr_DOUT[12],microblaze_riscv_0_dlmb_cntlr_DOUT[11],microblaze_riscv_0_dlmb_cntlr_DOUT[10],microblaze_riscv_0_dlmb_cntlr_DOUT[9],microblaze_riscv_0_dlmb_cntlr_DOUT[8],microblaze_riscv_0_dlmb_cntlr_DOUT[7],microblaze_riscv_0_dlmb_cntlr_DOUT[6],microblaze_riscv_0_dlmb_cntlr_DOUT[5],microblaze_riscv_0_dlmb_cntlr_DOUT[4],microblaze_riscv_0_dlmb_cntlr_DOUT[3],microblaze_riscv_0_dlmb_cntlr_DOUT[2],microblaze_riscv_0_dlmb_cntlr_DOUT[1],microblaze_riscv_0_dlmb_cntlr_DOUT[0]}),
        .BRAM_Dout_A(microblaze_riscv_0_dlmb_cntlr_DIN),
        .BRAM_EN_A(microblaze_riscv_0_dlmb_cntlr_EN),
        .BRAM_Rst_A(microblaze_riscv_0_dlmb_cntlr_RST),
        .BRAM_WEN_A(microblaze_riscv_0_dlmb_cntlr_WE),
        .LMB_ABus(microblaze_riscv_0_dlmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_riscv_0_dlmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_riscv_0_dlmb_bus_BE),
        .LMB_Clk(LMB_Clk),
        .LMB_ReadStrobe(microblaze_riscv_0_dlmb_bus_READSTROBE),
        .LMB_Rst(SYS_Rst),
        .LMB_WriteDBus(microblaze_riscv_0_dlmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_riscv_0_dlmb_bus_WRITESTROBE),
        .Sl_CE(microblaze_riscv_0_dlmb_bus_CE),
        .Sl_DBus(microblaze_riscv_0_dlmb_bus_READDBUS),
        .Sl_Ready(microblaze_riscv_0_dlmb_bus_READY),
        .Sl_UE(microblaze_riscv_0_dlmb_bus_UE),
        .Sl_Wait(microblaze_riscv_0_dlmb_bus_WAIT));
  OSDZU3x_Tutorial_dlmb_v10_0 dlmb_v10
       (.LMB_ABus(microblaze_riscv_0_dlmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_riscv_0_dlmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_riscv_0_dlmb_bus_BE),
        .LMB_CE(DLMB_ce),
        .LMB_Clk(LMB_Clk),
        .LMB_ReadDBus(DLMB_readdbus),
        .LMB_ReadStrobe(microblaze_riscv_0_dlmb_bus_READSTROBE),
        .LMB_Ready(DLMB_ready),
        .LMB_UE(DLMB_ue),
        .LMB_Wait(DLMB_wait),
        .LMB_WriteDBus(microblaze_riscv_0_dlmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_riscv_0_dlmb_bus_WRITESTROBE),
        .M_ABus(DLMB_abus),
        .M_AddrStrobe(DLMB_addrstrobe),
        .M_BE(DLMB_be),
        .M_DBus(DLMB_writedbus),
        .M_ReadStrobe(DLMB_readstrobe),
        .M_WriteStrobe(DLMB_writestrobe),
        .SYS_Rst(SYS_Rst),
        .Sl_CE(microblaze_riscv_0_dlmb_bus_CE),
        .Sl_DBus(microblaze_riscv_0_dlmb_bus_READDBUS),
        .Sl_Ready(microblaze_riscv_0_dlmb_bus_READY),
        .Sl_UE(microblaze_riscv_0_dlmb_bus_UE),
        .Sl_Wait(microblaze_riscv_0_dlmb_bus_WAIT));
  OSDZU3x_Tutorial_ilmb_bram_if_cntlr_0 ilmb_bram_if_cntlr
       (.BRAM_Addr_A(microblaze_riscv_0_ilmb_cntlr_ADDR),
        .BRAM_Clk_A(microblaze_riscv_0_ilmb_cntlr_CLK),
        .BRAM_Din_A({microblaze_riscv_0_ilmb_cntlr_DOUT[31],microblaze_riscv_0_ilmb_cntlr_DOUT[30],microblaze_riscv_0_ilmb_cntlr_DOUT[29],microblaze_riscv_0_ilmb_cntlr_DOUT[28],microblaze_riscv_0_ilmb_cntlr_DOUT[27],microblaze_riscv_0_ilmb_cntlr_DOUT[26],microblaze_riscv_0_ilmb_cntlr_DOUT[25],microblaze_riscv_0_ilmb_cntlr_DOUT[24],microblaze_riscv_0_ilmb_cntlr_DOUT[23],microblaze_riscv_0_ilmb_cntlr_DOUT[22],microblaze_riscv_0_ilmb_cntlr_DOUT[21],microblaze_riscv_0_ilmb_cntlr_DOUT[20],microblaze_riscv_0_ilmb_cntlr_DOUT[19],microblaze_riscv_0_ilmb_cntlr_DOUT[18],microblaze_riscv_0_ilmb_cntlr_DOUT[17],microblaze_riscv_0_ilmb_cntlr_DOUT[16],microblaze_riscv_0_ilmb_cntlr_DOUT[15],microblaze_riscv_0_ilmb_cntlr_DOUT[14],microblaze_riscv_0_ilmb_cntlr_DOUT[13],microblaze_riscv_0_ilmb_cntlr_DOUT[12],microblaze_riscv_0_ilmb_cntlr_DOUT[11],microblaze_riscv_0_ilmb_cntlr_DOUT[10],microblaze_riscv_0_ilmb_cntlr_DOUT[9],microblaze_riscv_0_ilmb_cntlr_DOUT[8],microblaze_riscv_0_ilmb_cntlr_DOUT[7],microblaze_riscv_0_ilmb_cntlr_DOUT[6],microblaze_riscv_0_ilmb_cntlr_DOUT[5],microblaze_riscv_0_ilmb_cntlr_DOUT[4],microblaze_riscv_0_ilmb_cntlr_DOUT[3],microblaze_riscv_0_ilmb_cntlr_DOUT[2],microblaze_riscv_0_ilmb_cntlr_DOUT[1],microblaze_riscv_0_ilmb_cntlr_DOUT[0]}),
        .BRAM_Dout_A(microblaze_riscv_0_ilmb_cntlr_DIN),
        .BRAM_EN_A(microblaze_riscv_0_ilmb_cntlr_EN),
        .BRAM_Rst_A(microblaze_riscv_0_ilmb_cntlr_RST),
        .BRAM_WEN_A(microblaze_riscv_0_ilmb_cntlr_WE),
        .LMB_ABus(microblaze_riscv_0_ilmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_riscv_0_ilmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_riscv_0_ilmb_bus_BE),
        .LMB_Clk(LMB_Clk),
        .LMB_ReadStrobe(microblaze_riscv_0_ilmb_bus_READSTROBE),
        .LMB_Rst(SYS_Rst),
        .LMB_WriteDBus(microblaze_riscv_0_ilmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_riscv_0_ilmb_bus_WRITESTROBE),
        .Sl_CE(microblaze_riscv_0_ilmb_bus_CE),
        .Sl_DBus(microblaze_riscv_0_ilmb_bus_READDBUS),
        .Sl_Ready(microblaze_riscv_0_ilmb_bus_READY),
        .Sl_UE(microblaze_riscv_0_ilmb_bus_UE),
        .Sl_Wait(microblaze_riscv_0_ilmb_bus_WAIT));
  OSDZU3x_Tutorial_ilmb_v10_0 ilmb_v10
       (.LMB_ABus(microblaze_riscv_0_ilmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_riscv_0_ilmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_riscv_0_ilmb_bus_BE),
        .LMB_CE(ILMB_ce),
        .LMB_Clk(LMB_Clk),
        .LMB_ReadDBus(ILMB_readdbus),
        .LMB_ReadStrobe(microblaze_riscv_0_ilmb_bus_READSTROBE),
        .LMB_Ready(ILMB_ready),
        .LMB_UE(ILMB_ue),
        .LMB_Wait(ILMB_wait),
        .LMB_WriteDBus(microblaze_riscv_0_ilmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_riscv_0_ilmb_bus_WRITESTROBE),
        .M_ABus(ILMB_abus),
        .M_AddrStrobe(ILMB_addrstrobe),
        .M_BE({1'b0,1'b0,1'b0,1'b0}),
        .M_DBus({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .M_ReadStrobe(ILMB_readstrobe),
        .M_WriteStrobe(1'b0),
        .SYS_Rst(SYS_Rst),
        .Sl_CE(microblaze_riscv_0_ilmb_bus_CE),
        .Sl_DBus(microblaze_riscv_0_ilmb_bus_READDBUS),
        .Sl_Ready(microblaze_riscv_0_ilmb_bus_READY),
        .Sl_UE(microblaze_riscv_0_ilmb_bus_UE),
        .Sl_Wait(microblaze_riscv_0_ilmb_bus_WAIT));
  OSDZU3x_Tutorial_lmb_bram_0 lmb_bram
       (.addra({microblaze_riscv_0_dlmb_cntlr_ADDR[0],microblaze_riscv_0_dlmb_cntlr_ADDR[1],microblaze_riscv_0_dlmb_cntlr_ADDR[2],microblaze_riscv_0_dlmb_cntlr_ADDR[3],microblaze_riscv_0_dlmb_cntlr_ADDR[4],microblaze_riscv_0_dlmb_cntlr_ADDR[5],microblaze_riscv_0_dlmb_cntlr_ADDR[6],microblaze_riscv_0_dlmb_cntlr_ADDR[7],microblaze_riscv_0_dlmb_cntlr_ADDR[8],microblaze_riscv_0_dlmb_cntlr_ADDR[9],microblaze_riscv_0_dlmb_cntlr_ADDR[10],microblaze_riscv_0_dlmb_cntlr_ADDR[11],microblaze_riscv_0_dlmb_cntlr_ADDR[12],microblaze_riscv_0_dlmb_cntlr_ADDR[13],microblaze_riscv_0_dlmb_cntlr_ADDR[14],microblaze_riscv_0_dlmb_cntlr_ADDR[15],microblaze_riscv_0_dlmb_cntlr_ADDR[16],microblaze_riscv_0_dlmb_cntlr_ADDR[17],microblaze_riscv_0_dlmb_cntlr_ADDR[18],microblaze_riscv_0_dlmb_cntlr_ADDR[19],microblaze_riscv_0_dlmb_cntlr_ADDR[20],microblaze_riscv_0_dlmb_cntlr_ADDR[21],microblaze_riscv_0_dlmb_cntlr_ADDR[22],microblaze_riscv_0_dlmb_cntlr_ADDR[23],microblaze_riscv_0_dlmb_cntlr_ADDR[24],microblaze_riscv_0_dlmb_cntlr_ADDR[25],microblaze_riscv_0_dlmb_cntlr_ADDR[26],microblaze_riscv_0_dlmb_cntlr_ADDR[27],microblaze_riscv_0_dlmb_cntlr_ADDR[28],microblaze_riscv_0_dlmb_cntlr_ADDR[29],microblaze_riscv_0_dlmb_cntlr_ADDR[30],microblaze_riscv_0_dlmb_cntlr_ADDR[31]}),
        .addrb({microblaze_riscv_0_ilmb_cntlr_ADDR[0],microblaze_riscv_0_ilmb_cntlr_ADDR[1],microblaze_riscv_0_ilmb_cntlr_ADDR[2],microblaze_riscv_0_ilmb_cntlr_ADDR[3],microblaze_riscv_0_ilmb_cntlr_ADDR[4],microblaze_riscv_0_ilmb_cntlr_ADDR[5],microblaze_riscv_0_ilmb_cntlr_ADDR[6],microblaze_riscv_0_ilmb_cntlr_ADDR[7],microblaze_riscv_0_ilmb_cntlr_ADDR[8],microblaze_riscv_0_ilmb_cntlr_ADDR[9],microblaze_riscv_0_ilmb_cntlr_ADDR[10],microblaze_riscv_0_ilmb_cntlr_ADDR[11],microblaze_riscv_0_ilmb_cntlr_ADDR[12],microblaze_riscv_0_ilmb_cntlr_ADDR[13],microblaze_riscv_0_ilmb_cntlr_ADDR[14],microblaze_riscv_0_ilmb_cntlr_ADDR[15],microblaze_riscv_0_ilmb_cntlr_ADDR[16],microblaze_riscv_0_ilmb_cntlr_ADDR[17],microblaze_riscv_0_ilmb_cntlr_ADDR[18],microblaze_riscv_0_ilmb_cntlr_ADDR[19],microblaze_riscv_0_ilmb_cntlr_ADDR[20],microblaze_riscv_0_ilmb_cntlr_ADDR[21],microblaze_riscv_0_ilmb_cntlr_ADDR[22],microblaze_riscv_0_ilmb_cntlr_ADDR[23],microblaze_riscv_0_ilmb_cntlr_ADDR[24],microblaze_riscv_0_ilmb_cntlr_ADDR[25],microblaze_riscv_0_ilmb_cntlr_ADDR[26],microblaze_riscv_0_ilmb_cntlr_ADDR[27],microblaze_riscv_0_ilmb_cntlr_ADDR[28],microblaze_riscv_0_ilmb_cntlr_ADDR[29],microblaze_riscv_0_ilmb_cntlr_ADDR[30],microblaze_riscv_0_ilmb_cntlr_ADDR[31]}),
        .clka(microblaze_riscv_0_dlmb_cntlr_CLK),
        .clkb(microblaze_riscv_0_ilmb_cntlr_CLK),
        .dina({microblaze_riscv_0_dlmb_cntlr_DIN[0],microblaze_riscv_0_dlmb_cntlr_DIN[1],microblaze_riscv_0_dlmb_cntlr_DIN[2],microblaze_riscv_0_dlmb_cntlr_DIN[3],microblaze_riscv_0_dlmb_cntlr_DIN[4],microblaze_riscv_0_dlmb_cntlr_DIN[5],microblaze_riscv_0_dlmb_cntlr_DIN[6],microblaze_riscv_0_dlmb_cntlr_DIN[7],microblaze_riscv_0_dlmb_cntlr_DIN[8],microblaze_riscv_0_dlmb_cntlr_DIN[9],microblaze_riscv_0_dlmb_cntlr_DIN[10],microblaze_riscv_0_dlmb_cntlr_DIN[11],microblaze_riscv_0_dlmb_cntlr_DIN[12],microblaze_riscv_0_dlmb_cntlr_DIN[13],microblaze_riscv_0_dlmb_cntlr_DIN[14],microblaze_riscv_0_dlmb_cntlr_DIN[15],microblaze_riscv_0_dlmb_cntlr_DIN[16],microblaze_riscv_0_dlmb_cntlr_DIN[17],microblaze_riscv_0_dlmb_cntlr_DIN[18],microblaze_riscv_0_dlmb_cntlr_DIN[19],microblaze_riscv_0_dlmb_cntlr_DIN[20],microblaze_riscv_0_dlmb_cntlr_DIN[21],microblaze_riscv_0_dlmb_cntlr_DIN[22],microblaze_riscv_0_dlmb_cntlr_DIN[23],microblaze_riscv_0_dlmb_cntlr_DIN[24],microblaze_riscv_0_dlmb_cntlr_DIN[25],microblaze_riscv_0_dlmb_cntlr_DIN[26],microblaze_riscv_0_dlmb_cntlr_DIN[27],microblaze_riscv_0_dlmb_cntlr_DIN[28],microblaze_riscv_0_dlmb_cntlr_DIN[29],microblaze_riscv_0_dlmb_cntlr_DIN[30],microblaze_riscv_0_dlmb_cntlr_DIN[31]}),
        .dinb({microblaze_riscv_0_ilmb_cntlr_DIN[0],microblaze_riscv_0_ilmb_cntlr_DIN[1],microblaze_riscv_0_ilmb_cntlr_DIN[2],microblaze_riscv_0_ilmb_cntlr_DIN[3],microblaze_riscv_0_ilmb_cntlr_DIN[4],microblaze_riscv_0_ilmb_cntlr_DIN[5],microblaze_riscv_0_ilmb_cntlr_DIN[6],microblaze_riscv_0_ilmb_cntlr_DIN[7],microblaze_riscv_0_ilmb_cntlr_DIN[8],microblaze_riscv_0_ilmb_cntlr_DIN[9],microblaze_riscv_0_ilmb_cntlr_DIN[10],microblaze_riscv_0_ilmb_cntlr_DIN[11],microblaze_riscv_0_ilmb_cntlr_DIN[12],microblaze_riscv_0_ilmb_cntlr_DIN[13],microblaze_riscv_0_ilmb_cntlr_DIN[14],microblaze_riscv_0_ilmb_cntlr_DIN[15],microblaze_riscv_0_ilmb_cntlr_DIN[16],microblaze_riscv_0_ilmb_cntlr_DIN[17],microblaze_riscv_0_ilmb_cntlr_DIN[18],microblaze_riscv_0_ilmb_cntlr_DIN[19],microblaze_riscv_0_ilmb_cntlr_DIN[20],microblaze_riscv_0_ilmb_cntlr_DIN[21],microblaze_riscv_0_ilmb_cntlr_DIN[22],microblaze_riscv_0_ilmb_cntlr_DIN[23],microblaze_riscv_0_ilmb_cntlr_DIN[24],microblaze_riscv_0_ilmb_cntlr_DIN[25],microblaze_riscv_0_ilmb_cntlr_DIN[26],microblaze_riscv_0_ilmb_cntlr_DIN[27],microblaze_riscv_0_ilmb_cntlr_DIN[28],microblaze_riscv_0_ilmb_cntlr_DIN[29],microblaze_riscv_0_ilmb_cntlr_DIN[30],microblaze_riscv_0_ilmb_cntlr_DIN[31]}),
        .douta(microblaze_riscv_0_dlmb_cntlr_DOUT),
        .doutb(microblaze_riscv_0_ilmb_cntlr_DOUT),
        .ena(microblaze_riscv_0_dlmb_cntlr_EN),
        .enb(microblaze_riscv_0_ilmb_cntlr_EN),
        .rsta(microblaze_riscv_0_dlmb_cntlr_RST),
        .rstb(microblaze_riscv_0_ilmb_cntlr_RST),
        .wea({microblaze_riscv_0_dlmb_cntlr_WE[0],microblaze_riscv_0_dlmb_cntlr_WE[1],microblaze_riscv_0_dlmb_cntlr_WE[2],microblaze_riscv_0_dlmb_cntlr_WE[3]}),
        .web({microblaze_riscv_0_ilmb_cntlr_WE[0],microblaze_riscv_0_ilmb_cntlr_WE[1],microblaze_riscv_0_ilmb_cntlr_WE[2],microblaze_riscv_0_ilmb_cntlr_WE[3]}));
endmodule
