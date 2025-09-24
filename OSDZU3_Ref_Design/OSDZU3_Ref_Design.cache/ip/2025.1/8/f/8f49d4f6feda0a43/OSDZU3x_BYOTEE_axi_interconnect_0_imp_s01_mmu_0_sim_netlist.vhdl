-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
-- Date        : Wed Sep 10 17:24:14 2025
-- Host        : e-ubuntu running 64-bit Ubuntu 24.04.3 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_
--               OSDZU3x_BYOTEE_axi_interconnect_0_imp_s01_mmu_0_sim_netlist.vhdl
-- Design      : OSDZU3x_BYOTEE_axi_interconnect_0_imp_s01_mmu_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xczu3eg-sfvc784-1-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_decerr_slave is
  port (
    err_rvalid : out STD_LOGIC;
    err_arready : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \FSM_sequential_gen_read.r_state_reg[0]\ : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    \FSM_sequential_gen_read.r_state_reg[1]\ : out STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    \gen_axilite.gen_read.s_axi_arready_i_reg_0\ : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    \FSM_sequential_gen_read.r_state_reg[0]_0\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    ar_pop0 : in STD_LOGIC;
    \gen_axilite.gen_read.s_axi_rvalid_i_reg_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    \gen_axilite.gen_read.s_axi_rvalid_i_reg_1\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_decerr_slave;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_decerr_slave is
  signal \^fsm_sequential_gen_read.r_state_reg[1]\ : STD_LOGIC;
  signal \^err_arready\ : STD_LOGIC;
  signal \^err_rvalid\ : STD_LOGIC;
  signal \gen_axilite.gen_read.s_axi_rvalid_i_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_axilite.gen_read.s_axi_rvalid_i_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of s_ready_i_i_2 : label is "soft_lutpair0";
begin
  \FSM_sequential_gen_read.r_state_reg[1]\ <= \^fsm_sequential_gen_read.r_state_reg[1]\;
  err_arready <= \^err_arready\;
  err_rvalid <= \^err_rvalid\;
\FSM_sequential_gen_read.r_state[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F08800F0F088FFF0"
    )
        port map (
      I0 => \^err_rvalid\,
      I1 => s_axi_rready,
      I2 => \FSM_sequential_gen_read.r_state_reg[0]_0\,
      I3 => Q(0),
      I4 => Q(1),
      I5 => ar_pop0,
      O => E(0)
    );
\gen_axilite.gen_read.s_axi_arready_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \gen_axilite.gen_read.s_axi_arready_i_reg_0\,
      Q => \^err_arready\,
      R => '0'
    );
\gen_axilite.gen_read.s_axi_rvalid_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444447444444444"
    )
        port map (
      I0 => s_axi_rready,
      I1 => \^err_rvalid\,
      I2 => \^fsm_sequential_gen_read.r_state_reg[1]\,
      I3 => \gen_axilite.gen_read.s_axi_rvalid_i_reg_1\(0),
      I4 => \gen_axilite.gen_read.s_axi_rvalid_i_reg_0\(0),
      I5 => \^err_arready\,
      O => \gen_axilite.gen_read.s_axi_rvalid_i_i_1_n_0\
    );
\gen_axilite.gen_read.s_axi_rvalid_i_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Q(1),
      I1 => Q(0),
      O => \^fsm_sequential_gen_read.r_state_reg[1]\
    );
\gen_axilite.gen_read.s_axi_rvalid_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \gen_axilite.gen_read.s_axi_rvalid_i_i_1_n_0\,
      Q => \^err_rvalid\,
      R => SR(0)
    );
s_axi_rvalid_INST_0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \^err_rvalid\,
      I1 => Q(1),
      I2 => Q(0),
      I3 => m_axi_rvalid,
      O => s_axi_rvalid
    );
s_ready_i_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A5400040"
    )
        port map (
      I0 => Q(0),
      I1 => \^err_arready\,
      I2 => Q(1),
      I3 => \gen_axilite.gen_read.s_axi_rvalid_i_reg_0\(0),
      I4 => m_axi_arready,
      O => \FSM_sequential_gen_read.r_state_reg[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_35_axic_register_slice__parameterized1\ is
  port (
    m_valid_i_reg_inv_0 : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    ar_pop0 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 4 downto 0 );
    \aresetn_d_reg[1]_0\ : out STD_LOGIC;
    \m_payload_i_reg[35]_0\ : out STD_LOGIC_VECTOR ( 35 downto 0 );
    \FSM_sequential_gen_read.r_state_reg[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arvalid : out STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    m_valid_i_reg_inv_1 : out STD_LOGIC;
    aclk : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    \m_payload_i_reg[35]_1\ : in STD_LOGIC_VECTOR ( 34 downto 0 );
    err_arready : in STD_LOGIC;
    \gen_axilite.gen_read.s_axi_arready_i_reg\ : in STD_LOGIC;
    err_rvalid : in STD_LOGIC;
    s_ready_i_reg_0 : in STD_LOGIC;
    m_axi_arvalid_0 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aresetn : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_35_axic_register_slice__parameterized1\ : entity is "axi_register_slice_v2_1_35_axic_register_slice";
end \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_35_axic_register_slice__parameterized1\;

architecture STRUCTURE of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_35_axic_register_slice__parameterized1\ is
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ar_cnt13_out : STD_LOGIC;
  signal ar_pop : STD_LOGIC;
  signal \^ar_pop0\ : STD_LOGIC;
  signal \aresetn_d_reg_n_0_[0]\ : STD_LOGIC;
  signal \aresetn_d_reg_n_0_[1]\ : STD_LOGIC;
  signal \gen_read.ar_cnt[5]_i_4_n_0\ : STD_LOGIC;
  signal \gen_read.ar_cnt[5]_i_6_n_0\ : STD_LOGIC;
  signal \gen_read.read_decoder/p_0_in\ : STD_LOGIC;
  signal \m_payload_i[32]_i_10_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_11_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_12_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_13_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_3_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_4_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_5_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_6_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_7_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_8_n_0\ : STD_LOGIC;
  signal \m_payload_i[32]_i_9_n_0\ : STD_LOGIC;
  signal \^m_payload_i_reg[35]_0\ : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal m_valid_i_inv_i_1_n_0 : STD_LOGIC;
  signal \^m_valid_i_reg_inv_0\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_2_in : STD_LOGIC;
  signal r_match : STD_LOGIC;
  signal s_ready_i_i_1_n_0 : STD_LOGIC;
  signal sr_axi_arready : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_gen_read.r_state[1]_i_3\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_read.ar_cnt[2]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gen_read.ar_cnt[3]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gen_read.ar_cnt[4]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \gen_read.ar_cnt[5]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gen_read.ar_cnt[5]_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \gen_read.ar_cnt[5]_i_5\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gen_read.ar_cnt[5]_i_6\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of m_axi_arvalid_INST_0 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \m_payload_i[32]_i_14\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_payload_i[32]_i_3\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_payload_i[32]_i_4\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_payload_i[32]_i_9\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of m_valid_i_inv_i_1 : label is "soft_lutpair4";
  attribute inverted : string;
  attribute inverted of m_valid_i_reg_inv : label is "yes";
begin
  SR(0) <= \^sr\(0);
  ar_pop0 <= \^ar_pop0\;
  \m_payload_i_reg[35]_0\(35 downto 0) <= \^m_payload_i_reg[35]_0\(35 downto 0);
  m_valid_i_reg_inv_0 <= \^m_valid_i_reg_inv_0\;
\FSM_sequential_gen_read.r_state[1]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \aresetn_d_reg_n_0_[1]\,
      O => \^sr\(0)
    );
\FSM_sequential_gen_read.r_state[1]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2226"
    )
        port map (
      I0 => m_axi_arvalid_0(0),
      I1 => m_axi_arvalid_0(1),
      I2 => \^m_payload_i_reg[35]_0\(32),
      I3 => \^m_valid_i_reg_inv_0\,
      O => \FSM_sequential_gen_read.r_state_reg[0]\(0)
    );
\FSM_sequential_gen_read.r_state[1]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^m_valid_i_reg_inv_0\,
      I1 => \^m_payload_i_reg[35]_0\(32),
      O => m_valid_i_reg_inv_1
    );
