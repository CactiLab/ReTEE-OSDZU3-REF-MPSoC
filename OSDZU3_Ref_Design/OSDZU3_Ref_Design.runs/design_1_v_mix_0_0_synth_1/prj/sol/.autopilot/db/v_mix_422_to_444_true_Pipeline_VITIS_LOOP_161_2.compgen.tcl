# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 127 \
    name p_0_0_0206358_lcssa364426 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0206358_lcssa364426 \
    op interface \
    ports { p_0_0_0206358_lcssa364426 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 128 \
    name p_0_0_0_0_0207_4_lcssa423 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0207_4_lcssa423 \
    op interface \
    ports { p_0_0_0_0_0207_4_lcssa423 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 129 \
    name p_0_0_0_0_0207_3_lcssa420 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0207_3_lcssa420 \
    op interface \
    ports { p_0_0_0_0_0207_3_lcssa420 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 130 \
    name p_0_0_0_0_0207_2_lcssa417 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0207_2_lcssa417 \
    op interface \
    ports { p_0_0_0_0_0207_2_lcssa417 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 131 \
    name p_0_0_0206358_lcssa409 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0206358_lcssa409 \
    op interface \
    ports { p_0_0_0206358_lcssa409 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 132 \
    name loopWidth \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_loopWidth \
    op interface \
    ports { loopWidth { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 133 \
    name srcLayer1Yuv \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_srcLayer1Yuv \
    op interface \
    ports { srcLayer1Yuv_din { O 24 vector } srcLayer1Yuv_full_n { I 1 bit } srcLayer1Yuv_write { O 1 bit } srcLayer1Yuv_num_data_valid { I 32 vector } srcLayer1Yuv_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 134 \
    name width \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_width \
    op interface \
    ports { width { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 135 \
    name srcLayer1Yuv422 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_srcLayer1Yuv422 \
    op interface \
    ports { srcLayer1Yuv422_dout { I 24 vector } srcLayer1Yuv422_empty_n { I 1 bit } srcLayer1Yuv422_read { O 1 bit } srcLayer1Yuv422_num_data_valid { I 3 vector } srcLayer1Yuv422_fifo_cap { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 136 \
    name p_0_0_0199355390_out \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0199355390_out \
    op interface \
    ports { p_0_0_0199355390_out_i { I 8 vector } p_0_0_0199355390_out_o { O 8 vector } p_0_0_0199355390_out_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 137 \
    name p_0_0_0200353387_out \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0200353387_out \
    op interface \
    ports { p_0_0_0200353387_out_i { I 8 vector } p_0_0_0200353387_out_o { O 8 vector } p_0_0_0200353387_out_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 138 \
    name p_0_0_0_0_0_2384_out \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0_2384_out \
    op interface \
    ports { p_0_0_0_0_0_2384_out_i { I 8 vector } p_0_0_0_0_0_2384_out_o { O 8 vector } p_0_0_0_0_0_2384_out_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 139 \
    name p_0_0_0_0_0205_2381_out \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0205_2381_out \
    op interface \
    ports { p_0_0_0_0_0205_2381_out_i { I 8 vector } p_0_0_0_0_0205_2381_out_o { O 8 vector } p_0_0_0_0_0205_2381_out_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 140 \
    name p_0_0_0_0_0_1374_out \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0_1374_out \
    op interface \
    ports { p_0_0_0_0_0_1374_out_i { I 8 vector } p_0_0_0_0_0_1374_out_o { O 8 vector } p_0_0_0_0_0_1374_out_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 141 \
    name p_0_0_0_0_0205_1367_out \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0205_1367_out \
    op interface \
    ports { p_0_0_0_0_0205_1367_out_i { I 8 vector } p_0_0_0_0_0205_1367_out_o { O 8 vector } p_0_0_0_0_0205_1367_out_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 142 \
    name p_0_0_0206358363_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0206358363_out \
    op interface \
    ports { p_0_0_0206358363_out { O 8 vector } p_0_0_0206358363_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 143 \
    name p_0_0_0_0_0207_4362_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0207_4362_out \
    op interface \
    ports { p_0_0_0_0_0207_4362_out { O 8 vector } p_0_0_0_0_0207_4362_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 144 \
    name p_0_0_0_0_0207_3361_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0207_3361_out \
    op interface \
    ports { p_0_0_0_0_0207_3361_out { O 8 vector } p_0_0_0_0_0207_3361_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 145 \
    name p_0_0_0_0_0207_2360_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0207_2360_out \
    op interface \
    ports { p_0_0_0_0_0207_2360_out { O 8 vector } p_0_0_0_0_0207_2360_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 146 \
    name p_0_0_0_0_0207_1359_out \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0_0_0207_1359_out \
    op interface \
    ports { p_0_0_0_0_0207_1359_out_i { I 8 vector } p_0_0_0_0_0207_1359_out_o { O 8 vector } p_0_0_0_0_0207_1359_out_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 147 \
    name p_0_0_0199354_out \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0199354_out \
    op interface \
    ports { p_0_0_0199354_out_i { I 8 vector } p_0_0_0199354_out_o { O 8 vector } p_0_0_0199354_out_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 148 \
    name p_0_0_0200352_out \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_0_0_0200352_out \
    op interface \
    ports { p_0_0_0200352_out_i { I 8 vector } p_0_0_0200352_out_o { O 8 vector } p_0_0_0200352_out_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


# flow_control definition:
set InstName design_1_v_mix_0_0_flow_control_loop_pipe_sequential_init_U
set CompName design_1_v_mix_0_0_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix design_1_v_mix_0_0_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


