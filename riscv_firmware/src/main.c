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

bool loaded = false;
bool intr_triggered = false;

int main()
{
    init_platform();

    print("[riscv] Hello World\n\r");
    print("[riscv] Successfully ran Hello World application\n\r");
    xil_printf("MODULE_BASE: 0x%x, SZ: 0x%x\n\r", &_MODULE_BASE, &_MODULE_SIZE);

    int c = 0;

    while (1) {
        if (intr_triggered) {
            SHARED_OCM->executing = 1;
            if (SHARED_OCM->command == 0x44414F4C && !loaded) {
                // parse elf header
                xil_printf("[m] LOAD ELF CMD\r\n");
                char* data_buf = SHARED_OCM->data;
                if (SHARED_OCM->data[0] == 0x464C457F) { //magic bytes
                    loaded = true;
                    Elf32_Ehdr* ehdr = (Elf32_Ehdr*) data_buf;
                    Elf32_Phdr* phdr = (Elf32_Phdr*) &data_buf[ehdr->e_phoff];
                    //char* module_mem = &_MODULE_BASE;
                    for (int i = 0; i < ehdr->e_phnum; i++) {
                        // xil_printf("i: %d, type: %d, phdr: %x paddr: %x sz: %x\r\n", i, phdr[i].p_type, phdr[i].p_offset, phdr[i].p_paddr, phdr[i].p_filesz);
                        if (phdr[i].p_type == PT_LOAD) {
                            memcpy(phdr[i].p_paddr, data_buf + phdr[i].p_offset, phdr[i].p_filesz);
                        }
                    }
                    void* entrypoint = (void*) ehdr->e_entry;
                    //xil_printf("entrypoint: 0x%x | entrypoint2: 0x%x\n\r", entrypoint, (&_MODULE_BASE) + ehdr->e_entry);
                    ((void (*)(void))entrypoint)();
                } else {
                    xil_printf("[m] IRQ: ELF not found. Magic: %x\n\r", SHARED_OCM->data[0]);
                }
            } else {
                xil_printf("not load elf. Cmd: 0x%08X loaded: %d\r\n", SHARED_OCM->command, loaded);
            }
            intr_triggered = false;
            SHARED_OCM->executing = 0;
            SHARED_OCM->ready = 1;
        }
        msleep(580);
        xil_printf("[riscv] cycle: %d\n\r", c);
        ++c;
    }

    cleanup_platform();
    return 0;
}

// extern uintptr_t _ELF_START;
// extern uintptr_t _FW_SYMBOL_TABLE;

// void symbol_table_demo() {
//     uintptr_t file_buf = 
//     Elf64_Ehdr* hdr = (Elf64_Ehdr*) file_buf;
//     Elf64_Phdr* segments = (Elf64_Phdr*)(file_buf + hdr->e_phoff);
//     Elf64_Addr DYNAMIC_addr = 0;
//     Elf64_Addr DYNAMIC_size = 0;
//     for(int i = 0; i < hdr->e_phnum; i++) {
//     	if(segments[i].p_flags & PT_DYNAMIC && segments[i].p_align < 0x1000 && segments[i].p_memsz > 0) {
//     		DYNAMIC_addr = segments[i].p_vaddr;
//     		DYNAMIC_size = segments[i].p_memsz;
//             break;
//     	}
//     }
//     Elf64_Dyn* df = file_buf + DYNAMIC_addr;
//     unsigned long long dt_vals[40];
//     memset(dt_vals, 0, sizeof(dt_vals));
//     for(int i = 0; i < DYNAMIC_size/sizeof(Elf64_Dyn); i++) {
//         if(df[i].d_tag == DT_NULL) { break; }
//         if(df[i].d_tag > 40) {continue;}
//         dt_vals[df[i].d_tag] = df[i].d_un.d_val;        
//     }
//     STRTAB = dt_vals[DT_STRTAB];
//     SYMTAB = dt_vals[DT_SYMTAB];
//     uint32_t* hash = dt_vals[DT_HASH];
//     SYMTAB_CT = hash[1];
//     char strworkspace[256];
//     memset(strworkspace, 0, sizeof(strworkspace));
//     for (int i = 0; i < SYMTAB_CT; i++) {
//         Elf64_Sym symbol = SYMTAB[i];
//         char* name = &STRTAB[symbol.st_name];
//         decrypt_string(ptrace_encrypted, STRLEN(ptrace_encrypted), strworkspace);
//         if(!ptrace_func && my_strstr(name, strworkspace)) {
//             ptrace_func = file_buf + symbol.st_value;
//         }
//         decrypt_string(dlsym_encrypted, STRLEN(dlsym_encrypted), strworkspace);
//         if(!dlsym_func && my_strstr(name, strworkspace)) {
//             dlsym_func = file_buf + symbol.st_value;
//         }
//         decrypt_string(dlopen_encrypted, STRLEN(dlopen_encrypted), strworkspace);
//         if(!dlopen_func && my_strstr(name, strworkspace)) {
//             dlopen_func = file_buf + symbol.st_value;
//         }
//     }
// }