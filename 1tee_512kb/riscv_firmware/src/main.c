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

#define CMD_LOAD_ELF        0x44414F4C
#define CMD_LOAD_ELF_DRAM   0x44524D4C
#define CMD_LOAD_SEG        0x4C534547
#define CMD_EXEC            0x45584543

volatile bool intr_triggered = false;

/* Load ELF from a buffer (OCM data[] or DRAM pointer) */
static void load_elf_from_buf(char *data_buf)
{
    if (*(uint32_t*)data_buf != 0x464C457F) {
        xil_printf("[m] ELF magic not found: %x\n\r", *(uint32_t*)data_buf);
        return;
    }
    Elf32_Ehdr* ehdr = (Elf32_Ehdr*) data_buf;
    Elf32_Phdr* phdr = (Elf32_Phdr*) &data_buf[ehdr->e_phoff];

    memset(&_MODULE_BASE, 0, (size_t)&_MODULE_SIZE);

    for (int i = 0; i < ehdr->e_phnum; i++) {
        if (phdr[i].p_type == PT_LOAD) {
            xil_printf("[m] seg %d: 0x%x -> 0x%x (%d bytes)\n\r",
                       i, phdr[i].p_offset, phdr[i].p_paddr, phdr[i].p_filesz);
            memcpy((void*)phdr[i].p_paddr, data_buf + phdr[i].p_offset, phdr[i].p_filesz);
        }
    }

    void* entrypoint = (void*) ehdr->e_entry;
    xil_printf("[m] jumping to 0x%x\n\r", entrypoint);
    ((void (*)(void))entrypoint)();

    memset(&_MODULE_BASE, 0, (size_t)&_MODULE_SIZE);
}

int main()
{
    init_platform();

    print("[riscv] Initialized.\n\r");

    int c = 0;

    while (1) {
        if (intr_triggered) {
            xil_printf("[riscv] Handling IRQ: 0x%08X.\n", SHARED_OCM->command);
            SHARED_OCM->executing = 1;

            uint32_t cmd = SHARED_OCM->command;

            if (cmd == CMD_LOAD_ELF) {
                /* Original: ELF in OCM data[] */
                xil_printf("[m] LOADING ELF from OCM\r\n");
                load_elf_from_buf((char*)SHARED_OCM->data);

            } else if (cmd == CMD_LOAD_ELF_DRAM) {
                /* DRAM pointer mode: data[0]=addr, data[1]=size */
                uint32_t dram_addr = SHARED_OCM->data[0];
                uint32_t elf_size  = SHARED_OCM->data[1];
                xil_printf("[m] LOADING ELF from DRAM @ 0x%08X (%d bytes)\r\n",
                           dram_addr, elf_size);
                load_elf_from_buf((char*)dram_addr);

            } else if (cmd == CMD_LOAD_SEG) {
                /* Chunked mode: copy one segment to destination */
                uint32_t dest = SHARED_OCM->data[0];
                uint32_t size = SHARED_OCM->data[1];
                xil_printf("[m] LOAD_SEG: %d bytes -> 0x%08X\r\n", size, dest);
                memcpy((void*)dest, (void*)&SHARED_OCM->data[2], size);

            } else if (cmd == CMD_EXEC) {
                /* Chunked mode: execute at entry point */
                uint32_t entry = SHARED_OCM->data[0];
                xil_printf("[m] EXEC @ 0x%08X\r\n", entry);
                ((void (*)(void))entry)();
                memset(&_MODULE_BASE, 0, (size_t)&_MODULE_SIZE);

            } else {
                xil_printf("[m] unknown cmd: 0x%08X\r\n", cmd);
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