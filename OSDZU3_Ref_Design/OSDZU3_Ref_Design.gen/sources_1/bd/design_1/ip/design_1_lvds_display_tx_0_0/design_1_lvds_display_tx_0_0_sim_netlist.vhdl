-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
-- Date        : Thu Sep  4 16:01:30 2025
-- Host        : e-ubuntu running 64-bit Ubuntu 24.04.3 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top design_1_lvds_display_tx_0_0 -prefix
--               design_1_lvds_display_tx_0_0_ design_1_lvds_display_tx_0_0_sim_netlist.vhdl
-- Design      : design_1_lvds_display_tx_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xczu3eg-sfvc784-1-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_lvds_display_tx_0_0_tx_clkgen_7to1 is
  port (
    cmt_locked : out STD_LOGIC;
    px_clk : out STD_LOGIC;
    tx_clkdiv2 : out STD_LOGIC;
    tx_clkdiv4 : out STD_LOGIC;
    ref_clk : in STD_LOGIC;
    reset : in STD_LOGIC
  );
end design_1_lvds_display_tx_0_0_tx_clkgen_7to1;

architecture STRUCTURE of design_1_lvds_display_tx_0_0_tx_clkgen_7to1 is
  signal \^px_clk\ : STD_LOGIC;
  signal px_pllmmcm : STD_LOGIC;
  signal tx_pllmmcm_div2 : STD_LOGIC;
  signal NLW_tx_mmcm_CDDCDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKFBOUTB_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKFBSTOPPED_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKINSTOPPED_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKOUT0B_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKOUT1_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKOUT1B_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKOUT2_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKOUT2B_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKOUT3_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKOUT3B_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_CLKOUT6_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_PSDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_tx_mmcm_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of bg_px : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of bg_px : label is "BUFG";
  attribute XILINX_TRANSFORM_PINMAP : string;
  attribute XILINX_TRANSFORM_PINMAP of bg_px : label is "VCC:CE";
  attribute BOX_TYPE of bg_txdiv2 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of bg_txdiv2 : label is "BUFG";
  attribute XILINX_TRANSFORM_PINMAP of bg_txdiv2 : label is "VCC:CE";
  attribute BOX_TYPE of bg_txdiv4 : label is "PRIMITIVE";
  attribute BOX_TYPE of tx_mmcm : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of tx_mmcm : label is "MMCME3_BASE";
  attribute XILINX_TRANSFORM_PINMAP of tx_mmcm : label is "GND:PSINCDEC,PSEN,PSCLK,DWE,DI[9],DI[8],DI[7],DI[6],DI[5],DI[4],DI[3],DI[2],DI[1],DI[15],DI[14],DI[13],DI[12],DI[11],DI[10],DI[0],DEN,DCLK,DADDR[6],DADDR[5],DADDR[4],DADDR[3],DADDR[2],DADDR[1],DADDR[0],CLKIN2,CDDCREQ VCC:CLKINSEL";
begin
  px_clk <= \^px_clk\;
bg_px: unisim.vcomponents.BUFGCE
    generic map(
      CE_TYPE => "ASYNC",
      SIM_DEVICE => "ULTRASCALE_PLUS"
    )
        port map (
      CE => '1',
      I => px_pllmmcm,
      O => \^px_clk\
    );
bg_txdiv2: unisim.vcomponents.BUFGCE
    generic map(
      CE_TYPE => "ASYNC",
      SIM_DEVICE => "ULTRASCALE_PLUS"
    )
        port map (
      CE => '1',
      I => tx_pllmmcm_div2,
      O => tx_clkdiv2
    );
bg_txdiv4: unisim.vcomponents.BUFGCE_DIV
    generic map(
      BUFGCE_DIVIDE => 2,
      CE_TYPE => "SYNC",
      HARDSYNC_CLR => "FALSE",
      IS_CE_INVERTED => '0',
      IS_CLR_INVERTED => '0',
      IS_I_INVERTED => '0',
      SIM_DEVICE => "ULTRASCALE",
      STARTUP_SYNC => "FALSE"
    )
        port map (
      CE => '1',
      CLR => '0',
      I => tx_pllmmcm_div2,
      O => tx_clkdiv4
    );
tx_mmcm: unisim.vcomponents.MMCME4_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT_F => 14.000000,
      CLKFBOUT_PHASE => 0.000000,
      CLKFBOUT_USE_FINE_PS => "FALSE",
      CLKIN1_PERIOD => 12.500000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE_F => 4.000000,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT0_USE_FINE_PS => "FALSE",
      CLKOUT1_DIVIDE => 1,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT1_USE_FINE_PS => "FALSE",
      CLKOUT2_DIVIDE => 1,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 0.000000,
      CLKOUT2_USE_FINE_PS => "FALSE",
      CLKOUT3_DIVIDE => 1,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 0.000000,
      CLKOUT3_USE_FINE_PS => "FALSE",
      CLKOUT4_CASCADE => "FALSE",
      CLKOUT4_DIVIDE => 1,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT4_USE_FINE_PS => "FALSE",
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      CLKOUT5_USE_FINE_PS => "FALSE",
      CLKOUT6_DIVIDE => 1,
      CLKOUT6_DUTY_CYCLE => 0.500000,
      CLKOUT6_PHASE => 0.000000,
      CLKOUT6_USE_FINE_PS => "FALSE",
      COMPENSATION => "ZHOLD",
      DIVCLK_DIVIDE => 1,
      IS_CLKFBIN_INVERTED => '0',
      IS_CLKIN1_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.100000,
      REF_JITTER2 => 0.010000,
      SS_EN => "FALSE",
      SS_MODE => "CENTER_HIGH",
      SS_MOD_PERIOD => 10000,
      STARTUP_WAIT => "FALSE"
    )
        port map (
      CDDCDONE => NLW_tx_mmcm_CDDCDONE_UNCONNECTED,
      CDDCREQ => '0',
      CLKFBIN => \^px_clk\,
      CLKFBOUT => px_pllmmcm,
      CLKFBOUTB => NLW_tx_mmcm_CLKFBOUTB_UNCONNECTED,
      CLKFBSTOPPED => NLW_tx_mmcm_CLKFBSTOPPED_UNCONNECTED,
      CLKIN1 => ref_clk,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKINSTOPPED => NLW_tx_mmcm_CLKINSTOPPED_UNCONNECTED,
      CLKOUT0 => tx_pllmmcm_div2,
      CLKOUT0B => NLW_tx_mmcm_CLKOUT0B_UNCONNECTED,
      CLKOUT1 => NLW_tx_mmcm_CLKOUT1_UNCONNECTED,
      CLKOUT1B => NLW_tx_mmcm_CLKOUT1B_UNCONNECTED,
      CLKOUT2 => NLW_tx_mmcm_CLKOUT2_UNCONNECTED,
      CLKOUT2B => NLW_tx_mmcm_CLKOUT2B_UNCONNECTED,
      CLKOUT3 => NLW_tx_mmcm_CLKOUT3_UNCONNECTED,
      CLKOUT3B => NLW_tx_mmcm_CLKOUT3B_UNCONNECTED,
      CLKOUT4 => NLW_tx_mmcm_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_tx_mmcm_CLKOUT5_UNCONNECTED,
      CLKOUT6 => NLW_tx_mmcm_CLKOUT6_UNCONNECTED,
      DADDR(6 downto 0) => B"0000000",
      DCLK => '0',
      DEN => '0',
      DI(15 downto 0) => B"0000000000000000",
      DO(15 downto 0) => NLW_tx_mmcm_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_tx_mmcm_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => cmt_locked,
      PSCLK => '0',
      PSDONE => NLW_tx_mmcm_PSDONE_UNCONNECTED,
      PSEN => '0',
      PSINCDEC => '0',
      PWRDWN => '0',
      RST => reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_lvds_display_tx_0_0_tx_piso_7to1 is
  port (
    RST0 : out STD_LOGIC;
    clkout_p : out STD_LOGIC;
    clkout_n : out STD_LOGIC;
    px_clk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \bit[0].mem_0\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    tx_clkdiv2 : in STD_LOGIC;
    tx_clkdiv4 : in STD_LOGIC;
    \tx_data_reg[0]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end design_1_lvds_display_tx_0_0_tx_piso_7to1;

architecture STRUCTURE of design_1_lvds_display_tx_0_0_tx_piso_7to1 is
  signal \FSM_sequential_rd_state[0]_inv_i_1__3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rd_state[1]_i_1__3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rd_state[2]_i_1__3_n_0\ : STD_LOGIC;
  signal \^rst0\ : STD_LOGIC;
  signal oserdes_out : STD_LOGIC;
  signal \p_0_in__3\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_addr : STD_LOGIC;
  signal rd_addr_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_curr : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal rd_last : STD_LOGIC_VECTOR ( 6 downto 1 );
  signal \rd_state__0\ : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal tx_data : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \tx_data[0]_i_2__3_n_0\ : STD_LOGIC;
  signal \tx_data[0]_i_3__3_n_0\ : STD_LOGIC;
  signal \tx_data[1]_i_2__3_n_0\ : STD_LOGIC;
  signal \tx_data[1]_i_3__3_n_0\ : STD_LOGIC;
  signal \tx_data[2]_i_2__3_n_0\ : STD_LOGIC;
  signal \tx_data[2]_i_3__3_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_1__3_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_3__3_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_4__3_n_0\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[2]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[3]\ : STD_LOGIC;
  signal \NLW_bit[0].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[1].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[2].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[3].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[4].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[5].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[6].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal NLW_oserdes_cm_T_OUT_UNCONNECTED : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_rd_state[1]_i_1__3\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \FSM_sequential_rd_state[2]_i_1__3\ : label is "soft_lutpair1";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[0]_inv\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute inverted : string;
  attribute inverted of \FSM_sequential_rd_state_reg[0]_inv\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[1]\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[2]\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \bit[0].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[1].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[2].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[3].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[4].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[5].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[6].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of io_clk_out : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of io_clk_out : label is "DONT_CARE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of io_clk_out : label is "OBUFDS";
  attribute BOX_TYPE of oserdes_cm : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of \rd_addr[0]_i_1__3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \rd_addr[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \rd_addr[2]_i_1__3\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \rd_addr[3]_i_1__3\ : label is "soft_lutpair0";
begin
  RST0 <= \^rst0\;
\FSM_sequential_rd_state[0]_inv_i_1__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"93"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[0]_inv_i_1__3_n_0\
    );
\FSM_sequential_rd_state[1]_i_1__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"39"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[1]_i_1__3_n_0\
    );
\FSM_sequential_rd_state[2]_i_1__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"72"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[2]_i_1__3_n_0\
    );
