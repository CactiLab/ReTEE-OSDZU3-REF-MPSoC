# Platform project variable (can be overridden from command line)
PLATFORM_PROJ ?= platform
FIRMWARE_PROJ ?= riscv_firmware

# Input file paths
MMI_DIR := $(PLATFORM_PROJ)/hw/sdt
BIT_DIR := $(PLATFORM_PROJ)/hw/sdt
ELF_FILE := $(FIRMWARE_PROJ)/build/$(FIRMWARE_PROJ).elf

# Output file
OUTPUT_BIT := system_fw.bit

# Processor path
PROC_PATH := design_1tee_i/microblaze_riscv_0

# Find the actual files (using wildcard function)
MMI_FILE := $(wildcard $(MMI_DIR)/*.mmi)
BIT_FILE := $(wildcard $(BIT_DIR)/*.bit)

# Default target
.PHONY: package
package: $(OUTPUT_BIT)

# Main target to generate the firmware bitstream
$(OUTPUT_BIT): $(ELF_FILE) $(MMI_FILE) $(BIT_FILE)
	@echo "Building firmware bitstream..."
	@echo "  MMI file: $(MMI_FILE)"
	@echo "  BIT file: $(BIT_FILE)"
	@echo "  ELF file: $(ELF_FILE)"
	@if [ -z "$(MMI_FILE)" ]; then \
		echo "Error: No .mmi file found in $(MMI_DIR)"; \
		exit 1; \
	fi
	@if [ -z "$(BIT_FILE)" ]; then \
		echo "Error: No .bit file found in $(BIT_DIR)"; \
		exit 1; \
	fi
	@if [ ! -f "$(ELF_FILE)" ]; then \
		echo "Error: ELF file not found: $(ELF_FILE)"; \
		exit 1; \
	fi
	updatemem -force \
		-meminfo $(MMI_FILE) \
		-bit $(BIT_FILE) \
		-data $(ELF_FILE) \
		-proc $(PROC_PATH) \
		-out $(OUTPUT_BIT) \
		-force
	rm *.jou *.log

# Clean target
.PHONY: clean
clean:
	rm -f $(OUTPUT_BIT)

# Help target
.PHONY: help
help:
	@echo "Makefile for generating firmware bitstream"
	@echo ""
	@echo "Usage:"
	@echo "  make                    - Build system_fw.bit"
	@echo "  make PLATFORM_PROJ=xyz  - Build with custom platform project"
	@echo "  make clean              - Remove generated files"
	@echo "  make help               - Show this help message"
	@echo ""
	@echo "Current settings:"
	@echo "  PLATFORM_PROJ: $(PLATFORM_PROJ)"
	@echo "  MMI_DIR: $(MMI_DIR)"
	@echo "  BIT_DIR: $(BIT_DIR)"

# Debug target to show resolved paths
.PHONY: debug
debug:
	@echo "PLATFORM_PROJ: $(PLATFORM_PROJ)"
	@echo "MMI_FILE: $(MMI_FILE)"
	@echo "BIT_FILE: $(BIT_FILE)"
	@echo "ELF_FILE: $(ELF_FILE)"
	@echo "OUTPUT_BIT: $(OUTPUT_BIT)"