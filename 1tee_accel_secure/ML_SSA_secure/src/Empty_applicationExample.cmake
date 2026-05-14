set(psu_ddr_0_memory_0 "0x40000000;0x3ff00000")
set(dlmb_bram_if_cntlr_memory_0 "0x0;0x80000")
set(psu_ocm_ram_0_memory_0 "0xfffc0000;0x40000")
set(dlmb_bram_if_cntlr1_memory_1 "0x80000;0x20000")
set(act_bram_ctrl_a_memory_0 "0xc1000000;0x10000")
set(act_bram_ctrl_b_memory_1 "0xc2000000;0x10000")
set(dlmb_bram_if_cntlr2_memory_2 "0xa0000;0x10000")
set(DDR dlmb_bram_if_cntlr_memory_0)
set(CODE dlmb_bram_if_cntlr_memory_0)
set(DATA dlmb_bram_if_cntlr_memory_0)
set(TOTAL_MEM_CONTROLLERS "psu_ddr_0_memory_0;dlmb_bram_if_cntlr_memory_0;psu_ocm_ram_0_memory_0;dlmb_bram_if_cntlr1_memory_1;act_bram_ctrl_a_memory_0;act_bram_ctrl_b_memory_1;dlmb_bram_if_cntlr2_memory_2")
set(MEMORY_SECTION "MEMORY
{
	psu_ddr_0_memory_0 : ORIGIN = 0x40000000, LENGTH = 0x3ff00000
	psu_qspi_linear_0_memory_0 : ORIGIN = 0xd0000000, LENGTH = 0x10000000
	dlmb_bram_if_cntlr_memory_0 : ORIGIN = 0x0, LENGTH = 0x80000
	psu_ocm_ram_0_memory_0 : ORIGIN = 0xfffc0000, LENGTH = 0x40000
	dlmb_bram_if_cntlr1_memory_1 : ORIGIN = 0x80000, LENGTH = 0x20000
	act_bram_ctrl_a_memory_0 : ORIGIN = 0xc1000000, LENGTH = 0x10000
	act_bram_ctrl_b_memory_1 : ORIGIN = 0xc2000000, LENGTH = 0x10000
	dlmb_bram_if_cntlr2_memory_2 : ORIGIN = 0xa0000, LENGTH = 0x10000
}")
set(STACK_SIZE 0x400)
set(HEAP_SIZE 0x800)
