set(IOMODULE_NUM_DRIVER_INSTANCES "")
set(UARTLITE_NUM_DRIVER_INSTANCES "")
set(UARTNS550_NUM_DRIVER_INSTANCES "")
set(UARTPS_NUM_DRIVER_INSTANCES "psu_uart_0;psu_uart_1")
set(UARTPS0_PROP_LIST "0xff000000")
list(APPEND TOTAL_UARTPS_PROP_LIST UARTPS0_PROP_LIST)
set(UARTPS1_PROP_LIST "0xff010000")
list(APPEND TOTAL_UARTPS_PROP_LIST UARTPS1_PROP_LIST)
set(UARTPSV_NUM_DRIVER_INSTANCES "")
set(psu_ddr_0_memory_0 "0x0;0x40000000")
set(psu_ddr_0_memory_1 "0x60000000;0x1ff00000")
set(psu_ocm_ram_0_memory_0 "0xfffc0000;0x40000")
set(microblaze_riscv_0_local_memory_dlmb_bram_if_cntlr_memory_0 "0x90000000;0x20000")
set(BASE_VECTOR 2415919104)
set(DDR psu_ddr_0_memory_0)
set(CODE psu_ddr_0_memory_0)
set(DATA psu_ddr_0_memory_0)
set(TOTAL_MEM_CONTROLLERS "psu_ddr_0_memory_0;psu_ddr_0_memory_1;psu_ocm_ram_0_memory_0;microblaze_riscv_0_local_memory_dlmb_bram_if_cntlr_memory_0")
set(MEMORY_SECTION "MEMORY
{
	psu_ddr_0_memory_0 : ORIGIN = 0x0, LENGTH = 0x40000000
	psu_ddr_0_memory_1 : ORIGIN = 0x60000000, LENGTH = 0x1ff00000
	psu_qspi_linear_0_memory_0 : ORIGIN = 0xc0000000, LENGTH = 0x10000000
	psu_ocm_ram_0_memory_0 : ORIGIN = 0xfffc0000, LENGTH = 0x40000
	microblaze_riscv_0_local_memory_dlmb_bram_if_cntlr_memory_0 : ORIGIN = 0x90000000, LENGTH = 0x20000
}")
set(STACK_SIZE 0x400)
set(HEAP_SIZE 0x800)
