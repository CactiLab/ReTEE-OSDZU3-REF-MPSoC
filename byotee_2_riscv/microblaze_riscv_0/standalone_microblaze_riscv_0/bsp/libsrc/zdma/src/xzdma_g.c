#include "xzdma.h"

XZDma_Config XZDma_ConfigTable[] __attribute__ ((section (".drvcfg_sec"))) = {

	{
		"xlnx,zynqmp-dma-1.0", /* compatible */
		0xffa80000, /* reg */
		0x1, /* xlnx,dma-mode */
		0x0, /* dma-coherent */
		0x404d, /* interrupts */
		0xffff /* interrupt-parent */
	},
	{
		"xlnx,zynqmp-dma-1.0", /* compatible */
		0xffa90000, /* reg */
		0x1, /* xlnx,dma-mode */
		0x0, /* dma-coherent */
		0x404e, /* interrupts */
		0xffff /* interrupt-parent */
	},
	{
		"xlnx,zynqmp-dma-1.0", /* compatible */
		0xffaa0000, /* reg */
		0x1, /* xlnx,dma-mode */
		0x0, /* dma-coherent */
		0x404f, /* interrupts */
		0xffff /* interrupt-parent */
	},
	{
		"xlnx,zynqmp-dma-1.0", /* compatible */
		0xffab0000, /* reg */
		0x1, /* xlnx,dma-mode */
		0x0, /* dma-coherent */
		0x4050, /* interrupts */
		0xffff /* interrupt-parent */
	},
	{
		"xlnx,zynqmp-dma-1.0", /* compatible */
		0xffac0000, /* reg */
		0x1, /* xlnx,dma-mode */
		0x0, /* dma-coherent */
		0x4051, /* interrupts */
		0xffff /* interrupt-parent */
	},
	{
		"xlnx,zynqmp-dma-1.0", /* compatible */
		0xffad0000, /* reg */
		0x1, /* xlnx,dma-mode */
		0x0, /* dma-coherent */
		0x4052, /* interrupts */
		0xffff /* interrupt-parent */
	},
	{
		"xlnx,zynqmp-dma-1.0", /* compatible */
		0xffae0000, /* reg */
		0x1, /* xlnx,dma-mode */
		0x0, /* dma-coherent */
		0x4053, /* interrupts */
		0xffff /* interrupt-parent */
	},
	{
		"xlnx,zynqmp-dma-1.0", /* compatible */
		0xffaf0000, /* reg */
		0x1, /* xlnx,dma-mode */
		0x0, /* dma-coherent */
		0x4054, /* interrupts */
		0xffff /* interrupt-parent */
	},
	 {
		 NULL
	}
};