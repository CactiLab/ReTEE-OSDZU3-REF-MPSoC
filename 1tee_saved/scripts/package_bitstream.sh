updatemem -force \
	-meminfo ../platform_riscv/hw/sdt/OSDZU3x_BYOTEE_wrapper.mmi \
	-bit ../platform_riscv/hw/sdt/OSDZU3x_BYOTEE_wrapper.bit \
	-data ../riscv_firmware/build/riscv_firmware.elf \
	-proc OSDZU3x_BYOTEE_i/microblaze_riscv_0 \
	-out system_fw.bit \
	-force

rm *.log *.jou