\FSM_sequential_gen_read.r_state[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => Q(5),
      I1 => Q(4),
      I2 => Q(1),
      I3 => Q(0),
      I4 => Q(3),
      I5 => Q(2),
      O => \^ar_pop0\
    );
\aresetn_d[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => aresetn,
      O => p_0_in
    );
\aresetn_d_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => '1',
      Q => \aresetn_d_reg_n_0_[0]\,
      R => p_0_in
    );
\aresetn_d_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \aresetn_d_reg_n_0_[0]\,
      Q => \aresetn_d_reg_n_0_[1]\,
      R => p_0_in
    );
\gen_axilite.gen_read.s_axi_arready_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888AAA2AAAA"
    )
        port map (
      I0 => \aresetn_d_reg_n_0_[1]\,
      I1 => err_arready,
      I2 => \^m_payload_i_reg[35]_0\(32),
      I3 => \^m_valid_i_reg_inv_0\,
      I4 => \gen_axilite.gen_read.s_axi_arready_i_reg\,
      I5 => err_rvalid,
      O => \aresetn_d_reg[1]_0\
    );
\gen_read.ar_cnt[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
        port map (
      I0 => Q(0),
      I1 => ar_cnt13_out,
      I2 => Q(1),
      O => D(0)
    );
\gen_read.ar_cnt[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"78E1"
    )
        port map (
      I0 => Q(0),
      I1 => ar_cnt13_out,
      I2 => Q(2),
      I3 => Q(1),
      O => D(1)
    );
\gen_read.ar_cnt[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7F80FE01"
    )
        port map (
      I0 => ar_cnt13_out,
      I1 => Q(0),
      I2 => Q(1),
      I3 => Q(3),
      I4 => Q(2),
      O => D(2)
    );
\gen_read.ar_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF8000FFFE0001"
    )
        port map (
      I0 => Q(1),
      I1 => Q(0),
      I2 => ar_cnt13_out,
      I3 => Q(2),
      I4 => Q(4),
      I5 => Q(3),
      O => D(3)
    );
\gen_read.ar_cnt[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00004000"
    )
        port map (
      I0 => Q(5),
      I1 => s_axi_arvalid,
      I2 => sr_axi_arready,
      I3 => r_match,
      I4 => ar_pop,
      O => ar_cnt13_out
    );
\gen_read.ar_cnt[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => p_2_in,
      I1 => \^ar_pop0\,
      I2 => s_axi_rready,
      I3 => m_axi_rvalid,
      O => s_axi_rready_0(0)
    );
\gen_read.ar_cnt[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF8000FFFE0001"
    )
        port map (
      I0 => Q(2),
      I1 => \gen_read.ar_cnt[5]_i_4_n_0\,
      I2 => Q(1),
      I3 => Q(3),
      I4 => Q(5),
      I5 => Q(4),
      O => D(4)
    );
\gen_read.ar_cnt[5]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => r_match,
      I1 => sr_axi_arready,
      I2 => s_axi_arvalid,
      I3 => Q(5),
      O => p_2_in
    );
\gen_read.ar_cnt[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7555555510000000"
    )
        port map (
      I0 => Q(1),
      I1 => ar_pop,
      I2 => r_match,
      I3 => sr_axi_arready,
      I4 => \gen_read.ar_cnt[5]_i_6_n_0\,
      I5 => Q(0),
      O => \gen_read.ar_cnt[5]_i_4_n_0\
    );
\gen_read.ar_cnt[5]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \^ar_pop0\,
      I1 => s_axi_rready,
      I2 => m_axi_rvalid,
      O => ar_pop
    );
\gen_read.ar_cnt[5]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => Q(5),
      O => \gen_read.ar_cnt[5]_i_6_n_0\
    );
m_axi_arvalid_INST_0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0082"
    )
        port map (
      I0 => \^m_payload_i_reg[35]_0\(32),
      I1 => m_axi_arvalid_0(0),
      I2 => m_axi_arvalid_0(1),
      I3 => \^m_valid_i_reg_inv_0\,
      O => m_axi_arvalid
    );
\m_payload_i[32]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF88A8"
    )
        port map (
      I0 => \m_payload_i[32]_i_2_n_0\,
      I1 => \m_payload_i[32]_i_3_n_0\,
      I2 => \m_payload_i[32]_i_4_n_0\,
      I3 => \m_payload_i[32]_i_5_n_0\,
      I4 => \m_payload_i[32]_i_6_n_0\,
      I5 => \m_payload_i[32]_i_7_n_0\,
      O => r_match
    );
\m_payload_i[32]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \m_payload_i_reg[35]_1\(14),
      I1 => \m_payload_i_reg[35]_1\(13),
      I2 => \m_payload_i_reg[35]_1\(8),
      I3 => \m_payload_i_reg[35]_1\(9),
      O => \m_payload_i[32]_i_10_n_0\
    );
\m_payload_i[32]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \m_payload_i_reg[35]_1\(28),
      I1 => \m_payload_i_reg[35]_1\(31),
      I2 => \m_payload_i_reg[35]_1\(25),
      I3 => \m_payload_i_reg[35]_1\(27),
      O => \m_payload_i[32]_i_11_n_0\
    );
\m_payload_i[32]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \m_payload_i_reg[35]_1\(25),
      I1 => \m_payload_i_reg[35]_1\(26),
      I2 => \m_payload_i_reg[35]_1\(22),
      I3 => \m_payload_i_reg[35]_1\(23),
      O => \m_payload_i[32]_i_12_n_0\
    );
\m_payload_i[32]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFDF"
    )
        port map (
      I0 => \m_payload_i_reg[35]_1\(21),
      I1 => \m_payload_i_reg[35]_1\(16),
      I2 => \m_payload_i_reg[35]_1\(24),
      I3 => \m_payload_i_reg[35]_1\(27),
      O => \m_payload_i[32]_i_13_n_0\
    );
\m_payload_i[32]_i_14\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \m_payload_i_reg[35]_1\(29),
      I1 => \m_payload_i_reg[35]_1\(31),
      I2 => \m_payload_i_reg[35]_1\(30),
      O => \gen_read.read_decoder/p_0_in\
    );
\m_payload_i[32]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \m_payload_i_reg[35]_1\(27),
      I1 => \m_payload_i[32]_i_8_n_0\,
      I2 => \m_payload_i_reg[35]_1\(25),
      I3 => \m_payload_i_reg[35]_1\(26),
      I4 => \m_payload_i_reg[35]_1\(22),
      I5 => \m_payload_i_reg[35]_1\(23),
      O => \m_payload_i[32]_i_2_n_0\
    );
\m_payload_i[32]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => \m_payload_i[32]_i_9_n_0\,
      I1 => \m_payload_i_reg[35]_1\(16),
      I2 => \m_payload_i_reg[35]_1\(21),
      I3 => \m_payload_i_reg[35]_1\(24),
      O => \m_payload_i[32]_i_3_n_0\
    );
