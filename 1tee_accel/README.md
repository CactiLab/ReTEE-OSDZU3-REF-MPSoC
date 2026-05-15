# 1tee_accel — Accelerated ML inference on BYOTEE RISC-V

This example project runs an INT8 quantised person-detection model (MobileNet
0.25, 96×96 grayscale) on a MicroBlaze V (RISC-V) soft core inside the PL of a
Xilinx Zynq UltraScale+ (xczu3eg, OSDZU3 board). A custom HLS-generated
convolution accelerator (`conv_accel`) handles the heavy pointwise and
depthwise convolutions; the ARM Cortex-A53 PS runs PetaLinux and acts as the
camera + network frontend.

For the system-wide setup (SD card, Vivado/Vitis install, board boot), see the
top-level [README](../README.md). This document covers what lives in
`1tee_accel/` and how to use it.

## Architecture at a glance

```
              ┌──────────────────────────┐
   camera ──> │ ARM Cortex-A53 (Linux)   │ ── TCP ──> pyclient_linux_ml
              │  linux_ml / load_app     │
              └──────────┬───────────────┘
                         │ OCM @ 0xFFFC0000 (IPC) + DRAM staging
              ┌──────────┴───────────────┐
              │ MicroBlaze V (rv32imf)   │
              │  riscv_firmware  ──────► │ loads + runs SSA ELFs
              │     │                    │
              │     └─> ML_SSA (TFLM)    │
              │           │              │
              │           └──> conv_accel│ (HLS IP, INT8 pointwise / depthwise)
              └──────────────────────────┘
                         │
              act_bram_a / act_bram_b / weight BRAM
```

- **ARM PS (Linux):** captures V4L2 frames, ships them to the RISC-V via DRAM
  staging + OCM IPC, streams annotated frames to a TCP client.
- **RISC-V PL (firmware):** ELF loader. Receives an SSA ELF from the PS, copies
  its segments into BRAM, jumps to `module_main`.
- **ML_SSA (SSA module):** TFLM interpreter with two custom kernels
  (`Conv2D`, `DepthwiseConv2D`) that dispatch to the HLS accelerator when the
  layer fits, falling back to software otherwise.
- **conv_accel:** Vitis HLS IP at 100 MHz. Provides per-channel INT8 1×1 and
  3×3 depthwise convolutions with TFLite-compatible requantisation.

See [NOTES.md](NOTES.md) for the design rationale, memory map, bugs found,
and performance history. See [USAGE.md](USAGE.md) for the conv_accel
register map, BRAM layout, and stand-alone integration guide.

## Folder layout

### Vitis components (RISC-V / PL)

| Folder | Target | Purpose |
|--------|--------|---------|
| [conv_accel/](conv_accel/) | Vitis HLS | The accelerator IP (`accel.cpp` + testbench). Synthesises to `xilinx.com:hls:conv_accel:1.0`. |
| [riscv_firmware/](riscv_firmware/) | MicroBlaze V | Stays in BRAM forever. ELF loader + OCM/DRAM IPC. Gets baked into `system_fw.bit` via `updatemem`. |
| [ML_SSA/](ML_SSA/) | MicroBlaze V | Person-detection SSA. TFLM + accelerated `custom_ops`. Built as an ELF and loaded dynamically by the firmware. |
| [ML_SSA_unaccel/](ML_SSA_unaccel/) | MicroBlaze V | Same model, software-only kernels — used to baseline accelerator speedup. |
| [ML_SSA_secure/](ML_SSA_secure/) | MicroBlaze V | WIP secure variant (see also `1tee_accel_secure/` at the repo root). |
| [embench/](embench/) | MicroBlaze V | Standard embench benchmark suite for the RISC-V core, for CPU-only timing. |

### Vitis components (ARM Cortex-A53, Linux)

| Folder | Purpose |
|--------|---------|
| [linux_ml/](linux_ml/) | Linux app: captures from V4L2, drives the RISC-V SSA over OCM/DRAM, streams YUYV frames + detection scores to a TCP client on port 8080. |
| [linux_ml_cortex_inference/](linux_ml_cortex_inference/) | Same camera + TCP pipeline but runs TFLM inference on the A53 — Cortex-side baseline. |
| [load_app/](load_app/) | Minimal SSA loader. Pushes an arbitrary ELF (e.g. `embench.elf`) to the RISC-V, sends `CMD_RUN`, prints results. Default: `/tmp/embench.elf` at DRAM 0x50000000. |

### Other

| Folder / file | Purpose |
|---------------|---------|
| [platform/](platform/) | Vitis platform project (Linux + psu_cortexa53). Holds the FSBL, PMU firmware, device tree, and the packaged `.bit`/`.mmi`. **Not committed** — generate locally; see top-level README. |
| [pyclient_linux_ml/](pyclient_linux_ml/) | Host-side Python viewer for the `linux_ml` TCP stream. |
| `common` (symlink) | → `../xilinx-zynqmp-common-v2025.1/` (Xilinx common image; provides `bl31.elf`, `u-boot.elf` for `linux.bif`). |
| `design_1tee_accel_704.xsa` | Exported hardware design (block design with MicroBlaze V + conv_accel + BRAMs). |
| `linux.bif` | bootgen recipe that assembles `BOOT.bin` from FSBL + PMUFW + bitstream + bl31 + DTB + u-boot. |