\FSM_sequential_rd_state_reg[0]_inv\: unisim.vcomponents.FDSE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[0]_inv_i_1__3_n_0\,
      Q => rd_addr,
      S => \^rst0\
    );
\FSM_sequential_rd_state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[1]_i_1__3_n_0\,
      Q => \rd_state__0\(1),
      R => \^rst0\
    );
\FSM_sequential_rd_state_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[2]_i_1__3_n_0\,
      Q => \rd_state__0\(2),
      R => \^rst0\
    );
\bit[0].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \bit[0].mem_0\(0),
      A1 => \bit[0].mem_0\(1),
      A2 => \bit[0].mem_0\(2),
      A3 => \bit[0].mem_0\(3),
      A4 => '0',
      D => '1',
      DPO => rd_curr(0),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[0].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[1].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \bit[0].mem_0\(0),
      A1 => \bit[0].mem_0\(1),
      A2 => \bit[0].mem_0\(2),
      A3 => \bit[0].mem_0\(3),
      A4 => '0',
      D => '1',
      DPO => rd_curr(1),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[1].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[2].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \bit[0].mem_0\(0),
      A1 => \bit[0].mem_0\(1),
      A2 => \bit[0].mem_0\(2),
      A3 => \bit[0].mem_0\(3),
      A4 => '0',
      D => '0',
      DPO => rd_curr(2),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[2].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[3].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \bit[0].mem_0\(0),
      A1 => \bit[0].mem_0\(1),
      A2 => \bit[0].mem_0\(2),
      A3 => \bit[0].mem_0\(3),
      A4 => '0',
      D => '0',
      DPO => rd_curr(3),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[3].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[4].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \bit[0].mem_0\(0),
      A1 => \bit[0].mem_0\(1),
      A2 => \bit[0].mem_0\(2),
      A3 => \bit[0].mem_0\(3),
      A4 => '0',
      D => '0',
      DPO => rd_curr(4),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[4].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[5].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \bit[0].mem_0\(0),
      A1 => \bit[0].mem_0\(1),
      A2 => \bit[0].mem_0\(2),
      A3 => \bit[0].mem_0\(3),
      A4 => '0',
      D => '1',
      DPO => rd_curr(5),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[5].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[6].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \bit[0].mem_0\(0),
      A1 => \bit[0].mem_0\(1),
      A2 => \bit[0].mem_0\(2),
      A3 => \bit[0].mem_0\(3),
      A4 => '0',
      D => '1',
      DPO => rd_curr(6),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[6].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
io_clk_out: unisim.vcomponents.OBUFDS
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => oserdes_out,
      O => clkout_p,
      OB => clkout_n
    );
oserdes_cm: unisim.vcomponents.OSERDESE3
    generic map(
      DATA_WIDTH => 4,
      INIT => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_RST_INVERTED => '0',
      ODDR_MODE => "FALSE",
      OSERDES_D_BYPASS => "FALSE",
      OSERDES_T_BYPASS => "FALSE",
      SIM_DEVICE => "ULTRASCALE_PLUS",
      SIM_VERSION => 2.000000
    )
        port map (
      CLK => tx_clkdiv2,
      CLKDIV => tx_clkdiv4,
      D(7 downto 4) => B"0000",
      D(3) => \tx_data_reg_n_0_[3]\,
      D(2) => \tx_data_reg_n_0_[2]\,
      D(1) => \tx_data_reg_n_0_[1]\,
      D(0) => \tx_data_reg_n_0_[0]\,
      OQ => oserdes_out,
      RST => \^rst0\,
      T => '0',
      T_OUT => NLW_oserdes_cm_T_OUT_UNCONNECTED
    );
oserdes_cm_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \tx_data_reg[0]_0\(0),
      O => \^rst0\
    );
\rd_addr[0]_i_1__3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rd_addr_reg(0),
      O => \p_0_in__3\(0)
    );
\rd_addr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => rd_addr_reg(1),
      I1 => rd_addr_reg(0),
      O => \p_0_in__3\(1)
    );
\rd_addr[2]_i_1__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => rd_addr_reg(2),
      I1 => rd_addr_reg(1),
      I2 => rd_addr_reg(0),
      O => \p_0_in__3\(2)
    );
\rd_addr[3]_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => rd_addr_reg(3),
      I1 => rd_addr_reg(1),
      I2 => rd_addr_reg(0),
      I3 => rd_addr_reg(2),
      O => \p_0_in__3\(3)
    );
\rd_addr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__3\(0),
      Q => rd_addr_reg(0),
      R => \^rst0\
    );
\rd_addr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__3\(1),
      Q => rd_addr_reg(1),
      R => \^rst0\
    );
\rd_addr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__3\(2),
      Q => rd_addr_reg(2),
      R => \^rst0\
    );
\rd_addr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__3\(3),
      Q => rd_addr_reg(3),
      R => \^rst0\
    );
\rd_last_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(1),
      Q => rd_last(1),
      R => '0'
    );
\rd_last_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(2),
      Q => rd_last(2),
      R => '0'
    );
\rd_last_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(3),
      Q => rd_last(3),
      R => '0'
    );
\rd_last_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(4),
      Q => rd_last(4),
      R => '0'
    );
\rd_last_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(5),
      Q => rd_last(5),
      R => '0'
    );
\rd_last_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(6),
      Q => rd_last(6),
      R => '0'
    );
\tx_data[0]_i_2__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_last(5),
      I1 => rd_last(1),
      I2 => \rd_state__0\(1),
      I3 => rd_last(4),
      I4 => rd_addr,
      I5 => rd_curr(0),
      O => \tx_data[0]_i_2__3_n_0\
    );
\tx_data[0]_i_3__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(3),
      I1 => \rd_state__0\(1),
      I2 => rd_last(6),
      I3 => rd_addr,
      I4 => rd_last(2),
      O => \tx_data[0]_i_3__3_n_0\
    );
\tx_data[1]_i_2__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_last(6),
      I1 => rd_last(2),
      I2 => \rd_state__0\(1),
      I3 => rd_last(5),
      I4 => rd_addr,
      I5 => rd_curr(1),
      O => \tx_data[1]_i_2__3_n_0\
    );
\tx_data[1]_i_3__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(4),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(0),
      I3 => rd_addr,
      I4 => rd_last(3),
      O => \tx_data[1]_i_3__3_n_0\
    );
\tx_data[2]_i_2__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_curr(0),
      I1 => rd_last(3),
      I2 => \rd_state__0\(1),
      I3 => rd_last(6),
      I4 => rd_addr,
      I5 => rd_curr(2),
      O => \tx_data[2]_i_2__3_n_0\
    );
\tx_data[2]_i_3__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(5),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(1),
      I3 => rd_addr,
      I4 => rd_last(4),
      O => \tx_data[2]_i_3__3_n_0\
    );
\tx_data[3]_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => \rd_state__0\(2),
      I1 => rd_addr,
      I2 => \rd_state__0\(1),
      I3 => \tx_data_reg[0]_0\(0),
      O => \tx_data[3]_i_1__3_n_0\
    );
\tx_data[3]_i_3__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_curr(1),
      I1 => rd_last(4),
      I2 => \rd_state__0\(1),
      I3 => rd_curr(0),
      I4 => rd_addr,
      I5 => rd_curr(3),
      O => \tx_data[3]_i_3__3_n_0\
    );
\tx_data[3]_i_4__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(6),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(2),
      I3 => rd_addr,
      I4 => rd_last(5),
      O => \tx_data[3]_i_4__3_n_0\
    );
\tx_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__3_n_0\,
      D => tx_data(0),
      Q => \tx_data_reg_n_0_[0]\,
      R => '0'
    );
\tx_data_reg[0]_i_1__3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[0]_i_2__3_n_0\,
      I1 => \tx_data[0]_i_3__3_n_0\,
      O => tx_data(0),
      S => \rd_state__0\(2)
    );
\tx_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__3_n_0\,
      D => tx_data(1),
      Q => \tx_data_reg_n_0_[1]\,
      R => '0'
    );
\tx_data_reg[1]_i_1__3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[1]_i_2__3_n_0\,
      I1 => \tx_data[1]_i_3__3_n_0\,
      O => tx_data(1),
      S => \rd_state__0\(2)
    );
\tx_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__3_n_0\,
      D => tx_data(2),
      Q => \tx_data_reg_n_0_[2]\,
      R => '0'
    );
\tx_data_reg[2]_i_1__3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[2]_i_2__3_n_0\,
      I1 => \tx_data[2]_i_3__3_n_0\,
      O => tx_data(2),
      S => \rd_state__0\(2)
    );
\tx_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__3_n_0\,
      D => tx_data(3),
      Q => \tx_data_reg_n_0_[3]\,
      R => '0'
    );
