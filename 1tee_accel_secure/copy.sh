#!/bin/bash
# PETALINUX_IP=10.0.0.15
PETALINUX_IP=10.42.0.65
scp ./ML_SSA_secure/build/ML_SSA_secure.pel2 petalinux@${PETALINUX_IP}:/tmp/
