-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
-- Date        : Thu Sep  4 16:01:30 2025
-- Host        : e-ubuntu running 64-bit Ubuntu 24.04.3 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top design_1_lvds_display_tx_0_0 -prefix
--               design_1_lvds_display_tx_0_0_ design_1_lvds_display_tx_0_0_stub.vhdl
-- Design      : design_1_lvds_display_tx_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu3eg-sfvc784-1-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_lvds_display_tx_0_0 is
  Port ( 
    ref_clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    cmt_locked : out STD_LOGIC;
    px_clk : out STD_LOGIC;
    vid_io_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    vid_active_video : in STD_LOGIC;
    vid_hsync : in STD_LOGIC;
    vid_vsync : in STD_LOGIC;
    clkout_p : out STD_LOGIC;
    clkout_n : out STD_LOGIC;
    dataout_p : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dataout_n : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_lvds_display_tx_0_0 : entity is "design_1_lvds_display_tx_0_0,lvds_display_tx,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_lvds_display_tx_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_lvds_display_tx_0_0 : entity is "package_project";
end design_1_lvds_display_tx_0_0;

architecture stub of design_1_lvds_display_tx_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "ref_clk,reset,cmt_locked,px_clk,vid_io_in[23:0],vid_active_video,vid_hsync,vid_vsync,clkout_p,clkout_n,dataout_p[3:0],dataout_n[3:0]";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of ref_clk : signal is "xilinx.com:signal:clock:1.0 ref_clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of ref_clk : signal is "XIL_INTERFACENAME ref_clk, ASSOCIATED_RESET reset, ASSOCIATED_BUSIF vid, FREQ_TOLERANCE_HZ -1, FREQ_HZ 59999401, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk2, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of reset : signal is "xilinx.com:signal:reset:1.0 reset RST";
  attribute X_INTERFACE_PARAMETER of reset : signal is "XIL_INTERFACENAME reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of px_clk : signal is "xilinx.com:signal:clock:1.0 px_clk CLK";
  attribute X_INTERFACE_PARAMETER of px_clk : signal is "XIL_INTERFACENAME px_clk, FREQ_TOLERANCE_HZ -1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_lvds_display_tx_0_0_px_clk, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of vid_io_in : signal is "xilinx.com:interface:vid_io:1.0 vid DATA";
  attribute X_INTERFACE_INFO of vid_active_video : signal is "xilinx.com:interface:vid_io:1.0 vid ACTIVE_VIDEO";
  attribute X_INTERFACE_INFO of vid_hsync : signal is "xilinx.com:interface:vid_io:1.0 vid HSYNC";
  attribute X_INTERFACE_INFO of vid_vsync : signal is "xilinx.com:interface:vid_io:1.0 vid VSYNC";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "lvds_display_tx,Vivado 2023.1";
begin
end;