## Build and deploy

### One-time prerequisites

- Vitis 2025.2 with the workspace at `1tee_accel/`.
- TFLM tree built at [`../tflm-tree/`](../tflm-tree/) (sibling of `1tee_accel/`
  in this repo). The RISC-V SSAs link against the rv32imf hard-float build
  (`build-riscv-hfloat/libtflm.a`, produced by `make riscv-hfloat`); the
  Cortex-A inference baseline links against `build-cortexa-neon/libtflm.a`
  (produced by `make cortexa-neon`). Paths are wired up in each component's
  `UserConfig.cmake`.
- `common` symlink pointing at the extracted Xilinx ZynqMP common image
  (`bl31.elf`, `u-boot.elf`).
- The platform project (`platform/`) generated as described in the top-level
  README — it must produce `platform/hw/sdt/*.bit` and `*.mmi`.

### 1. Build the ELFs (in Vitis)

Build, in order:

1. `riscv_firmware` → `riscv_firmware/build/riscv_firmware.elf` (baked into the bitstream).
2. `ML_SSA` → `ML_SSA/build/ML_SSA.elf` (loadable module).
3. Optionally: `ML_SSA_unaccel`, `embench`, `linux_ml`, `linux_ml_cortex_inference`, `load_app`.

`ML_SSA` links against `riscv_firmware.elf` for shared symbols, so the firmware
must be built first. See [NOTES.md](NOTES.md#build-notes) for the
`TF_LITE_STATIC_MEMORY` requirement and other build gotchas.

### 2. Package the bitstream (Makefile)

The Makefile in this directory bakes the RISC-V firmware ELF into the BRAM
contents of the exported bitstream, then runs `bootgen` to produce `BOOT.bin`.

```
make help          # show all targets and current variables
make package       # updatemem → system_fw.bit
make boot          # bootgen   → BOOT.bin   (also depends on system_fw.bit)
make               # package + boot
make clean         # remove system_fw.bit and BOOT.bin
make debug         # print resolved paths
```

Variables (override on the command line):

- `PLATFORM_PROJ` (default `platform`) — folder holding `hw/sdt/*.bit` + `*.mmi`.
- `FIRMWARE_PROJ` (default `riscv_firmware`) — RISC-V firmware project, baked into BRAM.
- `SSA_PROJ` (default `ML_SSA`) — only used as a dependency check.
- `PETALINUX_IP` (default `192.168.1.117`) — used by `make deploy` and the `copy_*.sh` scripts.

Copy the resulting `BOOT.bin` to the BOOT partition of your SD card and boot
the board.

### 3. Deploy and run an SSA

After the board is up, run a Linux frontend on the board (`linux_ml`,
`linux_ml_cortex_inference`, or `load_app`) and push the SSA ELF from your
workstation.

Helper scripts (set `PETALINUX_IP` inside each before use):

| Script | Sends |
|--------|-------|
| [copy.sh](copy.sh) | `ML_SSA/build/ML_SSA.elf` → `petalinux@<IP>:/tmp/` |
| [copy_unaccel.sh](copy_unaccel.sh) | `ML_SSA_unaccel/build/ML_SSA.elf` → `/tmp/` |
| [copy_bench.sh](copy_bench.sh) | `embench/build/embench.elf` → `/tmp/` |
| `make deploy` | Same as `copy.sh`, honours `PETALINUX_IP=…` override |

Typical demo loop (camera person-detection):

```
# workstation: build + flash
make                       # produces BOOT.bin
./copy.sh                  # scp ML_SSA.elf to /tmp on the board

# board (over serial / ssh)
/tmp/linux_ml /tmp/ML_SSA.elf

# workstation: view the stream
cd pyclient_linux_ml
pip install -r requirements.txt
python3 client.py <board_ip>          # opens an OpenCV window
```

For a CPU-only baseline run `linux_ml_cortex_inference` instead — it runs the
exact same model on the A53 without touching the RISC-V or the accelerator.

For arbitrary modules (e.g. embench), use `load_app`:

```
./copy_bench.sh
/tmp/load_app /tmp/embench.elf 0x50000000
```

## Useful entry points

- Accelerator HLS source: [conv_accel/accel.cpp](conv_accel/accel.cpp), [conv_accel/accel.h](conv_accel/accel.h)
- TFLM custom kernels (HW dispatch): [ML_SSA/src/custom_ops.cpp](ML_SSA/src/custom_ops.cpp)
- Bare-metal accelerator driver: [ML_SSA/src/conv_accel_driver.h](ML_SSA/src/conv_accel_driver.h)
- RISC-V firmware loader / IPC: [riscv_firmware/src/main.c](riscv_firmware/src/main.c)
- Linux frontend (camera + TCP): [linux_ml/src/main.c](linux_ml/src/main.c)
- Host viewer: [pyclient_linux_ml/client.py](pyclient_linux_ml/client.py)
