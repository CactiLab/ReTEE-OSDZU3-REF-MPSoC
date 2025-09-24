# OSDZU3 Ref Design Constrains

set_property IOSTANDARD LVCMOS33 [get_ports lvds_display_iic_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports lvds_display_iic_sda_io]
set_property PULLUP true [get_ports lvds_display_iic_scl_io]
set_property PULLUP true [get_ports lvds_display_iic_sda_io]

set_property IOSTANDARD LVCMOS33 [get_ports {lvds_display_touch_irq_tri_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lvds_display_touch_reset[0]}]

set_property IOSTANDARD LVDS [get_ports {lvds_display_data_p[3]}]
set_property IOSTANDARD LVDS [get_ports {lvds_display_data_p[2]}]
set_property IOSTANDARD LVDS [get_ports {lvds_display_data_p[1]}]
set_property IOSTANDARD LVDS [get_ports {lvds_display_data_p[0]}]
set_property IOSTANDARD LVDS [get_ports lvds_display_clk_p]

set_property IOSTANDARD LVCMOS33 [get_ports {lvds_display_reset[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lvds_display_standby[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pwr_en_ctrl[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports backlight_dctrl]

set_property IOSTANDARD LVCMOS33 [get_ports PMOD_A_UART_CTSn]
set_property IOSTANDARD LVCMOS33 [get_ports PMOD_A_UART_TX]
set_property IOSTANDARD LVCMOS33 [get_ports PMOD_A_UART_RX]
set_property IOSTANDARD LVCMOS33 [get_ports PMOD_A_UART_RTSn]
set_property PULLUP true [get_ports PMOD_A_UART_CTSn]
set_property PULLUP true [get_ports PMOD_A_UART_RX]

set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_A_GPIO_tri_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_A_GPIO_tri_io[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_A_GPIO_tri_io[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_A_GPIO_tri_io[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports CLICK_PWM]
set_property IOSTANDARD LVCMOS33 [get_ports CLICK_UART_RX]
set_property IOSTANDARD LVCMOS33 [get_ports CLICK_UART_TX]
set_property IOSTANDARD LVCMOS33 [get_ports CLICK_I2C_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports CLICK_I2C_sda_io]
set_property PULLUP true [get_ports CLICK_UART_RX]
set_property PULLUP true [get_ports CLICK_I2C_scl_io]
set_property PULLUP true [get_ports CLICK_I2C_sda_io]

set_property IOSTANDARD LVCMOS33 [get_ports PMOD_B_I2C_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports PMOD_B_I2C_sda_io]
set_property PULLUP true [get_ports PMOD_B_I2C_scl_io]
set_property PULLUP true [get_ports PMOD_B_I2C_sda_io]

set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_B_GPIO_tri_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_B_GPIO_tri_io[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_B_GPIO_tri_io[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_B_GPIO_tri_io[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_B_GPIO_tri_io[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PMOD_B_GPIO_tri_io[5]}]


set_false_path -from [get_pins design_1_i/LVDS_Display/v_axi4s_vid_out_0/inst/COUPLER_INST/generate_async_fifo.FIFO_INST/XPM_FIFO_ASYNC_INST/gnuram_async_fifo.xpm_fifo_base_inst/gof.overflow_i_reg/C] -to [get_pins {design_1_i/LVDS_Display/system_ila_0/inst/ila_lib/inst/ila_core_inst/shifted_data_in_reg[7][2]_srl8/D}]



create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list design_1_i/zynq_ultra_ps_e_0/inst/pl_clk0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 3 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {push_buttons_3bits_tri_i_IBUF[0]} {push_buttons_3bits_tri_i_IBUF[1]} {push_buttons_3bits_tri_i_IBUF[2]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]

set_property GENERATE_SYNTH_CHECKPOINT FALSE [current_project]
set_property STEPS.WRITE_BITSTREAM.TCL.POST [pwd]/generate_bmm.tcl [get_runs impl_1]