\tx_data_reg[3]_i_2__3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[3]_i_3__3_n_0\,
      I1 => \tx_data[3]_i_4__3_n_0\,
      O => tx_data(3),
      S => \rd_state__0\(2)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_lvds_display_tx_0_0_tx_piso_7to1_0 is
  port (
    \out\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dataout_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    dataout_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    px_clk : in STD_LOGIC;
    px_data : in STD_LOGIC_VECTOR ( 6 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    tx_clkdiv2 : in STD_LOGIC;
    tx_clkdiv4 : in STD_LOGIC;
    RST0 : in STD_LOGIC;
    \tx_data_reg[0]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_lvds_display_tx_0_0_tx_piso_7to1_0 : entity is "tx_piso_7to1";
end design_1_lvds_display_tx_0_0_tx_piso_7to1_0;

architecture STRUCTURE of design_1_lvds_display_tx_0_0_tx_piso_7to1_0 is
  signal \FSM_sequential_rd_state[0]_inv_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rd_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rd_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal oserdes_out : STD_LOGIC;
  signal \^out\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal p_0_in : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \p_0_in__4\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_addr : STD_LOGIC;
  signal rd_addr_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_curr : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal rd_last : STD_LOGIC_VECTOR ( 6 downto 1 );
  signal \rd_state__0\ : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal tx_data : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \tx_data[0]_i_2_n_0\ : STD_LOGIC;
  signal \tx_data[0]_i_3_n_0\ : STD_LOGIC;
  signal \tx_data[1]_i_2_n_0\ : STD_LOGIC;
  signal \tx_data[1]_i_3_n_0\ : STD_LOGIC;
  signal \tx_data[2]_i_2_n_0\ : STD_LOGIC;
  signal \tx_data[2]_i_3_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_3_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_4_n_0\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[2]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[3]\ : STD_LOGIC;
  signal \NLW_bit[0].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[1].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[2].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[3].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[4].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[5].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[6].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal NLW_oserdes_cm_T_OUT_UNCONNECTED : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_rd_state[1]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \FSM_sequential_rd_state[2]_i_1\ : label is "soft_lutpair5";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[0]_inv\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute inverted : string;
  attribute inverted of \FSM_sequential_rd_state_reg[0]_inv\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[1]\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[2]\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \bit[0].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[1].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[2].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[3].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[4].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[5].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[6].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of io_clk_out : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of io_clk_out : label is "DONT_CARE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of io_clk_out : label is "OBUFDS";
  attribute BOX_TYPE of oserdes_cm : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of \rd_addr[0]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \rd_addr[1]_i_1__3\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \rd_addr[2]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \rd_addr[3]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \wr_addr[0]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \wr_addr[1]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \wr_addr[2]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \wr_addr[3]_i_1\ : label is "soft_lutpair4";
begin
  SR(0) <= \^sr\(0);
  \out\(3 downto 0) <= \^out\(3 downto 0);
\FSM_sequential_rd_state[0]_inv_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"93"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[0]_inv_i_1_n_0\
    );
\FSM_sequential_rd_state[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"39"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[1]_i_1_n_0\
    );
\FSM_sequential_rd_state[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"72"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[2]_i_1_n_0\
    );
\FSM_sequential_rd_state_reg[0]_inv\: unisim.vcomponents.FDSE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[0]_inv_i_1_n_0\,
      Q => rd_addr,
      S => RST0
    );
\FSM_sequential_rd_state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[1]_i_1_n_0\,
      Q => \rd_state__0\(1),
      R => RST0
    );
\FSM_sequential_rd_state_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[2]_i_1_n_0\,
      Q => \rd_state__0\(2),
      R => RST0
    );
\bit[0].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \^out\(0),
      A1 => \^out\(1),
      A2 => \^out\(2),
      A3 => \^out\(3),
      A4 => '0',
      D => px_data(0),
      DPO => rd_curr(0),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[0].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[1].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \^out\(0),
      A1 => \^out\(1),
      A2 => \^out\(2),
      A3 => \^out\(3),
      A4 => '0',
      D => px_data(1),
      DPO => rd_curr(1),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[1].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[2].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \^out\(0),
      A1 => \^out\(1),
      A2 => \^out\(2),
      A3 => \^out\(3),
      A4 => '0',
      D => px_data(2),
      DPO => rd_curr(2),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[2].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[3].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \^out\(0),
      A1 => \^out\(1),
      A2 => \^out\(2),
      A3 => \^out\(3),
      A4 => '0',
      D => px_data(3),
      DPO => rd_curr(3),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[3].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[4].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \^out\(0),
      A1 => \^out\(1),
      A2 => \^out\(2),
      A3 => \^out\(3),
      A4 => '0',
      D => px_data(4),
      DPO => rd_curr(4),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[4].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[5].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \^out\(0),
      A1 => \^out\(1),
      A2 => \^out\(2),
      A3 => \^out\(3),
      A4 => '0',
      D => px_data(5),
      DPO => rd_curr(5),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[5].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[6].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \^out\(0),
      A1 => \^out\(1),
      A2 => \^out\(2),
      A3 => \^out\(3),
      A4 => '0',
      D => px_data(6),
      DPO => rd_curr(6),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[6].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
io_clk_out: unisim.vcomponents.OBUFDS
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => oserdes_out,
      O => dataout_p(0),
      OB => dataout_n(0)
    );
oserdes_cm: unisim.vcomponents.OSERDESE3
    generic map(
      DATA_WIDTH => 4,
      INIT => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_RST_INVERTED => '0',
      ODDR_MODE => "FALSE",
      OSERDES_D_BYPASS => "FALSE",
      OSERDES_T_BYPASS => "FALSE",
      SIM_DEVICE => "ULTRASCALE_PLUS",
      SIM_VERSION => 2.000000
    )
        port map (
      CLK => tx_clkdiv2,
      CLKDIV => tx_clkdiv4,
      D(7 downto 4) => B"0000",
      D(3) => \tx_data_reg_n_0_[3]\,
      D(2) => \tx_data_reg_n_0_[2]\,
      D(1) => \tx_data_reg_n_0_[1]\,
      D(0) => \tx_data_reg_n_0_[0]\,
      OQ => oserdes_out,
      RST => RST0,
      T => '0',
      T_OUT => NLW_oserdes_cm_T_OUT_UNCONNECTED
    );
\rd_addr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rd_addr_reg(0),
      O => p_0_in(0)
    );
\rd_addr[1]_i_1__3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => rd_addr_reg(1),
      I1 => rd_addr_reg(0),
      O => p_0_in(1)
    );
\rd_addr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => rd_addr_reg(2),
      I1 => rd_addr_reg(1),
      I2 => rd_addr_reg(0),
      O => p_0_in(2)
    );
\rd_addr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => rd_addr_reg(3),
      I1 => rd_addr_reg(1),
      I2 => rd_addr_reg(0),
      I3 => rd_addr_reg(2),
      O => p_0_in(3)
    );
\rd_addr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => p_0_in(0),
      Q => rd_addr_reg(0),
      R => RST0
    );
\rd_addr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => p_0_in(1),
      Q => rd_addr_reg(1),
      R => RST0
    );
\rd_addr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => p_0_in(2),
      Q => rd_addr_reg(2),
      R => RST0
    );
\rd_addr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => p_0_in(3),
      Q => rd_addr_reg(3),
      R => RST0
    );
\rd_last_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(1),
      Q => rd_last(1),
      R => '0'
    );
\rd_last_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(2),
      Q => rd_last(2),
      R => '0'
    );
\rd_last_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(3),
      Q => rd_last(3),
      R => '0'
    );
\rd_last_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(4),
      Q => rd_last(4),
      R => '0'
    );
\rd_last_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(5),
      Q => rd_last(5),
      R => '0'
    );
\rd_last_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(6),
      Q => rd_last(6),
      R => '0'
    );
\tx_data[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_last(5),
      I1 => rd_last(1),
      I2 => \rd_state__0\(1),
      I3 => rd_last(4),
      I4 => rd_addr,
      I5 => rd_curr(0),
      O => \tx_data[0]_i_2_n_0\
    );
\tx_data[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(3),
      I1 => \rd_state__0\(1),
      I2 => rd_last(6),
      I3 => rd_addr,
      I4 => rd_last(2),
      O => \tx_data[0]_i_3_n_0\
    );
\tx_data[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_last(6),
      I1 => rd_last(2),
      I2 => \rd_state__0\(1),
      I3 => rd_last(5),
      I4 => rd_addr,
      I5 => rd_curr(1),
      O => \tx_data[1]_i_2_n_0\
    );
\tx_data[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(4),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(0),
      I3 => rd_addr,
      I4 => rd_last(3),
      O => \tx_data[1]_i_3_n_0\
    );
\tx_data[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_curr(0),
      I1 => rd_last(3),
      I2 => \rd_state__0\(1),
      I3 => rd_last(6),
      I4 => rd_addr,
      I5 => rd_curr(2),
      O => \tx_data[2]_i_2_n_0\
    );
\tx_data[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(5),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(1),
      I3 => rd_addr,
      I4 => rd_last(4),
      O => \tx_data[2]_i_3_n_0\
    );
\tx_data[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      I3 => \tx_data_reg[0]_0\(0),
      O => \tx_data[3]_i_1_n_0\
    );
\tx_data[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_curr(1),
      I1 => rd_last(4),
      I2 => \rd_state__0\(1),
      I3 => rd_curr(0),
      I4 => rd_addr,
      I5 => rd_curr(3),
      O => \tx_data[3]_i_3_n_0\
    );
\tx_data[3]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(6),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(2),
      I3 => rd_addr,
      I4 => rd_last(5),
      O => \tx_data[3]_i_4_n_0\
    );
\tx_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1_n_0\,
      D => tx_data(0),
      Q => \tx_data_reg_n_0_[0]\,
      R => '0'
    );
\tx_data_reg[0]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[0]_i_2_n_0\,
      I1 => \tx_data[0]_i_3_n_0\,
      O => tx_data(0),
      S => \rd_state__0\(2)
    );
\tx_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1_n_0\,
      D => tx_data(1),
      Q => \tx_data_reg_n_0_[1]\,
      R => '0'
    );