\m_payload_i[32]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \m_payload_i[32]_i_9_n_0\,
      I1 => \m_payload_i_reg[35]_1\(21),
      I2 => \m_payload_i_reg[35]_1\(24),
      I3 => \m_payload_i_reg[35]_1\(16),
      O => \m_payload_i[32]_i_4_n_0\
    );
\m_payload_i[32]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFEFFFF"
    )
        port map (
      I0 => \m_payload_i_reg[35]_1\(12),
      I1 => \m_payload_i_reg[35]_1\(15),
      I2 => \m_payload_i_reg[35]_1\(10),
      I3 => \m_payload_i_reg[35]_1\(11),
      I4 => \m_payload_i[32]_i_10_n_0\,
      O => \m_payload_i[32]_i_5_n_0\
    );
\m_payload_i[32]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A000A00CA000A00"
    )
        port map (
      I0 => \m_payload_i_reg[35]_1\(31),
      I1 => \m_payload_i_reg[35]_1\(26),
      I2 => \m_payload_i_reg[35]_1\(29),
      I3 => \m_payload_i_reg[35]_1\(30),
      I4 => \m_payload_i_reg[35]_1\(24),
      I5 => \m_payload_i[32]_i_11_n_0\,
      O => \m_payload_i[32]_i_6_n_0\
    );
\m_payload_i[32]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0001"
    )
        port map (
      I0 => \m_payload_i[32]_i_12_n_0\,
      I1 => \m_payload_i[32]_i_8_n_0\,
      I2 => \m_payload_i[32]_i_9_n_0\,
      I3 => \m_payload_i[32]_i_13_n_0\,
      I4 => \gen_read.read_decoder/p_0_in\,
      O => \m_payload_i[32]_i_7_n_0\
    );
\m_payload_i[32]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \m_payload_i_reg[35]_1\(17),
      I1 => \m_payload_i_reg[35]_1\(19),
      I2 => \m_payload_i_reg[35]_1\(28),
      I3 => \m_payload_i_reg[35]_1\(18),
      O => \m_payload_i[32]_i_8_n_0\
    );
\m_payload_i[32]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEFF"
    )
        port map (
      I0 => \m_payload_i_reg[35]_1\(31),
      I1 => \m_payload_i_reg[35]_1\(20),
      I2 => \m_payload_i_reg[35]_1\(29),
      I3 => \m_payload_i_reg[35]_1\(30),
      O => \m_payload_i[32]_i_9_n_0\
    );
\m_payload_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(0),
      Q => \^m_payload_i_reg[35]_0\(0),
      R => '0'
    );
\m_payload_i_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(10),
      Q => \^m_payload_i_reg[35]_0\(10),
      R => '0'
    );
\m_payload_i_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(11),
      Q => \^m_payload_i_reg[35]_0\(11),
      R => '0'
    );
\m_payload_i_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(12),
      Q => \^m_payload_i_reg[35]_0\(12),
      R => '0'
    );
\m_payload_i_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(13),
      Q => \^m_payload_i_reg[35]_0\(13),
      R => '0'
    );
\m_payload_i_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(14),
      Q => \^m_payload_i_reg[35]_0\(14),
      R => '0'
    );
\m_payload_i_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(15),
      Q => \^m_payload_i_reg[35]_0\(15),
      R => '0'
    );
\m_payload_i_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(16),
      Q => \^m_payload_i_reg[35]_0\(16),
      R => '0'
    );
\m_payload_i_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(17),
      Q => \^m_payload_i_reg[35]_0\(17),
      R => '0'
    );
\m_payload_i_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(18),
      Q => \^m_payload_i_reg[35]_0\(18),
      R => '0'
    );
\m_payload_i_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(19),
      Q => \^m_payload_i_reg[35]_0\(19),
      R => '0'
    );
\m_payload_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(1),
      Q => \^m_payload_i_reg[35]_0\(1),
      R => '0'
    );
\m_payload_i_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(20),
      Q => \^m_payload_i_reg[35]_0\(20),
      R => '0'
    );
\m_payload_i_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(21),
      Q => \^m_payload_i_reg[35]_0\(21),
      R => '0'
    );
\m_payload_i_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(22),
      Q => \^m_payload_i_reg[35]_0\(22),
      R => '0'
    );
\m_payload_i_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(23),
      Q => \^m_payload_i_reg[35]_0\(23),
      R => '0'
    );
\m_payload_i_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(24),
      Q => \^m_payload_i_reg[35]_0\(24),
      R => '0'
    );
\m_payload_i_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(25),
      Q => \^m_payload_i_reg[35]_0\(25),
      R => '0'
    );
\m_payload_i_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(26),
      Q => \^m_payload_i_reg[35]_0\(26),
      R => '0'
    );
\m_payload_i_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(27),
      Q => \^m_payload_i_reg[35]_0\(27),
      R => '0'
    );
\m_payload_i_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(28),
      Q => \^m_payload_i_reg[35]_0\(28),
      R => '0'
    );
\m_payload_i_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(29),
      Q => \^m_payload_i_reg[35]_0\(29),
      R => '0'
    );
\m_payload_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(2),
      Q => \^m_payload_i_reg[35]_0\(2),
      R => '0'
    );
\m_payload_i_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(30),
      Q => \^m_payload_i_reg[35]_0\(30),
      R => '0'
    );
\m_payload_i_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(31),
      Q => \^m_payload_i_reg[35]_0\(31),
      R => '0'
    );
\m_payload_i_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => r_match,
      Q => \^m_payload_i_reg[35]_0\(32),
      R => '0'
    );
\m_payload_i_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(32),
      Q => \^m_payload_i_reg[35]_0\(33),
      R => '0'
    );
\m_payload_i_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(33),
      Q => \^m_payload_i_reg[35]_0\(34),
      R => '0'
    );
\m_payload_i_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(34),
      Q => \^m_payload_i_reg[35]_0\(35),
      R => '0'
    );
\m_payload_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(3),
      Q => \^m_payload_i_reg[35]_0\(3),
      R => '0'
    );
\m_payload_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(4),
      Q => \^m_payload_i_reg[35]_0\(4),
      R => '0'
    );
\m_payload_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(5),
      Q => \^m_payload_i_reg[35]_0\(5),
      R => '0'
    );
\m_payload_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(6),
      Q => \^m_payload_i_reg[35]_0\(6),
      R => '0'
    );
\m_payload_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(7),
      Q => \^m_payload_i_reg[35]_0\(7),
      R => '0'
    );
\m_payload_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(8),
      Q => \^m_payload_i_reg[35]_0\(8),
      R => '0'
    );
\m_payload_i_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^m_valid_i_reg_inv_0\,
      D => \m_payload_i_reg[35]_1\(9),
      Q => \^m_payload_i_reg[35]_0\(9),
      R => '0'
    );
m_valid_i_inv_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DFD0"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => Q(5),
      I2 => sr_axi_arready,
      I3 => s_ready_i_reg_0,
      O => m_valid_i_inv_i_1_n_0
    );
m_valid_i_reg_inv: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => aclk,
      CE => '1',
      D => m_valid_i_inv_i_1_n_0,
      Q => \^m_valid_i_reg_inv_0\,
      S => \^sr\(0)
    );
s_axi_arready_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sr_axi_arready,
      I1 => Q(5),
      O => s_axi_arready
    );
