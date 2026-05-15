#!/bin/bash
# PETALINUX_IP=10.0.0.15
PETALINUX_IP=192.168.1.117
scp ./ML_SSA_unaccel/build/ML_SSA.elf petalinux@${PETALINUX_IP}:/tmp
