/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"


int main()
{
    init_platform();

    print("[riscv] Hello World\n\r");
    print("[riscv] Successfully ran Hello World application\n\r");

    int c = 0;

    while (1) {
        for (int i = 0; i < 8; ++i) {
            toggle_LED(i);
            msleep(50);
        }
        msleep(500);
        xil_printf("[riscv] cycle: %d\n\r", c);
        ++c;
    }

    cleanup_platform();
    return 0;
}


void symbol_table_demo() {
    
}