s_ready_i_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA222A2AAA2AAA2"
    )
        port map (
      I0 => \aresetn_d_reg_n_0_[0]\,
      I1 => \aresetn_d_reg_n_0_[1]\,
      I2 => s_ready_i_reg_0,
      I3 => \^m_valid_i_reg_inv_0\,
      I4 => Q(5),
      I5 => s_axi_arvalid,
      O => s_ready_i_i_1_n_0
    );
s_ready_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => s_ready_i_i_1_n_0,
      Q => sr_axi_arready,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_35_axi_register_slice is
  port (
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    ar_pop0 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 4 downto 0 );
    \aresetn_d_reg[1]\ : out STD_LOGIC;
    \m_payload_i_reg[35]\ : out STD_LOGIC_VECTOR ( 35 downto 0 );
    \FSM_sequential_gen_read.r_state_reg[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arvalid : out STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    m_valid_i_reg_inv : out STD_LOGIC;
    aclk : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    err_arready : in STD_LOGIC;
    \gen_axilite.gen_read.s_axi_arready_i_reg\ : in STD_LOGIC;
    err_rvalid : in STD_LOGIC;
    s_ready_i_reg : in STD_LOGIC;
    m_axi_arvalid_0 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aresetn : in STD_LOGIC;
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_35_axi_register_slice;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_35_axi_register_slice is
begin
\ar.ar_pipe\: entity work.\decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_35_axic_register_slice__parameterized1\
     port map (
      D(4 downto 0) => D(4 downto 0),
      \FSM_sequential_gen_read.r_state_reg[0]\(0) => \FSM_sequential_gen_read.r_state_reg[0]\(0),
      Q(5 downto 0) => Q(5 downto 0),
      SR(0) => SR(0),
      aclk => aclk,
      ar_pop0 => ar_pop0,
      aresetn => aresetn,
      \aresetn_d_reg[1]_0\ => \aresetn_d_reg[1]\,
      err_arready => err_arready,
      err_rvalid => err_rvalid,
      \gen_axilite.gen_read.s_axi_arready_i_reg\ => \gen_axilite.gen_read.s_axi_arready_i_reg\,
      m_axi_arvalid => m_axi_arvalid,
      m_axi_arvalid_0(1 downto 0) => m_axi_arvalid_0(1 downto 0),
      m_axi_rvalid => m_axi_rvalid,
      \m_payload_i_reg[35]_0\(35 downto 0) => \m_payload_i_reg[35]\(35 downto 0),
      \m_payload_i_reg[35]_1\(34 downto 32) => s_axi_arprot(2 downto 0),
      \m_payload_i_reg[35]_1\(31 downto 0) => s_axi_araddr(31 downto 0),
      m_valid_i_reg_inv_0 => E(0),
      m_valid_i_reg_inv_1 => m_valid_i_reg_inv,
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_rready => s_axi_rready,
      s_axi_rready_0(0) => s_axi_rready_0(0),
      s_ready_i_reg_0 => s_ready_i_reg
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_buser : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_aruser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_ruser : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_wuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_buser : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_arid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_aruser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_ruser : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  attribute C_AXI_ARUSER_WIDTH : integer;
  attribute C_AXI_ARUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 1;
  attribute C_AXI_AWUSER_WIDTH : integer;
  attribute C_AXI_AWUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 1;
  attribute C_AXI_BUSER_WIDTH : integer;
  attribute C_AXI_BUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 1;
  attribute C_AXI_DATA_WIDTH : integer;
  attribute C_AXI_DATA_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 32;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 1;
  attribute C_AXI_PROTOCOL : integer;
  attribute C_AXI_PROTOCOL of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 2;
  attribute C_AXI_RUSER_WIDTH : integer;
  attribute C_AXI_RUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 1;
  attribute C_AXI_SUPPORTS_USER_SIGNALS : integer;
  attribute C_AXI_SUPPORTS_USER_SIGNALS of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 0;
  attribute C_AXI_WUSER_WIDTH : integer;
  attribute C_AXI_WUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 1;
  attribute C_BASE_ADDR : string;
  attribute C_BASE_ADDR of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "384'b000000000000000000000000000000001111111100000000000000000000000000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000001100000000000000000000000000000000000000000000000000000000000000100000100100000000000000000000000000000000000000000000000000000010000000000000100000000000000000000000000000000000000000000000001000000000000000000000000000000";
  attribute C_DEST : string;
  attribute C_DEST of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "6'b000000";
  attribute C_DEST_WIDTH : integer;
  attribute C_DEST_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "zynquplus";
  attribute C_M_AXI_ADDR_WIDTH : integer;
  attribute C_M_AXI_ADDR_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 32;
  attribute C_M_AXI_SUPPORTS_READ : string;
  attribute C_M_AXI_SUPPORTS_READ of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "6'b111111";
  attribute C_M_AXI_SUPPORTS_WRITE : string;
  attribute C_M_AXI_SUPPORTS_WRITE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "6'b111111";
  attribute C_NUM_RANGES : integer;
  attribute C_NUM_RANGES of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 6;
  attribute C_PREFIX : string;
  attribute C_PREFIX of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "6'b000000";
  attribute C_PREFIX_WIDTH : integer;
  attribute C_PREFIX_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 1;
  attribute C_RANGE_SIZE : string;
  attribute C_RANGE_SIZE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "192'b000000000000000000000000000110000000000000000000000000000001110100000000000000000000000000011101000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000001000";
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 32;
  attribute C_S_AXI_SUPPORTS_READ : integer;
  attribute C_S_AXI_SUPPORTS_READ of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 1;
  attribute C_S_AXI_SUPPORTS_WRITE : integer;
  attribute C_S_AXI_SUPPORTS_WRITE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 0;
  attribute C_USES_DEST : integer;
  attribute C_USES_DEST of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 0;
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "yes";
  attribute P_AXI3 : integer;
  attribute P_AXI3 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 1;
  attribute P_AXI4 : integer;
  attribute P_AXI4 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 0;
  attribute P_AXILITE : integer;
  attribute P_AXILITE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 2;
  attribute P_DECERR : string;
  attribute P_DECERR of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "2'b11";
  attribute P_NUM_RANGES_LOG : integer;
  attribute P_NUM_RANGES_LOG of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is 3;
  attribute R_DECERR : string;
  attribute R_DECERR of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "2'b11";
  attribute R_IDLE : string;
  attribute R_IDLE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "2'b00";
  attribute R_PENDING : string;
  attribute R_PENDING of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "2'b01";
  attribute W_DECERR : string;
  attribute W_DECERR of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "2'b11";
  attribute W_IDLE : string;
  attribute W_IDLE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "2'b00";
  attribute W_PENDING : string;
  attribute W_PENDING of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top : entity is "2'b01";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top is
  signal \<const0>\ : STD_LOGIC;
  signal ar_pop0 : STD_LOGIC;
  signal decerr_slave_inst_n_2 : STD_LOGIC;
  signal decerr_slave_inst_n_3 : STD_LOGIC;
  signal decerr_slave_inst_n_5 : STD_LOGIC;
  signal err_arready : STD_LOGIC;
  signal err_rvalid : STD_LOGIC;
  signal \gen_read.ar_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_read.ar_cnt_reg\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal mr_axi_araddr : STD_LOGIC_VECTOR ( 32 to 32 );
  signal mr_axi_arvalid : STD_LOGIC;
  signal r_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \r_state__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal register_slice_inst_n_1 : STD_LOGIC;
  signal register_slice_inst_n_2 : STD_LOGIC;
  signal register_slice_inst_n_4 : STD_LOGIC;
  signal register_slice_inst_n_49 : STD_LOGIC;
  signal register_slice_inst_n_5 : STD_LOGIC;
  signal register_slice_inst_n_6 : STD_LOGIC;
  signal register_slice_inst_n_7 : STD_LOGIC;
  signal register_slice_inst_n_8 : STD_LOGIC;
  signal register_slice_inst_n_9 : STD_LOGIC;
  signal \^s_axi_rready\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_gen_read.r_state[0]_i_1\ : label is "soft_lutpair8";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_gen_read.r_state_reg[0]\ : label is "R_PENDING:01,iSTATE:00,R_DECERR:10";
  attribute FSM_ENCODED_STATES of \FSM_sequential_gen_read.r_state_reg[1]\ : label is "R_PENDING:01,iSTATE:00,R_DECERR:10";
  attribute SOFT_HLUTNM of \s_axi_rdata[0]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \s_axi_rdata[10]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \s_axi_rdata[11]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \s_axi_rdata[12]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \s_axi_rdata[13]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \s_axi_rdata[14]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \s_axi_rdata[15]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \s_axi_rdata[16]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \s_axi_rdata[17]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \s_axi_rdata[18]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \s_axi_rdata[19]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \s_axi_rdata[1]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \s_axi_rdata[20]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \s_axi_rdata[21]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \s_axi_rdata[22]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \s_axi_rdata[23]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \s_axi_rdata[24]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \s_axi_rdata[25]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \s_axi_rdata[26]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \s_axi_rdata[27]_INST_0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \s_axi_rdata[28]_INST_0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \s_axi_rdata[29]_INST_0\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \s_axi_rdata[2]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \s_axi_rdata[30]_INST_0\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \s_axi_rdata[3]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \s_axi_rdata[4]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \s_axi_rdata[5]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \s_axi_rdata[6]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \s_axi_rdata[7]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \s_axi_rdata[8]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \s_axi_rdata[9]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \s_axi_rresp[0]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \s_axi_rresp[1]_INST_0\ : label is "soft_lutpair9";
begin
  \^s_axi_rready\ <= s_axi_rready;
  m_axi_arburst(1) <= \<const0>\;
  m_axi_arburst(0) <= \<const0>\;
  m_axi_arcache(3) <= \<const0>\;
  m_axi_arcache(2) <= \<const0>\;
  m_axi_arcache(1) <= \<const0>\;
  m_axi_arcache(0) <= \<const0>\;
  m_axi_arid(0) <= \<const0>\;
  m_axi_arlen(7) <= \<const0>\;
  m_axi_arlen(6) <= \<const0>\;
  m_axi_arlen(5) <= \<const0>\;
  m_axi_arlen(4) <= \<const0>\;
  m_axi_arlen(3) <= \<const0>\;
  m_axi_arlen(2) <= \<const0>\;
  m_axi_arlen(1) <= \<const0>\;
  m_axi_arlen(0) <= \<const0>\;
  m_axi_arlock(0) <= \<const0>\;
  m_axi_arqos(3) <= \<const0>\;
  m_axi_arqos(2) <= \<const0>\;
  m_axi_arqos(1) <= \<const0>\;
  m_axi_arqos(0) <= \<const0>\;
  m_axi_arsize(2) <= \<const0>\;
  m_axi_arsize(1) <= \<const0>\;
  m_axi_arsize(0) <= \<const0>\;
  m_axi_aruser(0) <= \<const0>\;
  m_axi_awaddr(31) <= \<const0>\;
  m_axi_awaddr(30) <= \<const0>\;
  m_axi_awaddr(29) <= \<const0>\;
  m_axi_awaddr(28) <= \<const0>\;
  m_axi_awaddr(27) <= \<const0>\;
  m_axi_awaddr(26) <= \<const0>\;
  m_axi_awaddr(25) <= \<const0>\;
  m_axi_awaddr(24) <= \<const0>\;
  m_axi_awaddr(23) <= \<const0>\;
  m_axi_awaddr(22) <= \<const0>\;
  m_axi_awaddr(21) <= \<const0>\;
  m_axi_awaddr(20) <= \<const0>\;
  m_axi_awaddr(19) <= \<const0>\;
  m_axi_awaddr(18) <= \<const0>\;
  m_axi_awaddr(17) <= \<const0>\;
  m_axi_awaddr(16) <= \<const0>\;
  m_axi_awaddr(15) <= \<const0>\;
  m_axi_awaddr(14) <= \<const0>\;
  m_axi_awaddr(13) <= \<const0>\;
  m_axi_awaddr(12) <= \<const0>\;
  m_axi_awaddr(11) <= \<const0>\;
  m_axi_awaddr(10) <= \<const0>\;
  m_axi_awaddr(9) <= \<const0>\;
  m_axi_awaddr(8) <= \<const0>\;
  m_axi_awaddr(7) <= \<const0>\;
  m_axi_awaddr(6) <= \<const0>\;
  m_axi_awaddr(5) <= \<const0>\;
  m_axi_awaddr(4) <= \<const0>\;
  m_axi_awaddr(3) <= \<const0>\;
  m_axi_awaddr(2) <= \<const0>\;
  m_axi_awaddr(1) <= \<const0>\;
  m_axi_awaddr(0) <= \<const0>\;
  m_axi_awburst(1) <= \<const0>\;
  m_axi_awburst(0) <= \<const0>\;
  m_axi_awcache(3) <= \<const0>\;
  m_axi_awcache(2) <= \<const0>\;
  m_axi_awcache(1) <= \<const0>\;
  m_axi_awcache(0) <= \<const0>\;
  m_axi_awid(0) <= \<const0>\;
  m_axi_awlen(7) <= \<const0>\;
  m_axi_awlen(6) <= \<const0>\;
  m_axi_awlen(5) <= \<const0>\;
  m_axi_awlen(4) <= \<const0>\;
  m_axi_awlen(3) <= \<const0>\;
  m_axi_awlen(2) <= \<const0>\;
  m_axi_awlen(1) <= \<const0>\;
  m_axi_awlen(0) <= \<const0>\;
  m_axi_awlock(0) <= \<const0>\;
  m_axi_awprot(2) <= \<const0>\;
  m_axi_awprot(1) <= \<const0>\;
  m_axi_awprot(0) <= \<const0>\;
  m_axi_awqos(3) <= \<const0>\;
  m_axi_awqos(2) <= \<const0>\;
  m_axi_awqos(1) <= \<const0>\;
  m_axi_awqos(0) <= \<const0>\;
  m_axi_awsize(2) <= \<const0>\;
  m_axi_awsize(1) <= \<const0>\;
  m_axi_awsize(0) <= \<const0>\;
  m_axi_awuser(0) <= \<const0>\;
  m_axi_awvalid <= \<const0>\;
  m_axi_bready <= \<const0>\;
  m_axi_rready <= \^s_axi_rready\;
  m_axi_wdata(31) <= \<const0>\;
  m_axi_wdata(30) <= \<const0>\;
  m_axi_wdata(29) <= \<const0>\;
  m_axi_wdata(28) <= \<const0>\;
  m_axi_wdata(27) <= \<const0>\;
  m_axi_wdata(26) <= \<const0>\;
  m_axi_wdata(25) <= \<const0>\;
  m_axi_wdata(24) <= \<const0>\;
  m_axi_wdata(23) <= \<const0>\;
  m_axi_wdata(22) <= \<const0>\;
  m_axi_wdata(21) <= \<const0>\;
  m_axi_wdata(20) <= \<const0>\;
  m_axi_wdata(19) <= \<const0>\;
  m_axi_wdata(18) <= \<const0>\;
  m_axi_wdata(17) <= \<const0>\;
  m_axi_wdata(16) <= \<const0>\;
  m_axi_wdata(15) <= \<const0>\;
  m_axi_wdata(14) <= \<const0>\;
  m_axi_wdata(13) <= \<const0>\;
  m_axi_wdata(12) <= \<const0>\;
  m_axi_wdata(11) <= \<const0>\;
  m_axi_wdata(10) <= \<const0>\;
  m_axi_wdata(9) <= \<const0>\;
  m_axi_wdata(8) <= \<const0>\;
  m_axi_wdata(7) <= \<const0>\;
  m_axi_wdata(6) <= \<const0>\;
  m_axi_wdata(5) <= \<const0>\;
  m_axi_wdata(4) <= \<const0>\;
  m_axi_wdata(3) <= \<const0>\;
  m_axi_wdata(2) <= \<const0>\;
  m_axi_wdata(1) <= \<const0>\;
  m_axi_wdata(0) <= \<const0>\;
  m_axi_wid(0) <= \<const0>\;
  m_axi_wlast <= \<const0>\;
  m_axi_wstrb(3) <= \<const0>\;
  m_axi_wstrb(2) <= \<const0>\;
  m_axi_wstrb(1) <= \<const0>\;
  m_axi_wstrb(0) <= \<const0>\;
  m_axi_wuser(0) <= \<const0>\;
  m_axi_wvalid <= \<const0>\;
  s_axi_awready <= \<const0>\;
  s_axi_bid(0) <= \<const0>\;
  s_axi_bresp(1) <= \<const0>\;
  s_axi_bresp(0) <= \<const0>\;
  s_axi_buser(0) <= \<const0>\;
  s_axi_bvalid <= \<const0>\;
  s_axi_rid(0) <= \<const0>\;
  s_axi_rlast <= \<const0>\;
  s_axi_ruser(0) <= \<const0>\;
  s_axi_wready <= \<const0>\;
\FSM_sequential_gen_read.r_state[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => r_state(0),
      I1 => r_state(1),
      O => \r_state__0\(0)
    );
\FSM_sequential_gen_read.r_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => decerr_slave_inst_n_2,
      D => \r_state__0\(0),
      Q => r_state(0),
      R => register_slice_inst_n_1
    );
\FSM_sequential_gen_read.r_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => decerr_slave_inst_n_2,
      D => \r_state__0\(1),
      Q => r_state(1),
      R => register_slice_inst_n_1
    );
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
decerr_slave_inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_decerr_slave
     port map (
      E(0) => decerr_slave_inst_n_2,
      \FSM_sequential_gen_read.r_state_reg[0]\ => decerr_slave_inst_n_3,
      \FSM_sequential_gen_read.r_state_reg[0]_0\ => register_slice_inst_n_49,
      \FSM_sequential_gen_read.r_state_reg[1]\ => decerr_slave_inst_n_5,
      Q(1 downto 0) => r_state(1 downto 0),
      SR(0) => register_slice_inst_n_1,
      aclk => aclk,
      ar_pop0 => ar_pop0,
      err_arready => err_arready,
      err_rvalid => err_rvalid,
      \gen_axilite.gen_read.s_axi_arready_i_reg_0\ => register_slice_inst_n_9,
      \gen_axilite.gen_read.s_axi_rvalid_i_reg_0\(0) => mr_axi_araddr(32),
      \gen_axilite.gen_read.s_axi_rvalid_i_reg_1\(0) => mr_axi_arvalid,
      m_axi_arready => m_axi_arready,
      m_axi_rvalid => m_axi_rvalid,
      s_axi_rready => \^s_axi_rready\,
      s_axi_rvalid => s_axi_rvalid
    );
