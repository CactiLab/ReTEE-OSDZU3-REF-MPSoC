# BYOTee-Octavo-Extension

# Pre-requisites

Xilinx Vivado 2025.1 and Vitis 2025.1: [https://www.xilinx.com/support/download.html]

Xilinx ZYNQMP common image: [https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html]
- Scroll to "Common Images for Embedded Vitis™ Platforms" and download "ZYNQMP common image".
Download and extract this wherever you like. It is suggested to put it at the root of this repository.

# Building and running the example projects

## SD Card setup

After extracting the ZYNQMP common image to the desired path, the following:

Create a boot partition on the sd card (2GB should be enough).
```COMMAND_GOES_HERE```

Extract ```rootfs.tar.gz``` from the ZYNQMP common image. It should produce ```rootfs.ext4```

Flash ```rootfs.ext4``` to another partition on the SD card.

## In Vivado

### Importing a hardware design

By default, the example hardware designs are included as ```.xsa``` files.

However, you may choose to build them yourself from the ```.tcl``` files under ```hardware_designs```.

## In Vitis

### Symlink to common image

Create a symlink to the ZYNQMP common image directory by running ```ln -s ./common $(PATH_TO_ZYNQMP_COMMON)``` in an example project directory.

### Creating the platform project

The platform project is not included in the repository due to size constraints. 

It can be generated from the following steps:

- Go to File -> New Component -> Platform
- choose a name for the platform project and remember it for later (or use the name "platform" to fit the default scripts), continue.
- Choose the Hardware Design .xsa file exported earlier, continue.
- Choose "Linux" when selecting the Operating System
- Choose "psu_cortexa53" when selecting the Processor
- Make sure "Generate Boot Artifacts" is enabled. Under this tab, enable "Generate PMU Firmware". Ensure the target processor for the FSBL is psu_cortexa53_0.
- Under "Generate Device Tree Blob (DTB)", select ```custom.dtsi``` (in the repository root) for the Custom Linux DTSI; continue.
- Click "Finish". 

At this point, the platform project should be generated.

### Building and packaging firmware [system_fw.bit]

In Vitis, build the "riscv_firmware" project to generate an ELF image.

The included Makefile under each example project will package the PL microblaze firmware into the hardware XSA image.

This can be done by running ```make package``` in an example project root (after building the ELF).

### Building a boot image [BOOT.bin]

Requirements: the above steps to create ```system_fw.bit``` and ```design_*tee.xsa```

- Go to Vitis -> Create Boot Image -> Zyunq Ultrascale+
- Choose "Import existing BIF file"
- For "Import BIF File Path", select "linux.bif" at the root of the example project.
- Select "Create Image"

BOOT.bin should now be generated in the root of the example project. This should be copied to the "boot" partition of the SD card.

## Booting the board

On the OSDZU3 board, set the "BOOT MODE" to SD card boot. It should be [1, 0, 1, 0].

Turn the device on, and connect to it with the TTY console.

Press a key to exit to the uboot console environment.

Run the following commands:
```setenv bootargs 'root=/dev/mmcblk1p2 rootfstype=ext4 rootwait rw init=/bin/sh'```
```boot```
This will give you the ability to set a root password with: ```passwd root```

## Loading and Running SSAs

WIP