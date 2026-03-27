/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

#include "platform.h"
#include <string.h>
#include <xil_cache.h>
#include <xil_printf.h>
#include <xparameters.h>
#include <stdint.h>
#include <xintc.h>
#include <xgpio.h>
#include <xstatus.h>
#include <stdbool.h>


#ifndef SDT
#include "platform_config.h"
#include "platform_shared.h"
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

#define ARM_TO_MB_INTERRUPT_ID  XPAR_INTC_0_DEVICE_ID  // Update with your actual ID

// Shared data structure
typedef struct __attribute__((__packed__)) {
    volatile bool mb_to_arm_flag;
    volatile bool arm_to_mb_flag;
    volatile bool ready;
    volatile bool executing;
    volatile uint32_t command;
    volatile uint32_t data[50000];
} shared_ocm_t;

#define SHARED_ADDR 0xFFFC0000
#define SHARED_OCM ((shared_ocm_t*) SHARED_ADDR)

// void send_command(uint32_t command, uint32_t* new_data, uint32_t data_sz) {
//     // MicroBlaze writes to OCM
//     memcpy((void*) SHARED_OCM->data, new_data, data_sz);
//     SHARED_OCM->command = command;
//     SHARED_OCM->mb_to_arm_flag = 1;  // Signal ARM
// }

extern char _MODULE_BASE;
extern char _MODULE_SIZE;
extern volatile bool intr_triggered;

void arm_interrupt_handler(XIntc *intc) {
    xil_printf("[m] IRQ from ARM! Cmd: 0x%08X\r\n", SHARED_OCM->command);
    if (intr_triggered) return;
    SHARED_OCM->ready = 0;
    intr_triggered = true;
    // Xil_DCacheInvalidateRange(SHARED_ADDR, sizeof(shared_ocm_t));
    // Read data from shared memory immediately
            
    SHARED_OCM->arm_to_mb_flag = 0;
    SHARED_OCM->mb_to_arm_flag = 1;    
}

static XIntc InterruptController;

volatile uint32_t* led_data = (volatile uint32_t*)(XPAR_XGPIO_0_BASEADDR);
volatile uint32_t* led_direction = (volatile uint32_t*)(XPAR_XGPIO_0_BASEADDR + 0x04);
uint8_t led_value = 0;

int init_platform()
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
    enable_caches();
    init_uart();
    *led_direction = 0x00;
    *led_data = 0b11111111;

    // setup interrupts
    int Status;
    
    // Initialize using the config table directly
    Status = XIntc_Initialize(&InterruptController, XPAR_XINTC_0_BASEADDR);

    if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

    *led_data = 0b11101110;

    Status = XIntc_Connect(&InterruptController, 0,
                          (XInterruptHandler)arm_interrupt_handler,
                          (void*) &InterruptController);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    *led_data = 0b11001100;
    
    // Start interrupt controller
    Status = XIntc_Start(&InterruptController, XIN_REAL_MODE);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    *led_data = 0b10001000;
    
    // Enable GPIO interrupt
    XIntc_Enable(&InterruptController, 0);

    Xil_ExceptionInit();

    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
				     (Xil_ExceptionHandler)XIntc_InterruptHandler,
				     (void *) &InterruptController);

	Xil_ExceptionEnable();

    riscv_enable_interrupts();

    *led_data = 0;

    return XST_SUCCESS;
}

void cleanup_platform()
{
    disable_caches();
}

void toggle_LED(int idx) 
{
    led_value ^= 1 << idx;
    *led_data = led_value;
}

void set_LED(int value) 
{
    led_value = value;
    *led_data = value;
}

void rst_LED() 
{
    *led_data = 0;
}