\gen_read.ar_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gen_read.ar_cnt_reg\(0),
      O => \gen_read.ar_cnt[0]_i_1_n_0\
    );
\gen_read.ar_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => register_slice_inst_n_2,
      D => \gen_read.ar_cnt[0]_i_1_n_0\,
      Q => \gen_read.ar_cnt_reg\(0),
      R => register_slice_inst_n_1
    );
\gen_read.ar_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => register_slice_inst_n_2,
      D => register_slice_inst_n_8,
      Q => \gen_read.ar_cnt_reg\(1),
      R => register_slice_inst_n_1
    );
\gen_read.ar_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => register_slice_inst_n_2,
      D => register_slice_inst_n_7,
      Q => \gen_read.ar_cnt_reg\(2),
      R => register_slice_inst_n_1
    );
\gen_read.ar_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => register_slice_inst_n_2,
      D => register_slice_inst_n_6,
      Q => \gen_read.ar_cnt_reg\(3),
      R => register_slice_inst_n_1
    );
\gen_read.ar_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => register_slice_inst_n_2,
      D => register_slice_inst_n_5,
      Q => \gen_read.ar_cnt_reg\(4),
      R => register_slice_inst_n_1
    );
\gen_read.ar_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => register_slice_inst_n_2,
      D => register_slice_inst_n_4,
      Q => \gen_read.ar_cnt_reg\(5),
      R => register_slice_inst_n_1
    );
