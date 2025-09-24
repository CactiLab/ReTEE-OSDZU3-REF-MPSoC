/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

#include "xil_cache.h"
#include <xil_io.h>
#include <stdint.h>
#include <xparameters.h>
#include <xenv.h>
#include <xil_mmu.h>

#ifndef SDT
#include "platform_config.h"
#endif

/*
 * Uncomment one of the following two lines, depending on the target,
 * if ps7/psu init source files are added in the source directory for
 * compiling example outside of SDK.
 */
/*#include "ps7_init.h"*/
/*#include "psu_init.h"*/

#ifdef STDOUT_IS_16550
 #include "xuartns550_l.h"

 #define UART_BAUD 9600
#endif

void
enable_caches()
{
#ifdef __PPC__
    Xil_ICacheEnableRegion(CACHEABLE_REGION_MASK);
    Xil_DCacheEnableRegion(CACHEABLE_REGION_MASK);
#elif __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_ICACHE
    Xil_ICacheEnable();
#endif
#ifdef XPAR_MICROBLAZE_USE_DCACHE
    Xil_DCacheEnable();
#endif
#endif
}

void
disable_caches()
{
#ifdef __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_DCACHE
    Xil_DCacheDisable();
#endif
#ifdef XPAR_MICROBLAZE_USE_ICACHE
    Xil_ICacheDisable();
#endif
#endif
}

void
init_uart()
{
#ifdef STDOUT_IS_16550
    XUartNs550_SetBaud(STDOUT_BASEADDR, XPAR_XUARTNS550_CLOCK_HZ, UART_BAUD);
    XUartNs550_SetLineControlReg(STDOUT_BASEADDR, XUN_LCR_8_DATA_BITS);
#endif
    /* Bootrom/BSP configures PS7/PSU UART to 115200 bps */
}

void
init_platform()
{
    /*
     * If you want to run this example outside of SDK,
     * uncomment one of the following two lines and also #include "ps7_init.h"
     * or #include "ps7_init.h" at the top, depending on the target.
     * Make sure that the ps7/psu_init.c and ps7/psu_init.h files are included
     * along with this example source files for compilation.
     */
    /* ps7_init();*/
    /* psu_init();*/
    // enable_caches();
    init_uart();
}

void
cleanup_platform()
{
    disable_caches();
}


// Shared data structure
typedef struct __attribute__((__packed__)) {
    volatile uint32_t mb_to_arm_flag;
    volatile uint32_t arm_to_mb_flag;
    volatile uint32_t command;
    volatile uint32_t data[64];
} shared_ocm_t;

#define SHARED_ADDR 0xFFFC0000
#define SHARED_OCM ((shared_ocm_t*) SHARED_ADDR)

volatile uint32_t* intr_data = (volatile uint32_t*)(XPAR_PS_PL_INTR_BASEADDR);

void send_command(uint32_t command, uint32_t* new_data, uint32_t data_sz) {
    Xil_SetTlbAttributes(SHARED_ADDR, NORM_NONCACHE);

    // write to OCM
    SHARED_OCM->data[0] = 0xffffffff ^ new_data[0];
    SHARED_OCM->command = command;
    SHARED_OCM->mb_to_arm_flag = 0;
    SHARED_OCM->arm_to_mb_flag = 1;  // Signal pl
    Xil_DCacheFlushRange(SHARED_ADDR, sizeof(shared_ocm_t));
    dsb();

    xil_printf("[c] sending command + interrupt; Cmd: 0x%08X, Data[0]: 0x%08X\r\n", SHARED_OCM->command, SHARED_OCM->data[0]);
    *intr_data = 1;
    *intr_data = 0;

    // Xil_Out32(XPAR_PS_PL_INTR_BASEADDR, 0x01);
    // uint32_t read_val = Xil_In32(XPAR_PS_PL_INTR_BASEADDR);
    // xil_printf("[cortex] GPIO Write 1, Read: 0x%08X\r\n", read_val);
    
    // Xil_Out32(XPAR_PS_PL_INTR_BASEADDR, 0x00);
    // read_val = Xil_In32(XPAR_PS_PL_INTR_BASEADDR);
    // xil_printf("[cortex] GPIO Write 0, Read: 0x%08X\r\n", read_val);
}

void test_interrupt() {
    // Xil_Out32(XPAR_PS_PL_INTR_BASEADDR, 0xFFFFFFFF);

    // uint32_t read_val = Xil_In32(XPAR_PS_PL_INTR_BASEADDR);
    // xil_printf("[cortex] GPIO Write 1, Read: 0x%08X\r\n", read_val);
    
    // Xil_Out32(XPAR_PS_PL_INTR_BASEADDR, 0x0);
    // read_val = Xil_In32(XPAR_PS_PL_INTR_BASEADDR);
    // xil_printf("[cortex] GPIO Write 0, Read: 0x%08X\r\n", read_val);
}