\tx_data_reg[1]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[1]_i_2_n_0\,
      I1 => \tx_data[1]_i_3_n_0\,
      O => tx_data(1),
      S => \rd_state__0\(2)
    );
\tx_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1_n_0\,
      D => tx_data(2),
      Q => \tx_data_reg_n_0_[2]\,
      R => '0'
    );
\tx_data_reg[2]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[2]_i_2_n_0\,
      I1 => \tx_data[2]_i_3_n_0\,
      O => tx_data(2),
      S => \rd_state__0\(2)
    );
\tx_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1_n_0\,
      D => tx_data(3),
      Q => \tx_data_reg_n_0_[3]\,
      R => '0'
    );
\tx_data_reg[3]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[3]_i_3_n_0\,
      I1 => \tx_data[3]_i_4_n_0\,
      O => tx_data(3),
      S => \rd_state__0\(2)
    );
\tx_enable_sync[7]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(0),
      O => \^sr\(0)
    );
\wr_addr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^out\(0),
      O => \p_0_in__4\(0)
    );
\wr_addr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^out\(0),
      I1 => \^out\(1),
      O => \p_0_in__4\(1)
    );
\wr_addr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^out\(0),
      I1 => \^out\(1),
      I2 => \^out\(2),
      O => \p_0_in__4\(2)
    );
\wr_addr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^out\(1),
      I1 => \^out\(0),
      I2 => \^out\(2),
      I3 => \^out\(3),
      O => \p_0_in__4\(3)
    );
\wr_addr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => px_clk,
      CE => '1',
      D => \p_0_in__4\(0),
      Q => \^out\(0),
      R => \^sr\(0)
    );
\wr_addr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => px_clk,
      CE => '1',
      D => \p_0_in__4\(1),
      Q => \^out\(1),
      R => \^sr\(0)
    );
\wr_addr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => px_clk,
      CE => '1',
      D => \p_0_in__4\(2),
      Q => \^out\(2),
      R => \^sr\(0)
    );
\wr_addr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => px_clk,
      CE => '1',
      D => \p_0_in__4\(3),
      Q => \^out\(3),
      R => \^sr\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_lvds_display_tx_0_0_tx_piso_7to1_1 is
  port (
    dataout_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    dataout_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    px_clk : in STD_LOGIC;
    px_data : in STD_LOGIC_VECTOR ( 6 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \out\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    tx_clkdiv2 : in STD_LOGIC;
    tx_clkdiv4 : in STD_LOGIC;
    RST0 : in STD_LOGIC;
    \tx_data_reg[0]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_lvds_display_tx_0_0_tx_piso_7to1_1 : entity is "tx_piso_7to1";
end design_1_lvds_display_tx_0_0_tx_piso_7to1_1;

architecture STRUCTURE of design_1_lvds_display_tx_0_0_tx_piso_7to1_1 is
  signal \FSM_sequential_rd_state[0]_inv_i_1__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rd_state[1]_i_1__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rd_state[2]_i_1__0_n_0\ : STD_LOGIC;
  signal oserdes_out : STD_LOGIC;
  signal \p_0_in__0\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_addr : STD_LOGIC;
  signal rd_addr_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_curr : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal rd_last : STD_LOGIC_VECTOR ( 6 downto 1 );
  signal \rd_state__0\ : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal tx_data : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \tx_data[0]_i_2__0_n_0\ : STD_LOGIC;
  signal \tx_data[0]_i_3__0_n_0\ : STD_LOGIC;
  signal \tx_data[1]_i_2__0_n_0\ : STD_LOGIC;
  signal \tx_data[1]_i_3__0_n_0\ : STD_LOGIC;
  signal \tx_data[2]_i_2__0_n_0\ : STD_LOGIC;
  signal \tx_data[2]_i_3__0_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_1__0_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_3__0_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_4__0_n_0\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[2]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[3]\ : STD_LOGIC;
  signal \NLW_bit[0].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[1].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[2].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[3].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[4].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[5].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[6].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal NLW_oserdes_cm_T_OUT_UNCONNECTED : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_rd_state[1]_i_1__0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \FSM_sequential_rd_state[2]_i_1__0\ : label is "soft_lutpair9";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[0]_inv\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute inverted : string;
  attribute inverted of \FSM_sequential_rd_state_reg[0]_inv\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[1]\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[2]\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \bit[0].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[1].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[2].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[3].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[4].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[5].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[6].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of io_clk_out : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of io_clk_out : label is "DONT_CARE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of io_clk_out : label is "OBUFDS";
  attribute BOX_TYPE of oserdes_cm : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of \rd_addr[0]_i_1__0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \rd_addr[1]_i_1__2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \rd_addr[2]_i_1__0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \rd_addr[3]_i_1__0\ : label is "soft_lutpair8";
begin
\FSM_sequential_rd_state[0]_inv_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"93"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[0]_inv_i_1__0_n_0\
    );
\FSM_sequential_rd_state[1]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"39"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[1]_i_1__0_n_0\
    );
\FSM_sequential_rd_state[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"72"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[2]_i_1__0_n_0\
    );
\FSM_sequential_rd_state_reg[0]_inv\: unisim.vcomponents.FDSE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[0]_inv_i_1__0_n_0\,
      Q => rd_addr,
      S => RST0
    );
\FSM_sequential_rd_state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[1]_i_1__0_n_0\,
      Q => \rd_state__0\(1),
      R => RST0
    );
\FSM_sequential_rd_state_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[2]_i_1__0_n_0\,
      Q => \rd_state__0\(2),
      R => RST0
    );
\bit[0].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(0),
      DPO => rd_curr(0),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[0].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[1].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(1),
      DPO => rd_curr(1),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[1].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[2].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(2),
      DPO => rd_curr(2),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[2].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[3].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(3),
      DPO => rd_curr(3),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[3].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[4].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(4),
      DPO => rd_curr(4),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[4].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[5].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(5),
      DPO => rd_curr(5),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[5].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[6].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(6),
      DPO => rd_curr(6),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[6].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
io_clk_out: unisim.vcomponents.OBUFDS
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => oserdes_out,
      O => dataout_p(0),
      OB => dataout_n(0)
    );
oserdes_cm: unisim.vcomponents.OSERDESE3
    generic map(
      DATA_WIDTH => 4,
      INIT => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_RST_INVERTED => '0',
      ODDR_MODE => "FALSE",
      OSERDES_D_BYPASS => "FALSE",
      OSERDES_T_BYPASS => "FALSE",
      SIM_DEVICE => "ULTRASCALE_PLUS",
      SIM_VERSION => 2.000000
    )
        port map (
      CLK => tx_clkdiv2,
      CLKDIV => tx_clkdiv4,
      D(7 downto 4) => B"0000",
      D(3) => \tx_data_reg_n_0_[3]\,
      D(2) => \tx_data_reg_n_0_[2]\,
      D(1) => \tx_data_reg_n_0_[1]\,
      D(0) => \tx_data_reg_n_0_[0]\,
      OQ => oserdes_out,
      RST => RST0,
      T => '0',
      T_OUT => NLW_oserdes_cm_T_OUT_UNCONNECTED
    );
\rd_addr[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rd_addr_reg(0),
      O => \p_0_in__0\(0)
    );
\rd_addr[1]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => rd_addr_reg(1),
      I1 => rd_addr_reg(0),
      O => \p_0_in__0\(1)
    );
\rd_addr[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => rd_addr_reg(2),
      I1 => rd_addr_reg(1),
      I2 => rd_addr_reg(0),
      O => \p_0_in__0\(2)
    );
\rd_addr[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => rd_addr_reg(3),
      I1 => rd_addr_reg(1),
      I2 => rd_addr_reg(0),
      I3 => rd_addr_reg(2),
      O => \p_0_in__0\(3)
    );
\rd_addr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__0\(0),
      Q => rd_addr_reg(0),
      R => RST0
    );
\rd_addr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__0\(1),
      Q => rd_addr_reg(1),
      R => RST0
    );
\rd_addr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__0\(2),
      Q => rd_addr_reg(2),
      R => RST0
    );
\rd_addr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__0\(3),
      Q => rd_addr_reg(3),
      R => RST0
    );
\rd_last_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(1),
      Q => rd_last(1),
      R => '0'
    );
\rd_last_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(2),
      Q => rd_last(2),
      R => '0'
    );
\rd_last_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(3),
      Q => rd_last(3),
      R => '0'
    );
\rd_last_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(4),
      Q => rd_last(4),
      R => '0'
    );
\rd_last_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(5),
      Q => rd_last(5),
      R => '0'
    );
\rd_last_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(6),
      Q => rd_last(6),
      R => '0'
    );
\tx_data[0]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_last(5),
      I1 => rd_last(1),
      I2 => \rd_state__0\(1),
      I3 => rd_last(4),
      I4 => rd_addr,
      I5 => rd_curr(0),
      O => \tx_data[0]_i_2__0_n_0\
    );
\tx_data[0]_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(3),
      I1 => \rd_state__0\(1),
      I2 => rd_last(6),
      I3 => rd_addr,
      I4 => rd_last(2),
      O => \tx_data[0]_i_3__0_n_0\
    );
\tx_data[1]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_last(6),
      I1 => rd_last(2),
      I2 => \rd_state__0\(1),
      I3 => rd_last(5),
      I4 => rd_addr,
      I5 => rd_curr(1),
      O => \tx_data[1]_i_2__0_n_0\
    );
\tx_data[1]_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(4),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(0),
      I3 => rd_addr,
      I4 => rd_last(3),
      O => \tx_data[1]_i_3__0_n_0\
    );
\tx_data[2]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_curr(0),
      I1 => rd_last(3),
      I2 => \rd_state__0\(1),
      I3 => rd_last(6),
      I4 => rd_addr,
      I5 => rd_curr(2),
      O => \tx_data[2]_i_2__0_n_0\
    );
