/******************************************************************************
* Copyright (C) 2023 - 2025 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

_STACK_SIZE = DEFINED(_STACK_SIZE) ? _STACK_SIZE : 0x4000;
_HEAP_SIZE = DEFINED(_HEAP_SIZE) ? _HEAP_SIZE : 0x1000;

/* Define Memories in the system */

MEMORY
{
	psu_ddr_0_memory_0 : ORIGIN = 0x40000000, LENGTH = 0x3ff00000
	psu_qspi_linear_0_memory_0 : ORIGIN = 0xd0000000, LENGTH = 0x10000000
	bram : ORIGIN = 0x0, LENGTH = 0xb0000
	psu_ocm_ram_0_memory_0 : ORIGIN = 0xfffc0000, LENGTH = 0x40000
	act_bram_a_cntlr_memory_0 : ORIGIN = 0xc1000000, LENGTH = 0x10000
	act_bram_b_cntlr_memory_1 : ORIGIN = 0xc2000000, LENGTH = 0x10000
}

/* Specify the default entry point to the program */

ENTRY(_boot)

/* Define the sections, and where they are mapped in memory */

SECTIONS
{
.text.init : {
   __text.init_start = .;
   *(.text.init)
   __text.init_end = .;
} > bram

.text : {
   . = ALIGN(2048);
   *(.text)
   *(.text.*)
   *(.gnu.linkonce.t.*)
} > bram

.note.gnu.build-id (NOLOAD): {
   KEEP (*(.note.gnu.build-id))
} > bram

.init : {
   KEEP (*(.init))
} > bram

.fini : {
   KEEP (*(.fini))
} > bram

.ctors : {
   __CTOR_LIST__ = .;
   ___CTORS_LIST___ = .;
   KEEP (*crtbegin.o(.ctors))
   KEEP (*(EXCLUDE_FILE(*crtend.o) .ctors))
   KEEP (*(SORT(.ctors.*)))
   KEEP (*(.ctors))
   __CTOR_END__ = .;
   ___CTORS_END___ = .;
} > bram

.dtors : {
   __DTOR_LIST__ = .;
   ___DTORS_LIST___ = .;
   KEEP (*crtbegin.o(.dtors))
   KEEP (*(EXCLUDE_FILE(*crtend.o) .dtors))
   KEEP (*(SORT(.dtors.*)))
   KEEP (*(.dtors))
   __DTOR_END__ = .;
   ___DTORS_END___ = .;
} > bram

.rodata : {
   __rodata_start = .;
   *(.rodata)
   *(.rodata.*)
   *(.gnu.linkonce.r.*)
   __rodata_end = .;
} > bram

.srodata : {
   __srodata_start = .;
   *(.srodata)
   __srodata_end = .;
} > bram

.sdata2 : {
   __sdata2_start = .;
   *(.sdata2)
   *(.sdata2.*)
   *(.gnu.linkonce.s2.*)
   __sdata2_end = .;
} > bram

.data : {
   __data_start = .;
   *(.data)
   *(.data.*)
   *(.gnu.linkonce.d.*)
   _edata = .;
} > bram

.got : {
   *(.got)
} > bram

.got1 : {
   *(.got1)
} > bram

.got2 : {
   *(.got2)
} > bram

.eh_frame : {
   *(.eh_frame)
} > bram

.jcr : {
   *(.jcr)
} > bram

.gcc_except_table : {
   *(.gcc_except_table)
} > bram

.init_array : {
   __init_array_start = .;
   KEEP (*(SORT(.init_array.*)))
   KEEP (*(.init_array))
   __init_array_end = .;
} > bram

.fini_array : {
   __fini_array_start = .;
   KEEP (*(SORT(.fini_array.*)))
   KEEP (*(.fini_array))
   __fini_array_end = .;
} > bram

.sdata : {
   __sdata_start = .;
   *(.sdata)
   *(.sdata.*)
   *(.gnu.linkonce.s.*)
   __sdata_end = .;
} > bram

.tdata : {
   __tdata_start = .;
   *(.tdata)
   *(.tdata.*)
   *(.gnu.linkonce.td.*)
   __tdata_end = .;
} > bram

.tbss : {
   __tbss_start = .;
   *(.tbss)
   *(.tbss.*)
   *(.gnu.linkonce.tb.*)
   __tbss_end = .;
} > bram

.bss (NOLOAD) : {
   __bss_start = .;
   *(.bss)
   *(.bss.*)
   *(.gnu.linkonce.b.*)
   *(COMMON)
   __bss_end = .;
} > bram

.sbss (NOLOAD) : {
   __sbss_start = .;
   *(.sbss)
   *(.sbss.*)
   *(.gnu.linkonce.sb.*)
   __sbss_end = .;
} > bram

.sbss2 (NOLOAD) : {
   __sbss2_start = .;
   *(.sbss2)
   *(.sbss2.*)
   *(.gnu.linkonce.sb2.*)
   __sbss2_end = .;
} > bram

_SDA_BASE_ = __sdata_start + ((__sbss_end - __sdata_start) / 2 );

_SDA2_BASE_ = __sdata2_start + ((__sbss2_end - __sdata2_start) / 2 );

/* Generate Stack and Heap definitions */

.heap (NOLOAD) : {
   . = ALIGN(8);
   _heap = .;
   _heap_start = .;
   . += _HEAP_SIZE;
   _heap_end = .;
} > bram

.stack (NOLOAD) : {
   _stack_end = .;
   . += _STACK_SIZE;
   . = ALIGN(8);
   _stack = .;
   __stack = _stack;
} > bram

__global_pointer$ = MIN(__sdata_start + 0x800, MAX(__data_start + 0x800, __bss_end - 0x800));
_end = .;
_MODULE_BASE = ALIGN(., 0x800);
_MODULE_SIZE = (ORIGIN(bram) + LENGTH(bram)) - _MODULE_BASE;
}