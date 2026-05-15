# TFLM Static Library

TensorFlow Lite for Microcontrollers, packaged as a static library for embedded targets.

## Build

| Command             | Target                        | Output                          |
| ------------------- | ----------------------------- | ------------------------------- |
| `make riscv-hfloat` | RISC-V 32-bit, hardware float | `build-riscv-hfloat/libtflm.a`  |
| `make riscv-sfloat` | RISC-V 32-bit, soft float     | `build-riscv-sfloat/libtflm.a`  |
| `make cortexa-neon` | ARMv8-A Cortex-A53 with NEON  | `build-cortexa-neon/libtflm.a`  |

Bare `make` builds `riscv-hfloat`.

## Toolchains

- **RISC-V**: Xilinx Vitis 2025.2 — `/tools/Xilinx/2025.2/gnu/riscv/lin/`
- **Cortex-A**: PetaLinux 2025.1 AArch64 sysroot — `/opt/petalinux/2025.1/sysroots/`

## Clean

- `make clean` — remove the current build directory
- `make clean-all` — remove all three build directories
