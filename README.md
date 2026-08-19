# What is this?

RETEE: Reconfigurable Trusted Execution Environments and Acceleration on FPGA SoCs

This is an updated implementation of [BYOTEE (Build Your Own Trusted Execution Environment)](). 

Essentially, it's an architecture that consists of custom processor(s) and resources within an FPGA fabric that physically isolates computation from a hardcore environment.

# Building and running example projects

## Pre-requisites

### Xilinx Vivado 2025.2 and Vitis 2025.2: 

[https://www.xilinx.com/support/download.html](https://www.xilinx.com/support/download.html)

### Xilinx ZYNQMP common image: 

[https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html)
- I used Petalinux 2025.1, but any build should work (we will be using the associated toolchain)
- Scroll to "Common Images for Embedded Vitis™ Platforms" and download "ZYNQMP common image".

Download and extract this wherever you like. It is suggested to put it at the root of this repository. It will be needed later.

Make sure to run ```./sdk.sh``` and install it to a directory of your choice. 
- I suggest leaving the default of ```/opt/petalinux/<PETALINUX_VERSION>```

## SD Card setup

After extracting the ZYNQMP common image to the desired path, do the following:

NOTE: ```<SD_CARD_DEVICE>``` should be something like ```mmcblk0```

### Create a boot partition on the sd card (2GB should be enough).

```
<SD_CARD_DEVICE> example: mmcblk0
```

```
sudo parted /dev/<SD_CARD_DEVICE> --script 
mklabel msdos 
mkpart primary fat32 1MiB 2GiB 
set 1 boot on 
mkpart primary ext4 2GiB 100%
```

quit gparted

```
<SD_CARD_DEVICE>p1 example: mmcblk0p1
```

```
sudo mkfs.vfat -F 32 -n BOOT /dev/<SD_CARD_DEVICE>p1
```

### Extract ```rootfs.tar.gz``` from the ZYNQMP common image. 

It should produce ```rootfs.ext4```

### Flash ```rootfs.ext4``` to another partition on the SD card.

```
<SD_CARD_DEVICE>p2 example: mmcblk0p2
```

```
sudo dd if=rootfs.ext4 of=/dev/<SD_CARD_DEVICE>p2 bs=4M status=progress
```

## In Vivado

### Importing a hardware design

By default, the example hardware designs are included as ```.xsa``` files.

However, you may choose to build them yourself from the ```.tcl``` files under ```hardware_designs```. 

Please use Vivado 2025.2 to import and build the hardware designs.


## In Vitis

### Symlink to common image

Create a symlink to the ZYNQMP common image directory by running ```ln -s $(PATH_TO_ZYNQMP_COMMON) ./common``` in an example project directory.

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

### Building and packaging firmware [system_fw.bit], [BOOT.bin]

In Vitis, build the "riscv_firmware" project to generate an ELF image.

The included Makefile under each example project will package the PL microblaze firmware into the hardware XSA image.

This can be done by running ```make boot``` in an example project root (after building the relevant ELF files).

Two artifacts are generated from this step: ```system_fw.bit```, and ```BOOT.bin```

Copy ```BOOT.bin``` to the BOOT partition of your sd card.

## Booting the board

On the OSDZU3 board, set the "BOOT MODE" to SD card boot. It should be [1, 0, 1, 0].

Turn the device on, and connect to it with the TTY console.

```sudo minicom -b 115200 -o -D /dev/ttyUSB1```

```sudo minicom -b 115200 -o -D /dev/ttyUSB0```

Press a key to exit to the uboot console environment.

Run the following commands:

```setenv bootargs 'root=/dev/mmcblk1p2 rootfstype=ext4 rootwait rw init=/bin/sh'```

```boot```

This will give you the ability to set a root password with: ```passwd root```

It is suggested to also setup a secondary account to copy binaries to with ```scp```. I used the name ```petalinux```, which is referenced in the ```./copy.sh``` scripts.

## Loading and Running SSAs

SSAs are loadable modules which add capabilities to the system. 

See the example projects for a reference design and API for loading and running SSAs.

# Architecture

See each example project for architecture specifics.

# Miscellaneous notes

The full vivado project for the ```1tee_accel``` block design is included as a zip in ```vivado_riscv_1tee_accel.zip```. Feel free to use this if the ```hardware_designs/*.tcl``` scripts are having issues.
