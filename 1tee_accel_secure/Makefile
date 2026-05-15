# Platform project variable (can be overridden from command line)
PLATFORM_PROJ ?= platform
FIRMWARE_PROJ ?= riscv_firmware_secure
SSA_PROJ      ?= ML_SSA_secure
# Input file paths
MMI_DIR  := $(PLATFORM_PROJ)/hw/sdt
BIT_DIR  := $(PLATFORM_PROJ)/hw/sdt
ELF_FILE := $(FIRMWARE_PROJ)/build/$(FIRMWARE_PROJ).elf
SSA_ELF  := $(SSA_PROJ)/build/$(SSA_PROJ).elf
# Secure-loader tooling and key material
KEY_FILE ?= key.bin
PACK     := ./pack_elf.py
# Derived secure outputs: keyed firmware ELF (key injected into aes_key
# symbol) and PEL2-packed SSA bundle (AES-128-CTR + HMAC-SHA512).
ELF_KEYED  := $(FIRMWARE_PROJ)/build/$(FIRMWARE_PROJ).keyed.elf
SSA_BUNDLE := $(SSA_PROJ)/build/$(SSA_PROJ).pel2
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
# Generate a fresh AES-128 key if one isn't already present. Persisted so
# rebuilds keep producing bundles the firmware-baked key can decrypt;
# `make clean` deliberately does not delete it.
$(KEY_FILE):
	@echo "Generating fresh AES-128 key -> $@"
	dd if=/dev/urandom of=$@ bs=16 count=1 status=none
# Inject the AES key into the firmware ELF's `aes_key` symbol. pack_elf.py
# auto-detects inject mode from the symbol's presence.
$(ELF_KEYED): $(ELF_FILE) $(KEY_FILE) $(PACK)
	@echo "Injecting AES key into firmware ELF..."
	$(PACK) --key $(KEY_FILE) $(ELF_FILE) $@
# Encrypt+authenticate the SSA ELF into a PEL2 bundle. Same key as the
# firmware was patched with, otherwise the loader's HMAC check fails.
.PHONY: ssa-bundle
ssa-bundle: $(SSA_BUNDLE)
$(SSA_BUNDLE): $(SSA_ELF) $(KEY_FILE) $(PACK)
	@echo "Packing SSA ELF -> PEL2 bundle..."
	$(PACK) --key $(KEY_FILE) $(SSA_ELF) $@
# Main target to generate the firmware bitstream. The bit gets the *keyed*
# firmware ELF baked into BRAM; the PEL2 bundle is deployed separately.
$(OUTPUT_BIT): $(ELF_KEYED) $(SSA_BUNDLE) $(MMI_FILE) $(BIT_FILE)
	@echo "Building firmware bitstream..."
	@echo "  MMI file:   $(MMI_FILE)"
	@echo "  BIT file:   $(BIT_FILE)"
	@echo "  FW  ELF:    $(ELF_KEYED)"
	@echo "  SSA bundle: $(SSA_BUNDLE)"
	@if [ -z "$(MMI_FILE)" ]; then \
        echo "Error: No .mmi file found in $(MMI_DIR)"; \
        exit 1; \
    fi
	@if [ -z "$(BIT_FILE)" ]; then \
        echo "Error: No .bit file found in $(BIT_DIR)"; \
        exit 1; \
    fi
	@if [ ! -f "$(ELF_KEYED)" ]; then \
        echo "Error: keyed FW ELF not found: $(ELF_KEYED)"; \
        exit 1; \
    fi
	@if [ ! -f "$(SSA_BUNDLE)" ]; then \
        echo "Error: SSA bundle not found: $(SSA_BUNDLE)"; \
        exit 1; \
    fi
	$(UPDATEMEM) -force \
        -meminfo $(MMI_FILE) \
        -bit $(BIT_FILE) \
        -data $(ELF_KEYED) \
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
# Deploy PEL2 bundle (not the raw SSA ELF) to PetaLinux target
.PHONY: deploy
deploy: $(SSA_BUNDLE)
	scp $(SSA_BUNDLE) petalinux@$(PETALINUX_IP):/tmp/
# Clean target. Leaves $(KEY_FILE) alone on purpose — deleting it would
# desync new bundles from an already-deployed firmware bitstream.
.PHONY: clean
clean:
	rm -f $(OUTPUT_BIT) BOOT.bin $(ELF_KEYED) $(SSA_BUNDLE)
# Help target
.PHONY: help
help:
	@echo "Makefile for generating firmware bitstream (1tee_accel_secure)"
	@echo ""
	@echo "Usage:"
	@echo "  make                        - Build system_fw.bit + BOOT.bin"
	@echo "  make package                - Build system_fw.bit only"
	@echo "  make ssa-bundle             - Build the PEL2-packed SSA bundle only"
	@echo "  make boot                   - Build BOOT.bin from system_fw.bit"
	@echo "  make deploy                 - scp PEL2 bundle to PetaLinux target"
	@echo "  make deploy PETALINUX_IP=x  - Deploy to custom IP"
	@echo "  make clean                  - Remove generated files (keeps $(KEY_FILE))"
	@echo ""
	@echo "Current settings:"
	@echo "  PLATFORM_PROJ: $(PLATFORM_PROJ)"
	@echo "  FIRMWARE_PROJ: $(FIRMWARE_PROJ)"
	@echo "  SSA_PROJ:      $(SSA_PROJ)"
	@echo "  KEY_FILE:      $(KEY_FILE)"
	@echo "  PETALINUX_IP:  $(PETALINUX_IP)"
# Debug target to show resolved paths
.PHONY: debug
debug:
	@echo "PLATFORM_PROJ: $(PLATFORM_PROJ)"
	@echo "MMI_FILE:      $(MMI_FILE)"
	@echo "BIT_FILE:      $(BIT_FILE)"
	@echo "ELF_FILE:      $(ELF_FILE)"
	@echo "ELF_KEYED:     $(ELF_KEYED)"
	@echo "SSA_ELF:       $(SSA_ELF)"
	@echo "SSA_BUNDLE:    $(SSA_BUNDLE)"
	@echo "KEY_FILE:      $(KEY_FILE)"
	@echo "OUTPUT_BIT:    $(OUTPUT_BIT)"
	@echo "UPDATEMEM:     $(UPDATEMEM)"
	@echo "BOOTGEN:       $(BOOTGEN)"