\tx_data[2]_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(5),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(1),
      I3 => rd_addr,
      I4 => rd_last(4),
      O => \tx_data[2]_i_3__0_n_0\
    );
\tx_data[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => \rd_state__0\(2),
      I1 => rd_addr,
      I2 => \rd_state__0\(1),
      I3 => \tx_data_reg[0]_0\(0),
      O => \tx_data[3]_i_1__0_n_0\
    );
\tx_data[3]_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_curr(1),
      I1 => rd_last(4),
      I2 => \rd_state__0\(1),
      I3 => rd_curr(0),
      I4 => rd_addr,
      I5 => rd_curr(3),
      O => \tx_data[3]_i_3__0_n_0\
    );
\tx_data[3]_i_4__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(6),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(2),
      I3 => rd_addr,
      I4 => rd_last(5),
      O => \tx_data[3]_i_4__0_n_0\
    );
\tx_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__0_n_0\,
      D => tx_data(0),
      Q => \tx_data_reg_n_0_[0]\,
      R => '0'
    );
\tx_data_reg[0]_i_1__0\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[0]_i_2__0_n_0\,
      I1 => \tx_data[0]_i_3__0_n_0\,
      O => tx_data(0),
      S => \rd_state__0\(2)
    );
\tx_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__0_n_0\,
      D => tx_data(1),
      Q => \tx_data_reg_n_0_[1]\,
      R => '0'
    );
\tx_data_reg[1]_i_1__0\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[1]_i_2__0_n_0\,
      I1 => \tx_data[1]_i_3__0_n_0\,
      O => tx_data(1),
      S => \rd_state__0\(2)
    );
\tx_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__0_n_0\,
      D => tx_data(2),
      Q => \tx_data_reg_n_0_[2]\,
      R => '0'
    );
\tx_data_reg[2]_i_1__0\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[2]_i_2__0_n_0\,
      I1 => \tx_data[2]_i_3__0_n_0\,
      O => tx_data(2),
      S => \rd_state__0\(2)
    );
\tx_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__0_n_0\,
      D => tx_data(3),
      Q => \tx_data_reg_n_0_[3]\,
      R => '0'
    );
\tx_data_reg[3]_i_2__0\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[3]_i_3__0_n_0\,
      I1 => \tx_data[3]_i_4__0_n_0\,
      O => tx_data(3),
      S => \rd_state__0\(2)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_lvds_display_tx_0_0_tx_piso_7to1_2 is
  port (
    dataout_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    dataout_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    px_clk : in STD_LOGIC;
    px_data : in STD_LOGIC_VECTOR ( 6 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \out\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    tx_clkdiv2 : in STD_LOGIC;
    tx_clkdiv4 : in STD_LOGIC;
    RST0 : in STD_LOGIC;
    \tx_data_reg[0]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_lvds_display_tx_0_0_tx_piso_7to1_2 : entity is "tx_piso_7to1";
end design_1_lvds_display_tx_0_0_tx_piso_7to1_2;

architecture STRUCTURE of design_1_lvds_display_tx_0_0_tx_piso_7to1_2 is
  signal \FSM_sequential_rd_state[0]_inv_i_1__1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rd_state[1]_i_1__1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rd_state[2]_i_1__1_n_0\ : STD_LOGIC;
  signal oserdes_out : STD_LOGIC;
  signal \p_0_in__1\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_addr : STD_LOGIC;
  signal rd_addr_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_curr : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal rd_last : STD_LOGIC_VECTOR ( 6 downto 1 );
  signal \rd_state__0\ : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal tx_data : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \tx_data[0]_i_2__1_n_0\ : STD_LOGIC;
  signal \tx_data[0]_i_3__1_n_0\ : STD_LOGIC;
  signal \tx_data[1]_i_2__1_n_0\ : STD_LOGIC;
  signal \tx_data[1]_i_3__1_n_0\ : STD_LOGIC;
  signal \tx_data[2]_i_2__1_n_0\ : STD_LOGIC;
  signal \tx_data[2]_i_3__1_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_1__1_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_3__1_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_4__1_n_0\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[2]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[3]\ : STD_LOGIC;
  signal \NLW_bit[0].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[1].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[2].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[3].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[4].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[5].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[6].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal NLW_oserdes_cm_T_OUT_UNCONNECTED : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_rd_state[1]_i_1__1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \FSM_sequential_rd_state[2]_i_1__1\ : label is "soft_lutpair12";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[0]_inv\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute inverted : string;
  attribute inverted of \FSM_sequential_rd_state_reg[0]_inv\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[1]\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[2]\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \bit[0].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[1].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[2].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[3].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[4].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[5].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[6].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of io_clk_out : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of io_clk_out : label is "DONT_CARE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of io_clk_out : label is "OBUFDS";
  attribute BOX_TYPE of oserdes_cm : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of \rd_addr[0]_i_1__1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \rd_addr[1]_i_1__1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \rd_addr[2]_i_1__1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \rd_addr[3]_i_1__1\ : label is "soft_lutpair11";
begin
\FSM_sequential_rd_state[0]_inv_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"93"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[0]_inv_i_1__1_n_0\
    );
\FSM_sequential_rd_state[1]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"39"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[1]_i_1__1_n_0\
    );
\FSM_sequential_rd_state[2]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"72"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[2]_i_1__1_n_0\
    );
\FSM_sequential_rd_state_reg[0]_inv\: unisim.vcomponents.FDSE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[0]_inv_i_1__1_n_0\,
      Q => rd_addr,
      S => RST0
    );
\FSM_sequential_rd_state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[1]_i_1__1_n_0\,
      Q => \rd_state__0\(1),
      R => RST0
    );
\FSM_sequential_rd_state_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[2]_i_1__1_n_0\,
      Q => \rd_state__0\(2),
      R => RST0
    );
\bit[0].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(0),
      DPO => rd_curr(0),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[0].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[1].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(1),
      DPO => rd_curr(1),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[1].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[2].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(2),
      DPO => rd_curr(2),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[2].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[3].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(3),
      DPO => rd_curr(3),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[3].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[4].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(4),
      DPO => rd_curr(4),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[4].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[5].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(5),
      DPO => rd_curr(5),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[5].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[6].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(6),
      DPO => rd_curr(6),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[6].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
io_clk_out: unisim.vcomponents.OBUFDS
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => oserdes_out,
      O => dataout_p(0),
      OB => dataout_n(0)
    );
oserdes_cm: unisim.vcomponents.OSERDESE3
    generic map(
      DATA_WIDTH => 4,
      INIT => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_RST_INVERTED => '0',
      ODDR_MODE => "FALSE",
      OSERDES_D_BYPASS => "FALSE",
      OSERDES_T_BYPASS => "FALSE",
      SIM_DEVICE => "ULTRASCALE_PLUS",
      SIM_VERSION => 2.000000
    )
        port map (
      CLK => tx_clkdiv2,
      CLKDIV => tx_clkdiv4,
      D(7 downto 4) => B"0000",
      D(3) => \tx_data_reg_n_0_[3]\,
      D(2) => \tx_data_reg_n_0_[2]\,
      D(1) => \tx_data_reg_n_0_[1]\,
      D(0) => \tx_data_reg_n_0_[0]\,
      OQ => oserdes_out,
      RST => RST0,
      T => '0',
      T_OUT => NLW_oserdes_cm_T_OUT_UNCONNECTED
    );
\rd_addr[0]_i_1__1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rd_addr_reg(0),
      O => \p_0_in__1\(0)
    );
\rd_addr[1]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => rd_addr_reg(1),
      I1 => rd_addr_reg(0),
      O => \p_0_in__1\(1)
    );
\rd_addr[2]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => rd_addr_reg(2),
      I1 => rd_addr_reg(1),
      I2 => rd_addr_reg(0),
      O => \p_0_in__1\(2)
    );
\rd_addr[3]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => rd_addr_reg(3),
      I1 => rd_addr_reg(1),
      I2 => rd_addr_reg(0),
      I3 => rd_addr_reg(2),
      O => \p_0_in__1\(3)
    );
\rd_addr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__1\(0),
      Q => rd_addr_reg(0),
      R => RST0
    );
\rd_addr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__1\(1),
      Q => rd_addr_reg(1),
      R => RST0
    );
\rd_addr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__1\(2),
      Q => rd_addr_reg(2),
      R => RST0
    );
\rd_addr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__1\(3),
      Q => rd_addr_reg(3),
      R => RST0
    );
\rd_last_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(1),
      Q => rd_last(1),
      R => '0'
    );
\rd_last_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(2),
      Q => rd_last(2),
      R => '0'
    );
\rd_last_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(3),
      Q => rd_last(3),
      R => '0'
    );
\rd_last_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(4),
      Q => rd_last(4),
      R => '0'
    );
\rd_last_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(5),
      Q => rd_last(5),
      R => '0'
    );
\rd_last_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(6),
      Q => rd_last(6),
      R => '0'
    );
\tx_data[0]_i_2__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_last(5),
      I1 => rd_last(1),
      I2 => \rd_state__0\(1),
      I3 => rd_last(4),
      I4 => rd_addr,
      I5 => rd_curr(0),
      O => \tx_data[0]_i_2__1_n_0\
    );
\tx_data[0]_i_3__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(3),
      I1 => \rd_state__0\(1),
      I2 => rd_last(6),
      I3 => rd_addr,
      I4 => rd_last(2),
      O => \tx_data[0]_i_3__1_n_0\
    );
\tx_data[1]_i_2__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_last(6),
      I1 => rd_last(2),
      I2 => \rd_state__0\(1),
      I3 => rd_last(5),
      I4 => rd_addr,
      I5 => rd_curr(1),
      O => \tx_data[1]_i_2__1_n_0\
    );
\tx_data[1]_i_3__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(4),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(0),
      I3 => rd_addr,
      I4 => rd_last(3),
      O => \tx_data[1]_i_3__1_n_0\
    );
