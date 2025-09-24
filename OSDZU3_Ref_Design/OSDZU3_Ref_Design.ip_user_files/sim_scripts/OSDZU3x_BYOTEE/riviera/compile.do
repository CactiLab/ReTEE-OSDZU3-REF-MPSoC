transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_21
vlib riviera/zynq_ultra_ps_e_vip_v1_0_21
vlib riviera/xil_defaultlib
vlib riviera/microblaze_v11_0_15
vlib riviera/lmb_v10_v3_0_15
vlib riviera/lmb_bram_if_cntlr_v4_0_26
vlib riviera/blk_mem_gen_v8_4_11
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/mdm_v3_2_28
vlib riviera/proc_sys_reset_v5_0_17
vlib riviera/axi_intc_v4_1_21
vlib riviera/interrupt_control_v3_1_5
vlib riviera/axi_gpio_v2_0_37
vlib riviera/generic_baseblocks_v2_1_2
vlib riviera/axi_register_slice_v2_1_35
vlib riviera/fifo_generator_v13_2_13
vlib riviera/axi_data_fifo_v2_1_35
vlib riviera/axi_crossbar_v2_1_37
vlib riviera/axi_protocol_converter_v2_1_36
vlib riviera/axi_clock_converter_v2_1_34
vlib riviera/axi_dwidth_converter_v2_1_36
vlib riviera/axi_mmu_v2_1_33

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_21 riviera/axi_vip_v1_1_21
vmap zynq_ultra_ps_e_vip_v1_0_21 riviera/zynq_ultra_ps_e_vip_v1_0_21
vmap xil_defaultlib riviera/xil_defaultlib
vmap microblaze_v11_0_15 riviera/microblaze_v11_0_15
vmap lmb_v10_v3_0_15 riviera/lmb_v10_v3_0_15
vmap lmb_bram_if_cntlr_v4_0_26 riviera/lmb_bram_if_cntlr_v4_0_26
vmap blk_mem_gen_v8_4_11 riviera/blk_mem_gen_v8_4_11
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap mdm_v3_2_28 riviera/mdm_v3_2_28
vmap proc_sys_reset_v5_0_17 riviera/proc_sys_reset_v5_0_17
vmap axi_intc_v4_1_21 riviera/axi_intc_v4_1_21
vmap interrupt_control_v3_1_5 riviera/interrupt_control_v3_1_5
vmap axi_gpio_v2_0_37 riviera/axi_gpio_v2_0_37
vmap generic_baseblocks_v2_1_2 riviera/generic_baseblocks_v2_1_2
vmap axi_register_slice_v2_1_35 riviera/axi_register_slice_v2_1_35
vmap fifo_generator_v13_2_13 riviera/fifo_generator_v13_2_13
vmap axi_data_fifo_v2_1_35 riviera/axi_data_fifo_v2_1_35
vmap axi_crossbar_v2_1_37 riviera/axi_crossbar_v2_1_37
vmap axi_protocol_converter_v2_1_36 riviera/axi_protocol_converter_v2_1_36
vmap axi_clock_converter_v2_1_34 riviera/axi_clock_converter_v2_1_34
vmap axi_dwidth_converter_v2_1_36 riviera/axi_dwidth_converter_v2_1_36
vmap axi_mmu_v2_1_33 riviera/axi_mmu_v2_1_33

vlog -work xilinx_vip  -incr -l smartconnect_v1_0 "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr -l smartconnect_v1_0 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"/tools/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/tools/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"/tools/Xilinx/2025.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_21  -incr -l smartconnect_v1_0 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/f16f/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_21  -incr -l smartconnect_v1_0 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1/sim/OSDZU3x_BYOTEE_zynq_ultra_ps_e_0_1_vip_wrapper.v" \

vcom -work microblaze_v11_0_15 -93  -incr \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/75f6/hdl/microblaze_v11_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_microblaze_0_0/sim/OSDZU3x_BYOTEE_microblaze_0_0.vhd" \

