vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xpm
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_vip_v1_1_21
vlib questa_lib/msim/zynq_ultra_ps_e_vip_v1_0_21
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/microblaze_v11_0_15
vlib questa_lib/msim/lmb_v10_v3_0_15
vlib questa_lib/msim/lmb_bram_if_cntlr_v4_0_26
vlib questa_lib/msim/blk_mem_gen_v8_4_11
vlib questa_lib/msim/axi_lite_ipif_v3_0_4
vlib questa_lib/msim/mdm_v3_2_28
vlib questa_lib/msim/proc_sys_reset_v5_0_17
vlib questa_lib/msim/axi_intc_v4_1_21
vlib questa_lib/msim/interrupt_control_v3_1_5
vlib questa_lib/msim/axi_gpio_v2_0_37
vlib questa_lib/msim/generic_baseblocks_v2_1_2
vlib questa_lib/msim/axi_register_slice_v2_1_35
vlib questa_lib/msim/fifo_generator_v13_2_13
vlib questa_lib/msim/axi_data_fifo_v2_1_35
vlib questa_lib/msim/axi_crossbar_v2_1_37
vlib questa_lib/msim/axi_protocol_converter_v2_1_36
vlib questa_lib/msim/axi_clock_converter_v2_1_34
vlib questa_lib/msim/axi_dwidth_converter_v2_1_36
vlib questa_lib/msim/axi_mmu_v2_1_33

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xpm questa_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_21 questa_lib/msim/axi_vip_v1_1_21
vmap zynq_ultra_ps_e_vip_v1_0_21 questa_lib/msim/zynq_ultra_ps_e_vip_v1_0_21
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap microblaze_v11_0_15 questa_lib/msim/microblaze_v11_0_15
vmap lmb_v10_v3_0_15 questa_lib/msim/lmb_v10_v3_0_15
vmap lmb_bram_if_cntlr_v4_0_26 questa_lib/msim/lmb_bram_if_cntlr_v4_0_26
vmap blk_mem_gen_v8_4_11 questa_lib/msim/blk_mem_gen_v8_4_11
vmap axi_lite_ipif_v3_0_4 questa_lib/msim/axi_lite_ipif_v3_0_4
vmap mdm_v3_2_28 questa_lib/msim/mdm_v3_2_28
vmap proc_sys_reset_v5_0_17 questa_lib/msim/proc_sys_reset_v5_0_17
vmap axi_intc_v4_1_21 questa_lib/msim/axi_intc_v4_1_21
vmap interrupt_control_v3_1_5 questa_lib/msim/interrupt_control_v3_1_5
vmap axi_gpio_v2_0_37 questa_lib/msim/axi_gpio_v2_0_37
vmap generic_baseblocks_v2_1_2 questa_lib/msim/generic_baseblocks_v2_1_2
vmap axi_register_slice_v2_1_35 questa_lib/msim/axi_register_slice_v2_1_35
vmap fifo_generator_v13_2_13 questa_lib/msim/fifo_generator_v13_2_13
vmap axi_data_fifo_v2_1_35 questa_lib/msim/axi_data_fifo_v2_1_35
vmap axi_crossbar_v2_1_37 questa_lib/msim/axi_crossbar_v2_1_37
vmap axi_protocol_converter_v2_1_36 questa_lib/msim/axi_protocol_converter_v2_1_36
vmap axi_clock_converter_v2_1_34 questa_lib/msim/axi_clock_converter_v2_1_34
vmap axi_dwidth_converter_v2_1_36 questa_lib/msim/axi_dwidth_converter_v2_1_36
vmap axi_mmu_v2_1_33 questa_lib/msim/axi_mmu_v2_1_33

