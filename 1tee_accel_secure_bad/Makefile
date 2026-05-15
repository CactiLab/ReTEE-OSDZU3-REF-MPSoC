# Platform project variable (can be overridden from command line)
PLATFORM_PROJ ?= platform
FIRMWARE_PROJ ?= riscv_firmware
SSA_PROJ ?= ML_SSA
# Input file paths
MMI_DIR := $(PLATFORM_PROJ)/hw/sdt
BIT_DIR := $(PLATFORM_PROJ)/hw/sdt
ELF_FILE := $(FIRMWARE_PROJ)/build/$(FIRMWARE_PROJ).elf
SSA_ELF := $(SSA_PROJ)/build/$(SSA_PROJ).elf
# Output file
OUTPUT_BIT := system_fw.bit
# Processor path
PROC_PATH := design_1tee_i/microblaze_riscv_0
# Find updatemem under Vivado install
UPDATEMEM := $(shell command -v updatemem 2>/dev/null || \
    find /tools/Xilinx -path "*/Vivado/bin/updatemem" 2>/dev/null | head -1)
# Find bootgen under Vitis/Vivado install
BOOTGEN := $(shell command -v bootgen 2>/dev/null || \
    find /tools/Xilinx -path "*/Vitis/bin/bootgen" 2>/dev/null | head -1 || \
    find /tools/Xilinx -path "*/Vivado/bin/bootgen" 2>/dev/null | head -1)
# Find the actual files (using wildcard function)
MMI_FILE := $(wildcard $(MMI_DIR)/*.mmi)
BIT_FILE := $(wildcard $(BIT_DIR)/*.bit)
# PetaLinux target for SSA deploy
PETALINUX_IP ?= 192.168.1.117
# Default target
.PHONY: all
all: package boot
.PHONY: package
package: $(OUTPUT_BIT)
# Main target to generate the firmware bitstream
$(OUTPUT_BIT): $(ELF_FILE) $(SSA_ELF) $(MMI_FILE) $(BIT_FILE)
	@echo "Building firmware bitstream..."
	@echo "  MMI file: $(MMI_FILE)"
	@echo "  BIT file: $(BIT_FILE)"
	@echo "  FW  ELF:  $(ELF_FILE)"
	@echo "  SSA ELF:  $(SSA_ELF)"
	@if [ -z "$(MMI_FILE)" ]; then \
        echo "Error: No .mmi file found in $(MMI_DIR)"; \
        exit 1; \
    fi
	@if [ -z "$(BIT_FILE)" ]; then \
        echo "Error: No .bit file found in $(BIT_DIR)"; \
        exit 1; \
    fi
	@if [ ! -f "$(ELF_FILE)" ]; then \
        echo "Error: FW ELF not found: $(ELF_FILE)"; \
        exit 1; \
    fi
	@if [ ! -f "$(SSA_ELF)" ]; then \
        echo "Error: SSA ELF not found: $(SSA_ELF)"; \
        exit 1; \
    fi
	$(UPDATEMEM) -force \
        -meminfo $(MMI_FILE) \
        -bit $(BIT_FILE) \
        -data $(ELF_FILE) \
        -proc $(PROC_PATH) \
        -out $(OUTPUT_BIT) \
        -force
	rm -f *.jou *.log
.PHONY: boot
boot: $(OUTPUT_BIT)
	@if [ -z "$(BOOTGEN)" ]; then \
        echo "Error: bootgen not found in PATH or /tools/Xilinx"; \
        exit 1; \
    fi
	$(BOOTGEN) -arch zynqmp -image linux.bif -o BOOT.bin -w
# Deploy SSA ELF to PetaLinux target
.PHONY: deploy
deploy: $(SSA_ELF)
	scp $(SSA_ELF) petalinux@$(PETALINUX_IP):/tmp/
# Clean target
.PHONY: clean
clean:
	rm -f $(OUTPUT_BIT) BOOT.bin
# Help target
.PHONY: help
help:
	@echo "Makefile for generating firmware bitstream (1tee_accel)"
	@echo ""
	@echo "Usage:"
	@echo "  make                        - Build system_fw.bit + BOOT.bin"
	@echo "  make package                - Build system_fw.bit only"
	@echo "  make boot                   - Build BOOT.bin from system_fw.bit"
	@echo "  make deploy                 - scp ML_SSA.elf to PetaLinux target"
	@echo "  make deploy PETALINUX_IP=x  - Deploy to custom IP"
	@echo "  make clean                  - Remove generated files"
	@echo ""
	@echo "Current settings:"
	@echo "  PLATFORM_PROJ: $(PLATFORM_PROJ)"
	@echo "  FIRMWARE_PROJ: $(FIRMWARE_PROJ)"
	@echo "  SSA_PROJ:      $(SSA_PROJ)"
	@echo "  PETALINUX_IP:  $(PETALINUX_IP)"
# Debug target to show resolved paths
.PHONY: debug
debug:
	@echo "PLATFORM_PROJ: $(PLATFORM_PROJ)"
	@echo "MMI_FILE: $(MMI_FILE)"
	@echo "BIT_FILE: $(BIT_FILE)"
	@echo "ELF_FILE: $(ELF_FILE)"
	@echo "SSA_ELF:  $(SSA_ELF)"
	@echo "OUTPUT_BIT: $(OUTPUT_BIT)"
	@echo "UPDATEMEM: $(UPDATEMEM)"
	@echo "BOOTGEN: $(BOOTGEN)"
