#!/bin/bash
# PETALINUX_IP=10.0.0.15
PETALINUX_IP=10.42.0.65
# PETALINUX_IP=192.168.1.117
scp ./embench/build/embench.elf petalinux@${PETALINUX_IP}:/tmp/