vlog -work xilinx_vip -64 -incr -mfcu  -sv -L axi_vip_v1_1_21 -L zynq_ultra_ps_e_vip_v1_0_21 -L smartconnect_v1_0 -L xilinx_vip "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm -64 -incr -mfcu  -sv -L axi_vip_v1_1_21 -L zynq_ultra_ps_e_vip_v1_0_21 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"/tools/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/tools/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93  \
"/tools/Xilinx/2025.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_21 -64 -incr -mfcu  -sv -L axi_vip_v1_1_21 -L zynq_ultra_ps_e_vip_v1_0_21 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/f16f/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_21 -64 -incr -mfcu  -sv -L axi_vip_v1_1_21 -L zynq_ultra_ps_e_vip_v1_0_21 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1/sim/OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1_vip_wrapper.v" \

vcom -work microblaze_v11_0_15 -64 -93  \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/75f6/hdl/microblaze_v11_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_microblaze_0_0/sim/OSDZU3x_BYOTEE_microblaze_0_0.vhd" \

vcom -work lmb_v10_v3_0_15 -64 -93  \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/b1c4/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_dlmb_v10_0/sim/OSDZU3x_BYOTEE_dlmb_v10_0.vhd" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_ilmb_v10_0/sim/OSDZU3x_BYOTEE_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_26 -64 -93  \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/0e64/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_dlmb_bram_if_cntlr_0/sim/OSDZU3x_BYOTEE_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_ilmb_bram_if_cntlr_0/sim/OSDZU3x_BYOTEE_ilmb_bram_if_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_11 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/a32c/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_lmb_bram_0/sim/OSDZU3x_BYOTEE_lmb_bram_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93  \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work mdm_v3_2_28 -64 -93  \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/00dd/hdl/mdm_v3_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_mdm_1_0/sim/OSDZU3x_BYOTEE_mdm_1_0.vhd" \

vcom -work proc_sys_reset_v5_0_17 -64 -93  \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/9438/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_rst_ps8_0_99M_0/sim/OSDZU3x_BYOTEE_rst_ps8_0_99M_0.vhd" \

vcom -work axi_intc_v4_1_21 -64 -93  \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/9eb6/hdl/axi_intc_v4_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_intc_0_0/sim/OSDZU3x_BYOTEE_axi_intc_0_0.vhd" \

vcom -work interrupt_control_v3_1_5 -64 -93  \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_37 -64 -93  \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/0271/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_gpio_0_0/sim/OSDZU3x_BYOTEE_axi_gpio_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_2 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_35 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/c5b7/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_13 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/dc46/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_13 -64 -93  \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/dc46/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_13 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/dc46/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_35 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/4846/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_37 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/a1a7/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_xbar_1/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_xbar_1.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_1_imp_xbar_0/sim/OSDZU3x_BYOTEE_axi_interconnect_1_imp_xbar_0.v" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_gpio_1_0/sim/OSDZU3x_BYOTEE_axi_gpio_1_0.vhd" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_gpio_2_0/sim/OSDZU3x_BYOTEE_axi_gpio_2_0.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/OSDZU3x_BYOTEE/sim/OSDZU3x_BYOTEE.v" \

vlog -work axi_protocol_converter_v2_1_36 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/f0b6/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_3/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_3.v" \

vlog -work axi_clock_converter_v2_1_34 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/9a28/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work axi_dwidth_converter_v2_1_36 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/db4c/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_us_0/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_us_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_4/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_4.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_us_1/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_us_1.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_us_2/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_us_2.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_ds_0/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_ds_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_0/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_ds_1/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_ds_1.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_1/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_1.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_ds_2/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_ds_2.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_2/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_2.v" \

vlog -work axi_mmu_v2_1_33 -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/a27c/hdl/axi_mmu_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s00_mmu_0/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s00_mmu_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s01_mmu_0/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s01_mmu_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s02_mmu_0/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s02_mmu_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_ultra_ps_0_axi_periph_imp_auto_ds_0/sim/OSDZU3x_BYOTEE_ultra_ps_0_axi_periph_imp_auto_ds_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_ultra_ps_0_axi_periph_imp_auto_pc_0/sim/OSDZU3x_BYOTEE_ultra_ps_0_axi_periph_imp_auto_pc_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

