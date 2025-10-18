set(DDR lmb_bram_0)
set(psu_ddr_0 "0x40000000;0x3ff00000")
set(psu_ocm_0 "0xfffc0000;0x40000")
set(lmb_bram_0 "0x0;0x20000")
set(TOTAL_MEM_CONTROLLERS "lmb_bram_0;psu_ddr_0;psu_ocm_0")
set(MEMORY_SECTION "MEMORY
{
	psu_ddr_0 : ORIGIN = 0x40000000, LENGTH = 0x3ff00000
	psu_qspi_linear_0 : ORIGIN = 0xc0000000, LENGTH = 0x10000000
	psu_ocm_0 : ORIGIN = 0xfffc0000, LENGTH = 0x40000
	lmb_bram_0 : ORIGIN = 0x0, LENGTH = 0x20000
}")
set(STACK_SIZE 0x400)
set(HEAP_SIZE 0x800)