register_slice_inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_35_axi_register_slice
     port map (
      D(4) => register_slice_inst_n_4,
      D(3) => register_slice_inst_n_5,
      D(2) => register_slice_inst_n_6,
      D(1) => register_slice_inst_n_7,
      D(0) => register_slice_inst_n_8,
      E(0) => mr_axi_arvalid,
      \FSM_sequential_gen_read.r_state_reg[0]\(0) => \r_state__0\(1),
      Q(5 downto 0) => \gen_read.ar_cnt_reg\(5 downto 0),
      SR(0) => register_slice_inst_n_1,
      aclk => aclk,
      ar_pop0 => ar_pop0,
      aresetn => aresetn,
      \aresetn_d_reg[1]\ => register_slice_inst_n_9,
      err_arready => err_arready,
      err_rvalid => err_rvalid,
      \gen_axilite.gen_read.s_axi_arready_i_reg\ => decerr_slave_inst_n_5,
      m_axi_arvalid => m_axi_arvalid,
      m_axi_arvalid_0(1 downto 0) => r_state(1 downto 0),
      m_axi_rvalid => m_axi_rvalid,
      \m_payload_i_reg[35]\(35 downto 33) => m_axi_arprot(2 downto 0),
      \m_payload_i_reg[35]\(32) => mr_axi_araddr(32),
      \m_payload_i_reg[35]\(31 downto 0) => m_axi_araddr(31 downto 0),
      m_valid_i_reg_inv => register_slice_inst_n_49,
      s_axi_araddr(31 downto 0) => s_axi_araddr(31 downto 0),
      s_axi_arprot(2 downto 0) => s_axi_arprot(2 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_rready => \^s_axi_rready\,
      s_axi_rready_0(0) => register_slice_inst_n_2,
      s_ready_i_reg => decerr_slave_inst_n_3
    );
\s_axi_rdata[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(0),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(0)
    );
\s_axi_rdata[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(10),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(10)
    );
\s_axi_rdata[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(11),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(11)
    );
\s_axi_rdata[12]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(12),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(12)
    );
\s_axi_rdata[13]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(13),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(13)
    );
\s_axi_rdata[14]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(14),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(14)
    );
\s_axi_rdata[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(15),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(15)
    );
\s_axi_rdata[16]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(16),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(16)
    );
\s_axi_rdata[17]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(17),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(17)
    );
\s_axi_rdata[18]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(18),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(18)
    );
\s_axi_rdata[19]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(19),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(19)
    );
\s_axi_rdata[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(1),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(1)
    );
