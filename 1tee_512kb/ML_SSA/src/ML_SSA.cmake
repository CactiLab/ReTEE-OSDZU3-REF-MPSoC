set(psu_ddr_0_memory_0 "0x40000000;0x3ff00000")
set(psu_ocm_ram_0_memory_0 "0xfffc0000;0x40000")
set(microblaze_riscv_0_local_memory_dlmb_bram_if_cntlr_memory_0 "0x0;0x20000")
set(DDR psu_ddr_0_memory_0)
set(CODE psu_ddr_0_memory_0)
set(DATA psu_ddr_0_memory_0)
set(TOTAL_MEM_CONTROLLERS "psu_ddr_0_memory_0;psu_ocm_ram_0_memory_0;microblaze_riscv_0_local_memory_dlmb_bram_if_cntlr_memory_0")
set(MEMORY_SECTION "MEMORY
{
	psu_ddr_0_memory_0 : ORIGIN = 0x40000000, LENGTH = 0x3ff00000
	psu_qspi_linear_0_memory_0 : ORIGIN = 0xd0000000, LENGTH = 0x10000000
	psu_ocm_ram_0_memory_0 : ORIGIN = 0xfffc0000, LENGTH = 0x40000
	microblaze_riscv_0_local_memory_dlmb_bram_if_cntlr_memory_0 : ORIGIN = 0x0, LENGTH = 0x20000
}")
set(STACK_SIZE 0x400)
set(HEAP_SIZE 0x800)