\tx_data[2]_i_2__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_curr(0),
      I1 => rd_last(3),
      I2 => \rd_state__0\(1),
      I3 => rd_last(6),
      I4 => rd_addr,
      I5 => rd_curr(2),
      O => \tx_data[2]_i_2__1_n_0\
    );
\tx_data[2]_i_3__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(5),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(1),
      I3 => rd_addr,
      I4 => rd_last(4),
      O => \tx_data[2]_i_3__1_n_0\
    );
\tx_data[3]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => \rd_state__0\(2),
      I1 => rd_addr,
      I2 => \rd_state__0\(1),
      I3 => \tx_data_reg[0]_0\(0),
      O => \tx_data[3]_i_1__1_n_0\
    );
\tx_data[3]_i_3__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_curr(1),
      I1 => rd_last(4),
      I2 => \rd_state__0\(1),
      I3 => rd_curr(0),
      I4 => rd_addr,
      I5 => rd_curr(3),
      O => \tx_data[3]_i_3__1_n_0\
    );
\tx_data[3]_i_4__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(6),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(2),
      I3 => rd_addr,
      I4 => rd_last(5),
      O => \tx_data[3]_i_4__1_n_0\
    );
\tx_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__1_n_0\,
      D => tx_data(0),
      Q => \tx_data_reg_n_0_[0]\,
      R => '0'
    );
\tx_data_reg[0]_i_1__1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[0]_i_2__1_n_0\,
      I1 => \tx_data[0]_i_3__1_n_0\,
      O => tx_data(0),
      S => \rd_state__0\(2)
    );
\tx_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__1_n_0\,
      D => tx_data(1),
      Q => \tx_data_reg_n_0_[1]\,
      R => '0'
    );
\tx_data_reg[1]_i_1__1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[1]_i_2__1_n_0\,
      I1 => \tx_data[1]_i_3__1_n_0\,
      O => tx_data(1),
      S => \rd_state__0\(2)
    );
\tx_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__1_n_0\,
      D => tx_data(2),
      Q => \tx_data_reg_n_0_[2]\,
      R => '0'
    );
\tx_data_reg[2]_i_1__1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[2]_i_2__1_n_0\,
      I1 => \tx_data[2]_i_3__1_n_0\,
      O => tx_data(2),
      S => \rd_state__0\(2)
    );
\tx_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__1_n_0\,
      D => tx_data(3),
      Q => \tx_data_reg_n_0_[3]\,
      R => '0'
    );
\tx_data_reg[3]_i_2__1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[3]_i_3__1_n_0\,
      I1 => \tx_data[3]_i_4__1_n_0\,
      O => tx_data(3),
      S => \rd_state__0\(2)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_lvds_display_tx_0_0_tx_piso_7to1_3 is
  port (
    dataout_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    dataout_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    px_clk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \out\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    px_data : in STD_LOGIC_VECTOR ( 5 downto 0 );
    tx_clkdiv2 : in STD_LOGIC;
    tx_clkdiv4 : in STD_LOGIC;
    RST0 : in STD_LOGIC;
    \tx_data_reg[0]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_lvds_display_tx_0_0_tx_piso_7to1_3 : entity is "tx_piso_7to1";
end design_1_lvds_display_tx_0_0_tx_piso_7to1_3;

architecture STRUCTURE of design_1_lvds_display_tx_0_0_tx_piso_7to1_3 is
  signal \FSM_sequential_rd_state[0]_inv_i_1__2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rd_state[1]_i_1__2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rd_state[2]_i_1__2_n_0\ : STD_LOGIC;
  signal oserdes_out : STD_LOGIC;
  signal \p_0_in__2\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_addr : STD_LOGIC;
  signal rd_addr_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_curr : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal rd_last : STD_LOGIC_VECTOR ( 6 downto 1 );
  signal \rd_state__0\ : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal tx_data : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \tx_data[0]_i_2__2_n_0\ : STD_LOGIC;
  signal \tx_data[0]_i_3__2_n_0\ : STD_LOGIC;
  signal \tx_data[1]_i_2__2_n_0\ : STD_LOGIC;
  signal \tx_data[1]_i_3__2_n_0\ : STD_LOGIC;
  signal \tx_data[2]_i_2__2_n_0\ : STD_LOGIC;
  signal \tx_data[2]_i_3__2_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_1__2_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_3__2_n_0\ : STD_LOGIC;
  signal \tx_data[3]_i_4__2_n_0\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[2]\ : STD_LOGIC;
  signal \tx_data_reg_n_0_[3]\ : STD_LOGIC;
  signal \NLW_bit[0].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[1].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[2].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[3].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[4].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[5].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bit[6].mem_SPO_UNCONNECTED\ : STD_LOGIC;
  signal NLW_oserdes_cm_T_OUT_UNCONNECTED : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_rd_state[1]_i_1__2\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \FSM_sequential_rd_state[2]_i_1__2\ : label is "soft_lutpair15";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[0]_inv\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute inverted : string;
  attribute inverted of \FSM_sequential_rd_state_reg[0]_inv\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[1]\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rd_state_reg[2]\ : label is "iSTATE:000,iSTATE0:001,iSTATE1:010,iSTATE2:011,iSTATE3:100,iSTATE4:101,iSTATE5:110,";
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \bit[0].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[1].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[2].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[3].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[4].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[5].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \bit[6].mem\ : label is "PRIMITIVE";
  attribute BOX_TYPE of io_clk_out : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of io_clk_out : label is "DONT_CARE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of io_clk_out : label is "OBUFDS";
  attribute BOX_TYPE of oserdes_cm : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of \rd_addr[0]_i_1__2\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \rd_addr[1]_i_1__0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \rd_addr[2]_i_1__2\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \rd_addr[3]_i_1__2\ : label is "soft_lutpair14";
begin
\FSM_sequential_rd_state[0]_inv_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"93"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[0]_inv_i_1__2_n_0\
    );
\FSM_sequential_rd_state[1]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"39"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[1]_i_1__2_n_0\
    );
\FSM_sequential_rd_state[2]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"72"
    )
        port map (
      I0 => \rd_state__0\(1),
      I1 => rd_addr,
      I2 => \rd_state__0\(2),
      O => \FSM_sequential_rd_state[2]_i_1__2_n_0\
    );
\FSM_sequential_rd_state_reg[0]_inv\: unisim.vcomponents.FDSE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[0]_inv_i_1__2_n_0\,
      Q => rd_addr,
      S => RST0
    );
\FSM_sequential_rd_state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[1]_i_1__2_n_0\,
      Q => \rd_state__0\(1),
      R => RST0
    );
\FSM_sequential_rd_state_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => \FSM_sequential_rd_state[2]_i_1__2_n_0\,
      Q => \rd_state__0\(2),
      R => RST0
    );
\bit[0].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => '0',
      DPO => rd_curr(0),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[0].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[1].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(0),
      DPO => rd_curr(1),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[1].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[2].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(1),
      DPO => rd_curr(2),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[2].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[3].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(2),
      DPO => rd_curr(3),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[3].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[4].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(3),
      DPO => rd_curr(4),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[4].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[5].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(4),
      DPO => rd_curr(5),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[5].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
\bit[6].mem\: unisim.vcomponents.RAM32X1D
    generic map(
      INIT => X"00000000",
      IS_WCLK_INVERTED => '0'
    )
        port map (
      A0 => \out\(0),
      A1 => \out\(1),
      A2 => \out\(2),
      A3 => \out\(3),
      A4 => '0',
      D => px_data(5),
      DPO => rd_curr(6),
      DPRA0 => rd_addr_reg(0),
      DPRA1 => rd_addr_reg(1),
      DPRA2 => rd_addr_reg(2),
      DPRA3 => rd_addr_reg(3),
      DPRA4 => '0',
      SPO => \NLW_bit[6].mem_SPO_UNCONNECTED\,
      WCLK => px_clk,
      WE => Q(0)
    );
io_clk_out: unisim.vcomponents.OBUFDS
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => oserdes_out,
      O => dataout_p(0),
      OB => dataout_n(0)
    );
oserdes_cm: unisim.vcomponents.OSERDESE3
    generic map(
      DATA_WIDTH => 4,
      INIT => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_RST_INVERTED => '0',
      ODDR_MODE => "FALSE",
      OSERDES_D_BYPASS => "FALSE",
      OSERDES_T_BYPASS => "FALSE",
      SIM_DEVICE => "ULTRASCALE_PLUS",
      SIM_VERSION => 2.000000
    )
        port map (
      CLK => tx_clkdiv2,
      CLKDIV => tx_clkdiv4,
      D(7 downto 4) => B"0000",
      D(3) => \tx_data_reg_n_0_[3]\,
      D(2) => \tx_data_reg_n_0_[2]\,
      D(1) => \tx_data_reg_n_0_[1]\,
      D(0) => \tx_data_reg_n_0_[0]\,
      OQ => oserdes_out,
      RST => RST0,
      T => '0',
      T_OUT => NLW_oserdes_cm_T_OUT_UNCONNECTED
    );
\rd_addr[0]_i_1__2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rd_addr_reg(0),
      O => \p_0_in__2\(0)
    );
\rd_addr[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => rd_addr_reg(1),
      I1 => rd_addr_reg(0),
      O => \p_0_in__2\(1)
    );
\rd_addr[2]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => rd_addr_reg(2),
      I1 => rd_addr_reg(1),
      I2 => rd_addr_reg(0),
      O => \p_0_in__2\(2)
    );
\rd_addr[3]_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => rd_addr_reg(3),
      I1 => rd_addr_reg(1),
      I2 => rd_addr_reg(0),
      I3 => rd_addr_reg(2),
      O => \p_0_in__2\(3)
    );
\rd_addr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__2\(0),
      Q => rd_addr_reg(0),
      R => RST0
    );
\rd_addr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__2\(1),
      Q => rd_addr_reg(1),
      R => RST0
    );