\s_axi_rdata[20]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(20),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(20)
    );
\s_axi_rdata[21]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(21),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(21)
    );
\s_axi_rdata[22]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(22),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(22)
    );
\s_axi_rdata[23]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(23),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(23)
    );
\s_axi_rdata[24]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(24),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(24)
    );
\s_axi_rdata[25]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(25),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(25)
    );
\s_axi_rdata[26]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(26),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(26)
    );
\s_axi_rdata[27]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(27),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(27)
    );
\s_axi_rdata[28]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(28),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(28)
    );
\s_axi_rdata[29]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(29),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(29)
    );
\s_axi_rdata[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(2),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(2)
    );
\s_axi_rdata[30]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(30),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(30)
    );
\s_axi_rdata[31]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(31),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(31)
    );
\s_axi_rdata[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(3),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(3)
    );
\s_axi_rdata[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(4),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(4)
    );
\s_axi_rdata[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(5),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(5)
    );
\s_axi_rdata[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(6),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(6)
    );
\s_axi_rdata[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(7),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(7)
    );
\s_axi_rdata[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(8),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(8)
    );
\s_axi_rdata[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_axi_rdata(9),
      I1 => r_state(0),
      I2 => r_state(1),
      O => s_axi_rdata(9)
    );
\s_axi_rresp[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F2"
    )
        port map (
      I0 => r_state(1),
      I1 => r_state(0),
      I2 => m_axi_rresp(0),
      O => s_axi_rresp(0)
    );
