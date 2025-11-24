import os

PLATFORM_PROJ = ""


COMMAND = "updatemem" 
ARGS = ["-force"]
MEMINFO = PLATFORM_PROJ+"/hw/sdt/*.mmi" + 
	-meminfo ../platform_riscv/hw/sdt/*.mmi \
	-bit ../platform/hw/sdt/*.bit \
	-data ../riscv_firmware/build/riscv_firmware.elf \
	-proc OSDZU3x_BYOTEE_i/microblaze_riscv_0 \
	-out system_fw.bit \
	-force


bootgen -image sd_boot.bif -arch zynqmp -o C:\edt\BOOT.bin