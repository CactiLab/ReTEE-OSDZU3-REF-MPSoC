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
    id 46 \
    name bytePlanes_plane0 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_bytePlanes_plane0 \
    op interface \
    ports { bytePlanes_plane0_dout { I 64 vector } bytePlanes_plane0_empty_n { I 1 bit } bytePlanes_plane0_read { O 1 bit } bytePlanes_plane0_num_data_valid { I 11 vector } bytePlanes_plane0_fifo_cap { I 11 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 47 \
    name bytePlanes_plane1 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_bytePlanes_plane1 \
    op interface \
    ports { bytePlanes_plane1_dout { I 64 vector } bytePlanes_plane1_empty_n { I 1 bit } bytePlanes_plane1_read { O 1 bit } bytePlanes_plane1_num_data_valid { I 11 vector } bytePlanes_plane1_fifo_cap { I 11 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 48 \
    name img \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_img \
    op interface \
    ports { img_din { O 24 vector } img_full_n { I 1 bit } img_write { O 1 bit } img_num_data_valid { I 32 vector } img_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 49 \
    name Height_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_Height_val \
    op interface \
    ports { Height_val { I 12 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 50 \
    name WidthInBytes_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_WidthInBytes_val \
    op interface \
    ports { WidthInBytes_val { I 15 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 51 \
    name VideoFormat_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_VideoFormat_val \
    op interface \
    ports { VideoFormat_val { I 6 vector } } \
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
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } ap_continue { I 1 bit } } \
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


