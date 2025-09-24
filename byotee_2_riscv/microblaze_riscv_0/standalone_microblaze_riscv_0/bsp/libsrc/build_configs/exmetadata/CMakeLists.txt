
cmake_minimum_required(VERSION 3.15)
project(bsp)

# Use CMAKE_LIBRARY_PATH in link_directories
link_directories(${CMAKE_LIBRARY_PATH})
        
set(DRIVER_TARGETS gpio;intc;bram;zdma;sysmonpsu;axipmon;clockps;csudma;emacps;gpiops;iicps;qspipsu;rtcpsu;sdps;spips;ttcps;uartps;wdtps)
set(DRIVER_LOCATIONS /tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/gpio_v4_12;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/intc_v3_20;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/bram_v4_12;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/zdma_v1_20;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/sysmonpsu_v3_1;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/axipmon_v6_12;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/clockps_v1_6;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/csudma_v1_17;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/emacps_v3_22;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/gpiops_v3_14;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/iicps_v3_21;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/qspipsu_v1_21;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/rtcpsu_v1_15;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/sdps_v4_4;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/spips_v3_12;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/ttcps_v3_21;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/uartps_v3_16;/tools/Xilinx/2025.1/Vitis/data/embeddedsw/XilinxProcessorIPLib/drivers/wdtps_v3_8)

list(LENGTH DRIVER_TARGETS no_of_drivers)
set(index 0)

while(${index} LESS ${no_of_drivers})
    list(GET DRIVER_TARGETS ${index} drv)
    list(GET DRIVER_LOCATIONS ${index} drv_dir)
    set(exp_dir "${drv_dir}/examples")
    add_custom_target(
        ${drv}_example ALL
        COMMAND lopper -f -O /home/e/Documents/research/byotee/byotee_2_riscv/microblaze_riscv_0/standalone_microblaze_riscv_0/bsp/libsrc/${drv} /home/e/Documents/research/byotee/byotee_2_riscv/microblaze_riscv_0/standalone_microblaze_riscv_0/bsp/hw_artifacts/microblaze_riscv_0_baremetal.dts -- bmcmake_metadata_xlnx microblaze_riscv_0 ${exp_dir} drvcmake_metadata
        BYPRODUCTS x${drv}_exlist.yaml)
    MATH(EXPR index "${index}+1")
endwhile()
