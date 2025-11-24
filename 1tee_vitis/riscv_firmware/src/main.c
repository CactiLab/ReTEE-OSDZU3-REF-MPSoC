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

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <xil_printf.h>
#include <elf.h>

#include "platform.h"

extern char _MODULE_BASE;
extern char _MODULE_SIZE;

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

volatile bool intr_triggered = false;

int main()
{
    init_platform();

    print("[riscv] Hello World\n\r");
    print("[riscv] Successfully ran Hello World application\n\r");
    xil_printf("MODULE_BASE: 0x%x, SZ: 0x%x\n\r", &_MODULE_BASE, &_MODULE_SIZE);

    int c = 0;

    while (1) {
        if (intr_triggered) {
            xil_printf("[riscv] Handling IRQ: 0x%08X.\n", SHARED_OCM->command);
            SHARED_OCM->executing = 1;
            if (SHARED_OCM->command == 0x44414F4C) {
                // parse elf header
                xil_printf("[m] LOADING ELF\r\n");
                char* data_buf = SHARED_OCM->data;
                if (SHARED_OCM->data[0] == 0x464C457F) { //magic bytes
                    Elf32_Ehdr* ehdr = (Elf32_Ehdr*) data_buf;
                    Elf32_Phdr* phdr = (Elf32_Phdr*) &data_buf[ehdr->e_phoff];
                    memset(&_MODULE_BASE, &_MODULE_SIZE, 0);
                    for (int i = 0; i < ehdr->e_phnum; i++) {
                        if (phdr[i].p_type == PT_LOAD) {
                            memcpy(phdr[i].p_paddr, data_buf + phdr[i].p_offset, phdr[i].p_filesz);
                        }
                    }
                    void* entrypoint = (void*) ehdr->e_entry;
                    //xil_printf("entrypoint: 0x%x | entrypoint2: 0x%x\n\r", entrypoint, (&_MODULE_BASE) + ehdr->e_entry);
                    ((void (*)(void))entrypoint)();
                    memset(&_MODULE_BASE, &_MODULE_SIZE, 0);
                } else {
                    xil_printf("[m] IRQ: ELF not found. Magic: %x\n\r", SHARED_OCM->data[0]);
                }
            } else {
                xil_printf("not load elf. Cmd: 0x%08X\r\n", SHARED_OCM->command);
            }
            intr_triggered = false;
            SHARED_OCM->executing = 0;
            SHARED_OCM->ready = 1;
        }
        msleep(10);
        if (c % 100 == 0) xil_printf("[riscv] cycle: %d\n\r", c);
        ++c;
    }

    cleanup_platform();
    return 0;
}