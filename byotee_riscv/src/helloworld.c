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

#include <stdint.h>
#include <stdio.h>
#include "platform.h"
#include <xil_printf.h>
#include <sleep.h>

int main()
{
    init_platform();

    print("[microblaze] Hello World from microblaze!\n\r");
    print("[microblaze] Successfully ran Hello World application\n\r");

    uint32_t data[] = { 0x1, 0x2, 0x3, 0x4, 0x11223344};
    
    // send_command(1, data, sizeof(data));

    while (1) {
        for (int i = 0; i < 8; ++i) {
            toggle_LED(i);
            msleep(50);
        }
        msleep(500);
    }
    cleanup_platform();
    return 0;
}