vcom -work lmb_v10_v3_0_15 -93  -incr \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/b1c4/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_dlmb_v10_0/sim/OSDZU3x_BYOTEE_dlmb_v10_0.vhd" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_ilmb_v10_0/sim/OSDZU3x_BYOTEE_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_26 -93  -incr \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/0e64/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_dlmb_bram_if_cntlr_0/sim/OSDZU3x_BYOTEE_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_ilmb_bram_if_cntlr_0/sim/OSDZU3x_BYOTEE_ilmb_bram_if_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_11  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/a32c/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_lmb_bram_0/sim/OSDZU3x_BYOTEE_lmb_bram_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93  -incr \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work mdm_v3_2_28 -93  -incr \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/00dd/hdl/mdm_v3_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_mdm_1_0/sim/OSDZU3x_BYOTEE_mdm_1_0.vhd" \

vcom -work proc_sys_reset_v5_0_17 -93  -incr \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/9438/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_rst_ps8_0_99M_0/sim/OSDZU3x_BYOTEE_rst_ps8_0_99M_0.vhd" \

vcom -work axi_intc_v4_1_21 -93  -incr \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/9eb6/hdl/axi_intc_v4_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_intc_0_0/sim/OSDZU3x_BYOTEE_axi_intc_0_0.vhd" \

vcom -work interrupt_control_v3_1_5 -93  -incr \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_37 -93  -incr \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/0271/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_gpio_0_0/sim/OSDZU3x_BYOTEE_axi_gpio_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_2  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_35  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/c5b7/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_13  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/dc46/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_13 -93  -incr \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/dc46/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_13  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/dc46/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_35  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/4846/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_37  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/a1a7/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_xbar_1/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_xbar_1.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_1_imp_xbar_0/sim/OSDZU3x_BYOTEE_axi_interconnect_1_imp_xbar_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_gpio_1_0/sim/OSDZU3x_BYOTEE_axi_gpio_1_0.vhd" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_gpio_2_0/sim/OSDZU3x_BYOTEE_axi_gpio_2_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../bd/OSDZU3x_BYOTEE/sim/OSDZU3x_BYOTEE.v" \

vlog -work axi_protocol_converter_v2_1_36  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/f0b6/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_3/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_auto_pc_3.v" \

vlog -work axi_clock_converter_v2_1_34  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/9a28/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work axi_dwidth_converter_v2_1_36  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/db4c/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
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

vlog -work axi_mmu_v2_1_33  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/a27c/hdl/axi_mmu_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/ec67/hdl" "+incdir+../../../../OSDZU3_Ref_Design.gen/sources_1/bd/OSDZU3x_BYOTEE/ipshared/7711/hdl" "+incdir+../../../../../../../../../../tools/Xilinx/2025.1/data/rsb/busdef" "+incdir+/tools/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l zynq_ultra_ps_e_vip_v1_0_21 -l xil_defaultlib -l microblaze_v11_0_15 -l lmb_v10_v3_0_15 -l lmb_bram_if_cntlr_v4_0_26 -l blk_mem_gen_v8_4_11 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_28 -l proc_sys_reset_v5_0_17 -l axi_intc_v4_1_21 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_37 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l axi_dwidth_converter_v2_1_36 -l axi_mmu_v2_1_33 \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s00_mmu_0/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s00_mmu_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s01_mmu_0/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s01_mmu_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s02_mmu_0/sim/OSDZU3x_BYOTEE_axi_interconnect_0_imp_s02_mmu_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_ultra_ps_0_axi_periph_imp_auto_ds_0/sim/OSDZU3x_BYOTEE_ultra_ps_0_axi_periph_imp_auto_ds_0.v" \
"../../../bd/OSDZU3x_BYOTEE/ip/OSDZU3x_BYOTEE_ultra_ps_0_axi_periph_imp_auto_pc_0/sim/OSDZU3x_BYOTEE_ultra_ps_0_axi_periph_imp_auto_pc_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