\rd_addr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__2\(2),
      Q => rd_addr_reg(2),
      R => RST0
    );
\rd_addr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => rd_addr,
      D => \p_0_in__2\(3),
      Q => rd_addr_reg(3),
      R => RST0
    );
\rd_last_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(1),
      Q => rd_last(1),
      R => '0'
    );
\rd_last_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(2),
      Q => rd_last(2),
      R => '0'
    );
\rd_last_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(3),
      Q => rd_last(3),
      R => '0'
    );
\rd_last_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(4),
      Q => rd_last(4),
      R => '0'
    );
\rd_last_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(5),
      Q => rd_last(5),
      R => '0'
    );
\rd_last_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      D => rd_curr(6),
      Q => rd_last(6),
      R => '0'
    );
\tx_data[0]_i_2__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_last(5),
      I1 => rd_last(1),
      I2 => \rd_state__0\(1),
      I3 => rd_last(4),
      I4 => rd_addr,
      I5 => rd_curr(0),
      O => \tx_data[0]_i_2__2_n_0\
    );
\tx_data[0]_i_3__2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(3),
      I1 => \rd_state__0\(1),
      I2 => rd_last(6),
      I3 => rd_addr,
      I4 => rd_last(2),
      O => \tx_data[0]_i_3__2_n_0\
    );
\tx_data[1]_i_2__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_last(6),
      I1 => rd_last(2),
      I2 => \rd_state__0\(1),
      I3 => rd_last(5),
      I4 => rd_addr,
      I5 => rd_curr(1),
      O => \tx_data[1]_i_2__2_n_0\
    );
\tx_data[1]_i_3__2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(4),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(0),
      I3 => rd_addr,
      I4 => rd_last(3),
      O => \tx_data[1]_i_3__2_n_0\
    );
\tx_data[2]_i_2__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_curr(0),
      I1 => rd_last(3),
      I2 => \rd_state__0\(1),
      I3 => rd_last(6),
      I4 => rd_addr,
      I5 => rd_curr(2),
      O => \tx_data[2]_i_2__2_n_0\
    );
\tx_data[2]_i_3__2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(5),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(1),
      I3 => rd_addr,
      I4 => rd_last(4),
      O => \tx_data[2]_i_3__2_n_0\
    );
\tx_data[3]_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => \rd_state__0\(2),
      I1 => rd_addr,
      I2 => \rd_state__0\(1),
      I3 => \tx_data_reg[0]_0\(0),
      O => \tx_data[3]_i_1__2_n_0\
    );
\tx_data[3]_i_3__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCFAFA0C0C0AFA0"
    )
        port map (
      I0 => rd_curr(1),
      I1 => rd_last(4),
      I2 => \rd_state__0\(1),
      I3 => rd_curr(0),
      I4 => rd_addr,
      I5 => rd_curr(3),
      O => \tx_data[3]_i_3__2_n_0\
    );
\tx_data[3]_i_4__2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB888B8"
    )
        port map (
      I0 => rd_last(6),
      I1 => \rd_state__0\(1),
      I2 => rd_curr(2),
      I3 => rd_addr,
      I4 => rd_last(5),
      O => \tx_data[3]_i_4__2_n_0\
    );
\tx_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__2_n_0\,
      D => tx_data(0),
      Q => \tx_data_reg_n_0_[0]\,
      R => '0'
    );
\tx_data_reg[0]_i_1__2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[0]_i_2__2_n_0\,
      I1 => \tx_data[0]_i_3__2_n_0\,
      O => tx_data(0),
      S => \rd_state__0\(2)
    );
\tx_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__2_n_0\,
      D => tx_data(1),
      Q => \tx_data_reg_n_0_[1]\,
      R => '0'
    );
\tx_data_reg[1]_i_1__2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[1]_i_2__2_n_0\,
      I1 => \tx_data[1]_i_3__2_n_0\,
      O => tx_data(1),
      S => \rd_state__0\(2)
    );
\tx_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__2_n_0\,
      D => tx_data(2),
      Q => \tx_data_reg_n_0_[2]\,
      R => '0'
    );
\tx_data_reg[2]_i_1__2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[2]_i_2__2_n_0\,
      I1 => \tx_data[2]_i_3__2_n_0\,
      O => tx_data(2),
      S => \rd_state__0\(2)
    );
\tx_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => tx_clkdiv4,
      CE => \tx_data[3]_i_1__2_n_0\,
      D => tx_data(3),
      Q => \tx_data_reg_n_0_[3]\,
      R => '0'
    );
\tx_data_reg[3]_i_2__2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \tx_data[3]_i_3__2_n_0\,
      I1 => \tx_data[3]_i_4__2_n_0\,
      O => tx_data(3),
      S => \rd_state__0\(2)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_lvds_display_tx_0_0_tx_channel_7to1 is
  port (
    dataout_p : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dataout_n : out STD_LOGIC_VECTOR ( 3 downto 0 );
    clkout_p : out STD_LOGIC;
    clkout_n : out STD_LOGIC;
    px_clk : in STD_LOGIC;
    px_data : in STD_LOGIC_VECTOR ( 26 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    tx_clkdiv2 : in STD_LOGIC;
    tx_clkdiv4 : in STD_LOGIC
  );
end design_1_lvds_display_tx_0_0_tx_channel_7to1;

architecture STRUCTURE of design_1_lvds_display_tx_0_0_tx_channel_7to1 is
  signal RST0 : STD_LOGIC;
  signal clear : STD_LOGIC;
  signal \tx_enable_sync_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_enable_sync_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_enable_sync_reg_n_0_[2]\ : STD_LOGIC;
  signal \tx_enable_sync_reg_n_0_[3]\ : STD_LOGIC;
  signal \tx_enable_sync_reg_n_0_[4]\ : STD_LOGIC;
  signal \tx_enable_sync_reg_n_0_[5]\ : STD_LOGIC;
  signal \tx_enable_sync_reg_n_0_[6]\ : STD_LOGIC;
  signal \tx_enable_sync_reg_n_0_[7]\ : STD_LOGIC;
  signal wr_addr_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
begin
\tx_enable_sync_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      CLR => clear,
      D => \tx_enable_sync_reg_n_0_[1]\,
      Q => \tx_enable_sync_reg_n_0_[0]\
    );
\tx_enable_sync_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      CLR => clear,
      D => \tx_enable_sync_reg_n_0_[2]\,
      Q => \tx_enable_sync_reg_n_0_[1]\
    );
\tx_enable_sync_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      CLR => clear,
      D => \tx_enable_sync_reg_n_0_[3]\,
      Q => \tx_enable_sync_reg_n_0_[2]\
    );
\tx_enable_sync_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      CLR => clear,
      D => \tx_enable_sync_reg_n_0_[4]\,
      Q => \tx_enable_sync_reg_n_0_[3]\
    );
\tx_enable_sync_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      CLR => clear,
      D => \tx_enable_sync_reg_n_0_[5]\,
      Q => \tx_enable_sync_reg_n_0_[4]\
    );
\tx_enable_sync_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      CLR => clear,
      D => \tx_enable_sync_reg_n_0_[6]\,
      Q => \tx_enable_sync_reg_n_0_[5]\
    );
\tx_enable_sync_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      CLR => clear,
      D => \tx_enable_sync_reg_n_0_[7]\,
      Q => \tx_enable_sync_reg_n_0_[6]\
    );
\tx_enable_sync_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => tx_clkdiv4,
      CE => '1',
      CLR => clear,
      D => '1',
      Q => \tx_enable_sync_reg_n_0_[7]\
    );
txc_piso: entity work.design_1_lvds_display_tx_0_0_tx_piso_7to1
     port map (
      Q(0) => Q(0),
      RST0 => RST0,
      \bit[0].mem_0\(3 downto 0) => wr_addr_reg(3 downto 0),
      clkout_n => clkout_n,
      clkout_p => clkout_p,
      px_clk => px_clk,
      tx_clkdiv2 => tx_clkdiv2,
      tx_clkdiv4 => tx_clkdiv4,
      \tx_data_reg[0]_0\(0) => \tx_enable_sync_reg_n_0_[0]\
    );
\txd[0].piso\: entity work.design_1_lvds_display_tx_0_0_tx_piso_7to1_0
     port map (
      Q(0) => Q(0),
      RST0 => RST0,
      SR(0) => clear,
      dataout_n(0) => dataout_n(0),
      dataout_p(0) => dataout_p(0),
      \out\(3 downto 0) => wr_addr_reg(3 downto 0),
      px_clk => px_clk,
      px_data(6) => px_data(23),
      px_data(5) => px_data(19),
      px_data(4) => px_data(15),
      px_data(3) => px_data(11),
      px_data(2) => px_data(7),
      px_data(1) => px_data(3),
      px_data(0) => px_data(0),
      tx_clkdiv2 => tx_clkdiv2,
      tx_clkdiv4 => tx_clkdiv4,
      \tx_data_reg[0]_0\(0) => \tx_enable_sync_reg_n_0_[0]\
    );
\txd[1].piso\: entity work.design_1_lvds_display_tx_0_0_tx_piso_7to1_1
     port map (
      Q(0) => Q(0),
      RST0 => RST0,
      dataout_n(0) => dataout_n(1),
      dataout_p(0) => dataout_p(1),
      \out\(3 downto 0) => wr_addr_reg(3 downto 0),
      px_clk => px_clk,
      px_data(6) => px_data(24),
      px_data(5) => px_data(20),
      px_data(4) => px_data(16),
      px_data(3) => px_data(12),
      px_data(2) => px_data(8),
      px_data(1) => px_data(4),
      px_data(0) => px_data(1),
      tx_clkdiv2 => tx_clkdiv2,
      tx_clkdiv4 => tx_clkdiv4,
      \tx_data_reg[0]_0\(0) => \tx_enable_sync_reg_n_0_[0]\
    );