\s_axi_rresp[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F2"
    )
        port map (
      I0 => r_state(1),
      I1 => r_state(0),
      I2 => m_axi_rresp(1),
      O => s_axi_rresp(1)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "OSDZU3x_BYOTEE_axi_interconnect_0_imp_s01_mmu_0,axi_mmu_v2_1_33_top,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "axi_mmu_v2_1_33_top,Vivado 2025.1";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal NLW_inst_m_axi_awvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_bready_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_wlast_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_wvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_s_axi_awready_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_s_axi_bvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_s_axi_rlast_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_s_axi_wready_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_arburst_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_arcache_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_arid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_arlen_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_inst_m_axi_arlock_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_arqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_arsize_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_aruser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_awaddr_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_inst_m_axi_awburst_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_awcache_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_awid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_awlen_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_inst_m_axi_awlock_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_awqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_awsize_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_awuser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_wdata_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_inst_m_axi_wid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_wstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_wuser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_s_axi_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_s_axi_bresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_s_axi_buser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_s_axi_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_s_axi_ruser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute C_AXI_ARUSER_WIDTH : integer;
  attribute C_AXI_ARUSER_WIDTH of inst : label is 1;
  attribute C_AXI_AWUSER_WIDTH : integer;
  attribute C_AXI_AWUSER_WIDTH of inst : label is 1;
  attribute C_AXI_BUSER_WIDTH : integer;
  attribute C_AXI_BUSER_WIDTH of inst : label is 1;
  attribute C_AXI_DATA_WIDTH : integer;
  attribute C_AXI_DATA_WIDTH of inst : label is 32;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of inst : label is 1;
  attribute C_AXI_PROTOCOL : integer;
  attribute C_AXI_PROTOCOL of inst : label is 2;
  attribute C_AXI_RUSER_WIDTH : integer;
  attribute C_AXI_RUSER_WIDTH of inst : label is 1;
  attribute C_AXI_SUPPORTS_USER_SIGNALS : integer;
  attribute C_AXI_SUPPORTS_USER_SIGNALS of inst : label is 0;
  attribute C_AXI_WUSER_WIDTH : integer;
  attribute C_AXI_WUSER_WIDTH of inst : label is 1;
  attribute C_BASE_ADDR : string;
  attribute C_BASE_ADDR of inst : label is "384'b000000000000000000000000000000001111111100000000000000000000000000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000001100000000000000000000000000000000000000000000000000000000000000100000100100000000000000000000000000000000000000000000000000000010000000000000100000000000000000000000000000000000000000000000001000000000000000000000000000000";
  attribute C_DEST : string;
  attribute C_DEST of inst : label is "6'b000000";
  attribute C_DEST_WIDTH : integer;
  attribute C_DEST_WIDTH of inst : label is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "zynquplus";
  attribute C_M_AXI_ADDR_WIDTH : integer;
  attribute C_M_AXI_ADDR_WIDTH of inst : label is 32;
  attribute C_M_AXI_SUPPORTS_READ : string;
  attribute C_M_AXI_SUPPORTS_READ of inst : label is "6'b111111";
  attribute C_M_AXI_SUPPORTS_WRITE : string;
  attribute C_M_AXI_SUPPORTS_WRITE of inst : label is "6'b111111";
  attribute C_NUM_RANGES : integer;
  attribute C_NUM_RANGES of inst : label is 6;
  attribute C_PREFIX : string;
  attribute C_PREFIX of inst : label is "6'b000000";
  attribute C_PREFIX_WIDTH : integer;
  attribute C_PREFIX_WIDTH of inst : label is 1;
  attribute C_RANGE_SIZE : string;
  attribute C_RANGE_SIZE of inst : label is "192'b000000000000000000000000000110000000000000000000000000000001110100000000000000000000000000011101000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000001000";
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of inst : label is 32;
  attribute C_S_AXI_SUPPORTS_READ : integer;
  attribute C_S_AXI_SUPPORTS_READ of inst : label is 1;
  attribute C_S_AXI_SUPPORTS_WRITE : integer;
  attribute C_S_AXI_SUPPORTS_WRITE of inst : label is 0;
  attribute C_USES_DEST : integer;
  attribute C_USES_DEST of inst : label is 0;
  attribute DowngradeIPIdentifiedWarnings of inst : label is "yes";
  attribute P_AXI3 : integer;
  attribute P_AXI3 of inst : label is 1;
  attribute P_AXI4 : integer;
  attribute P_AXI4 of inst : label is 0;
  attribute P_AXILITE : integer;
  attribute P_AXILITE of inst : label is 2;
  attribute P_DECERR : string;
  attribute P_DECERR of inst : label is "2'b11";
  attribute P_NUM_RANGES_LOG : integer;
  attribute P_NUM_RANGES_LOG of inst : label is 3;
  attribute R_DECERR : string;
  attribute R_DECERR of inst : label is "2'b11";
  attribute R_IDLE : string;
  attribute R_IDLE of inst : label is "2'b00";
  attribute R_PENDING : string;
  attribute R_PENDING of inst : label is "2'b01";
  attribute W_DECERR : string;
  attribute W_DECERR of inst : label is "2'b11";
  attribute W_IDLE : string;
  attribute W_IDLE of inst : label is "2'b00";
  attribute W_PENDING : string;
  attribute W_PENDING of inst : label is "2'b01";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of aclk : signal is "xilinx.com:signal:clock:1.0 CLK CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of aclk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of aclk : signal is "XIL_INTERFACENAME CLK, ASSOCIATED_BUSIF S_AXI:M_AXI, ASSOCIATED_RESET aresetn, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1_pl_clk0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of aresetn : signal is "xilinx.com:signal:reset:1.0 RST RST";
  attribute X_INTERFACE_MODE of aresetn : signal is "slave";
  attribute X_INTERFACE_PARAMETER of aresetn : signal is "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0, TYPE INTERCONNECT";
  attribute X_INTERFACE_INFO of m_axi_arready : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARREADY";
  attribute X_INTERFACE_INFO of m_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARVALID";
  attribute X_INTERFACE_INFO of m_axi_rready : signal is "xilinx.com:interface:aximm:1.0 M_AXI RREADY";
  attribute X_INTERFACE_INFO of m_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 M_AXI RVALID";
  attribute X_INTERFACE_INFO of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARREADY";
  attribute X_INTERFACE_INFO of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARVALID";
  attribute X_INTERFACE_INFO of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 S_AXI RREADY";
  attribute X_INTERFACE_INFO of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI RVALID";
  attribute X_INTERFACE_INFO of m_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARADDR";
  attribute X_INTERFACE_MODE of m_axi_araddr : signal is "master";
  attribute X_INTERFACE_PARAMETER of m_axi_araddr : signal is "XIL_INTERFACENAME M_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 99999001, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 0, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARPROT";
  attribute X_INTERFACE_INFO of m_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 M_AXI RDATA";
  attribute X_INTERFACE_INFO of m_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 M_AXI RRESP";
  attribute X_INTERFACE_INFO of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARADDR";
  attribute X_INTERFACE_MODE of s_axi_araddr : signal is "slave";
  attribute X_INTERFACE_PARAMETER of s_axi_araddr : signal is "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 99999001, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 0, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARPROT";
  attribute X_INTERFACE_INFO of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 S_AXI RDATA";
  attribute X_INTERFACE_INFO of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 S_AXI RRESP";
begin
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_mmu_v2_1_33_top
     port map (
      aclk => aclk,
      aresetn => aresetn,
      m_axi_araddr(31 downto 0) => m_axi_araddr(31 downto 0),
      m_axi_arburst(1 downto 0) => NLW_inst_m_axi_arburst_UNCONNECTED(1 downto 0),
      m_axi_arcache(3 downto 0) => NLW_inst_m_axi_arcache_UNCONNECTED(3 downto 0),
      m_axi_arid(0) => NLW_inst_m_axi_arid_UNCONNECTED(0),
      m_axi_arlen(7 downto 0) => NLW_inst_m_axi_arlen_UNCONNECTED(7 downto 0),
      m_axi_arlock(0) => NLW_inst_m_axi_arlock_UNCONNECTED(0),
      m_axi_arprot(2 downto 0) => m_axi_arprot(2 downto 0),
      m_axi_arqos(3 downto 0) => NLW_inst_m_axi_arqos_UNCONNECTED(3 downto 0),
      m_axi_arready => m_axi_arready,
      m_axi_arsize(2 downto 0) => NLW_inst_m_axi_arsize_UNCONNECTED(2 downto 0),
      m_axi_aruser(0) => NLW_inst_m_axi_aruser_UNCONNECTED(0),
      m_axi_arvalid => m_axi_arvalid,
      m_axi_awaddr(31 downto 0) => NLW_inst_m_axi_awaddr_UNCONNECTED(31 downto 0),
      m_axi_awburst(1 downto 0) => NLW_inst_m_axi_awburst_UNCONNECTED(1 downto 0),
      m_axi_awcache(3 downto 0) => NLW_inst_m_axi_awcache_UNCONNECTED(3 downto 0),
      m_axi_awid(0) => NLW_inst_m_axi_awid_UNCONNECTED(0),
      m_axi_awlen(7 downto 0) => NLW_inst_m_axi_awlen_UNCONNECTED(7 downto 0),
      m_axi_awlock(0) => NLW_inst_m_axi_awlock_UNCONNECTED(0),
      m_axi_awprot(2 downto 0) => NLW_inst_m_axi_awprot_UNCONNECTED(2 downto 0),
      m_axi_awqos(3 downto 0) => NLW_inst_m_axi_awqos_UNCONNECTED(3 downto 0),
      m_axi_awready => '0',
      m_axi_awsize(2 downto 0) => NLW_inst_m_axi_awsize_UNCONNECTED(2 downto 0),
      m_axi_awuser(0) => NLW_inst_m_axi_awuser_UNCONNECTED(0),
      m_axi_awvalid => NLW_inst_m_axi_awvalid_UNCONNECTED,
      m_axi_bid(0) => '0',
      m_axi_bready => NLW_inst_m_axi_bready_UNCONNECTED,
      m_axi_bresp(1 downto 0) => B"00",
      m_axi_buser(0) => '0',
      m_axi_bvalid => '0',
      m_axi_rdata(31 downto 0) => m_axi_rdata(31 downto 0),
      m_axi_rid(0) => '0',
      m_axi_rlast => '1',
      m_axi_rready => m_axi_rready,
      m_axi_rresp(1 downto 0) => m_axi_rresp(1 downto 0),
      m_axi_ruser(0) => '0',
      m_axi_rvalid => m_axi_rvalid,
      m_axi_wdata(31 downto 0) => NLW_inst_m_axi_wdata_UNCONNECTED(31 downto 0),
      m_axi_wid(0) => NLW_inst_m_axi_wid_UNCONNECTED(0),
      m_axi_wlast => NLW_inst_m_axi_wlast_UNCONNECTED,
      m_axi_wready => '0',
      m_axi_wstrb(3 downto 0) => NLW_inst_m_axi_wstrb_UNCONNECTED(3 downto 0),
      m_axi_wuser(0) => NLW_inst_m_axi_wuser_UNCONNECTED(0),
      m_axi_wvalid => NLW_inst_m_axi_wvalid_UNCONNECTED,
      s_axi_araddr(31 downto 0) => s_axi_araddr(31 downto 0),
      s_axi_arburst(1 downto 0) => B"01",
      s_axi_arcache(3 downto 0) => B"0000",
      s_axi_arid(0) => '0',
      s_axi_arlen(7 downto 0) => B"00000000",
      s_axi_arlock(0) => '0',
      s_axi_arprot(2 downto 0) => s_axi_arprot(2 downto 0),
      s_axi_arqos(3 downto 0) => B"0000",
      s_axi_arready => s_axi_arready,
      s_axi_arsize(2 downto 0) => B"000",
      s_axi_aruser(0) => '0',
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_awburst(1 downto 0) => B"01",
      s_axi_awcache(3 downto 0) => B"0000",
      s_axi_awid(0) => '0',
      s_axi_awlen(7 downto 0) => B"00000000",
      s_axi_awlock(0) => '0',
      s_axi_awprot(2 downto 0) => B"000",
      s_axi_awqos(3 downto 0) => B"0000",
      s_axi_awready => NLW_inst_s_axi_awready_UNCONNECTED,
      s_axi_awsize(2 downto 0) => B"000",
      s_axi_awuser(0) => '0',
      s_axi_awvalid => '0',
      s_axi_bid(0) => NLW_inst_s_axi_bid_UNCONNECTED(0),
      s_axi_bready => '0',
      s_axi_bresp(1 downto 0) => NLW_inst_s_axi_bresp_UNCONNECTED(1 downto 0),
      s_axi_buser(0) => NLW_inst_s_axi_buser_UNCONNECTED(0),
      s_axi_bvalid => NLW_inst_s_axi_bvalid_UNCONNECTED,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rid(0) => NLW_inst_s_axi_rid_UNCONNECTED(0),
      s_axi_rlast => NLW_inst_s_axi_rlast_UNCONNECTED,
      s_axi_rready => s_axi_rready,
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_ruser(0) => NLW_inst_s_axi_ruser_UNCONNECTED(0),
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_wid(0) => '0',
      s_axi_wlast => '1',
      s_axi_wready => NLW_inst_s_axi_wready_UNCONNECTED,
      s_axi_wstrb(3 downto 0) => B"1111",
      s_axi_wuser(0) => '0',
      s_axi_wvalid => '0'
    );
end STRUCTURE;