\txd[2].piso\: entity work.design_1_lvds_display_tx_0_0_tx_piso_7to1_2
     port map (
      Q(0) => Q(0),
      RST0 => RST0,
      dataout_n(0) => dataout_n(2),
      dataout_p(0) => dataout_p(2),
      \out\(3 downto 0) => wr_addr_reg(3 downto 0),
      px_clk => px_clk,
      px_data(6) => px_data(25),
      px_data(5) => px_data(21),
      px_data(4) => px_data(17),
      px_data(3) => px_data(13),
      px_data(2) => px_data(9),
      px_data(1) => px_data(5),
      px_data(0) => px_data(2),
      tx_clkdiv2 => tx_clkdiv2,
      tx_clkdiv4 => tx_clkdiv4,
      \tx_data_reg[0]_0\(0) => \tx_enable_sync_reg_n_0_[0]\
    );
\txd[3].piso\: entity work.design_1_lvds_display_tx_0_0_tx_piso_7to1_3
     port map (
      Q(0) => Q(0),
      RST0 => RST0,
      dataout_n(0) => dataout_n(3),
      dataout_p(0) => dataout_p(3),
      \out\(3 downto 0) => wr_addr_reg(3 downto 0),
      px_clk => px_clk,
      px_data(5) => px_data(26),
      px_data(4) => px_data(22),
      px_data(3) => px_data(18),
      px_data(2) => px_data(14),
      px_data(1) => px_data(10),
      px_data(0) => px_data(6),
      tx_clkdiv2 => tx_clkdiv2,
      tx_clkdiv4 => tx_clkdiv4,
      \tx_data_reg[0]_0\(0) => \tx_enable_sync_reg_n_0_[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_lvds_display_tx_0_0_lvds_display_tx is
  port (
    cmt_locked : out STD_LOGIC;
    px_clk : out STD_LOGIC;
    dataout_p : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dataout_n : out STD_LOGIC_VECTOR ( 3 downto 0 );
    clkout_p : out STD_LOGIC;
    clkout_n : out STD_LOGIC;
    ref_clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    vid_io_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    vid_active_video : in STD_LOGIC;
    vid_vsync : in STD_LOGIC;
    vid_hsync : in STD_LOGIC
  );
end design_1_lvds_display_tx_0_0_lvds_display_tx;

architecture STRUCTURE of design_1_lvds_display_tx_0_0_lvds_display_tx is
  signal clkdiv2 : STD_LOGIC;
  signal clkdiv4 : STD_LOGIC;
  signal \^cmt_locked\ : STD_LOGIC;
  signal \^px_clk\ : STD_LOGIC;
  signal px_data : STD_LOGIC_VECTOR ( 27 downto 0 );
  signal \px_locked[3]_i_1_n_0\ : STD_LOGIC;
  signal \px_locked_reg_n_0_[0]\ : STD_LOGIC;
  signal \px_locked_reg_n_0_[1]\ : STD_LOGIC;
  signal \px_locked_reg_n_0_[2]\ : STD_LOGIC;
  signal \px_locked_reg_n_0_[3]\ : STD_LOGIC;
begin
  cmt_locked <= \^cmt_locked\;
  px_clk <= \^px_clk\;
\px_locked[3]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^cmt_locked\,
      O => \px_locked[3]_i_1_n_0\
    );
\px_locked_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => \^px_clk\,
      CE => '1',
      CLR => \px_locked[3]_i_1_n_0\,
      D => \px_locked_reg_n_0_[1]\,
      Q => \px_locked_reg_n_0_[0]\
    );
\px_locked_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => \^px_clk\,
      CE => '1',
      CLR => \px_locked[3]_i_1_n_0\,
      D => \px_locked_reg_n_0_[2]\,
      Q => \px_locked_reg_n_0_[1]\
    );
\px_locked_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => \^px_clk\,
      CE => '1',
      CLR => \px_locked[3]_i_1_n_0\,
      D => \px_locked_reg_n_0_[3]\,
      Q => \px_locked_reg_n_0_[2]\
    );
\px_locked_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => \^px_clk\,
      CE => '1',
      CLR => \px_locked[3]_i_1_n_0\,
      D => '1',
      Q => \px_locked_reg_n_0_[3]\
    );
tx_channel: entity work.design_1_lvds_display_tx_0_0_tx_channel_7to1
     port map (
      Q(0) => \px_locked_reg_n_0_[0]\,
      clkout_n => clkout_n,
      clkout_p => clkout_p,
      dataout_n(3 downto 0) => dataout_n(3 downto 0),
      dataout_p(3 downto 0) => dataout_p(3 downto 0),
      px_clk => \^px_clk\,
      px_data(26 downto 3) => px_data(27 downto 4),
      px_data(2 downto 0) => px_data(2 downto 0),
      tx_clkdiv2 => clkdiv2,
      tx_clkdiv4 => clkdiv4
    );
tx_clkgen: entity work.design_1_lvds_display_tx_0_0_tx_clkgen_7to1
     port map (
      cmt_locked => \^cmt_locked\,
      px_clk => \^px_clk\,
      ref_clk => ref_clk,
      reset => reset,
      tx_clkdiv2 => clkdiv2,
      tx_clkdiv4 => clkdiv4
    );
vid_av_r_reg: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_active_video,
      Q => px_data(2),
      R => '0'
    );
vid_hs_r_reg: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_hsync,
      Q => px_data(10),
      R => '0'
    );
\vid_io_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(0),
      Q => px_data(0),
      R => '0'
    );
\vid_io_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(10),
      Q => px_data(26),
      R => '0'
    );
\vid_io_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(11),
      Q => px_data(22),
      R => '0'
    );
\vid_io_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(12),
      Q => px_data(18),
      R => '0'
    );
\vid_io_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(13),
      Q => px_data(14),
      R => '0'
    );
\vid_io_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(14),
      Q => px_data(11),
      R => '0'
    );
\vid_io_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(15),
      Q => px_data(7),
      R => '0'
    );
\vid_io_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(16),
      Q => px_data(24),
      R => '0'
    );
\vid_io_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(17),
      Q => px_data(20),
      R => '0'
    );
\vid_io_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(18),
      Q => px_data(16),
      R => '0'
    );
\vid_io_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(19),
      Q => px_data(12),
      R => '0'
    );
\vid_io_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(1),
      Q => px_data(25),
      R => '0'
    );
\vid_io_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(20),
      Q => px_data(8),
      R => '0'
    );
\vid_io_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(21),
      Q => px_data(4),
      R => '0'
    );
\vid_io_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(22),
      Q => px_data(27),
      R => '0'
    );
\vid_io_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(23),
      Q => px_data(23),
      R => '0'
    );
\vid_io_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(2),
      Q => px_data(21),
      R => '0'
    );
\vid_io_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(3),
      Q => px_data(17),
      R => '0'
    );
\vid_io_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(4),
      Q => px_data(13),
      R => '0'
    );
\vid_io_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(5),
      Q => px_data(9),
      R => '0'
    );
\vid_io_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(6),
      Q => px_data(19),
      R => '0'
    );
\vid_io_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(7),
      Q => px_data(15),
      R => '0'
    );
\vid_io_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(8),
      Q => px_data(5),
      R => '0'
    );
\vid_io_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_io_in(9),
      Q => px_data(1),
      R => '0'
    );
vid_vs_r_reg: unisim.vcomponents.FDRE
     port map (
      C => ref_clk,
      CE => '1',
      D => vid_vsync,
      Q => px_data(6),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_lvds_display_tx_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_lvds_display_tx_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_lvds_display_tx_0_0 : entity is "design_1_lvds_display_tx_0_0,lvds_display_tx,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_lvds_display_tx_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_lvds_display_tx_0_0 : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_lvds_display_tx_0_0 : entity is "lvds_display_tx,Vivado 2023.1";
end design_1_lvds_display_tx_0_0;

architecture STRUCTURE of design_1_lvds_display_tx_0_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of px_clk : signal is "xilinx.com:signal:clock:1.0 px_clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of px_clk : signal is "XIL_INTERFACENAME px_clk, FREQ_TOLERANCE_HZ -1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_lvds_display_tx_0_0_px_clk, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of ref_clk : signal is "xilinx.com:signal:clock:1.0 ref_clk CLK";
  attribute X_INTERFACE_PARAMETER of ref_clk : signal is "XIL_INTERFACENAME ref_clk, ASSOCIATED_RESET reset, ASSOCIATED_BUSIF vid, FREQ_TOLERANCE_HZ -1, FREQ_HZ 59999401, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk2, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of reset : signal is "xilinx.com:signal:reset:1.0 reset RST";
  attribute X_INTERFACE_PARAMETER of reset : signal is "XIL_INTERFACENAME reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of vid_active_video : signal is "xilinx.com:interface:vid_io:1.0 vid ACTIVE_VIDEO";
  attribute X_INTERFACE_INFO of vid_hsync : signal is "xilinx.com:interface:vid_io:1.0 vid HSYNC";
  attribute X_INTERFACE_INFO of vid_vsync : signal is "xilinx.com:interface:vid_io:1.0 vid VSYNC";
  attribute X_INTERFACE_INFO of vid_io_in : signal is "xilinx.com:interface:vid_io:1.0 vid DATA";
begin
inst: entity work.design_1_lvds_display_tx_0_0_lvds_display_tx
     port map (
      clkout_n => clkout_n,
      clkout_p => clkout_p,
      cmt_locked => cmt_locked,
      dataout_n(3 downto 0) => dataout_n(3 downto 0),
      dataout_p(3 downto 0) => dataout_p(3 downto 0),
      px_clk => px_clk,
      ref_clk => ref_clk,
      reset => reset,
      vid_active_video => vid_active_video,
      vid_hsync => vid_hsync,
      vid_io_in(23 downto 0) => vid_io_in(23 downto 0),
      vid_vsync => vid_vsync
    );
end STRUCTURE;
