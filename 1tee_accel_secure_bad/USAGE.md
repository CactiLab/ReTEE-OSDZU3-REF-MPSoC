# conv_accel IP Integration Guide

## Overview

`conv_accel` is a Vitis HLS-generated IP that accelerates INT8 pointwise (1x1) and depthwise (3x3) convolutions for quantised MobileNet inference. It exposes:

- **1 AXI-Lite slave** (`s_axi_ctrl`) -- 17 layer-descriptor registers + ap_ctrl
- **3 BRAM ports** -- `weight_bram` (128 KB, ROM), `act_bram_a` and `act_bram_b` (48 KB each, RAM)
- **1 interrupt output** (`interrupt`)

Target: `xczu3eg-sfvc784-1-e` at 100 MHz.

## Prerequisites

1. Run HLS synthesis to produce the packaged IP:
   ```
   cd mac_accel
   vitis_hls -f hls_config.cfg
   ```
   The IP catalog entry is generated at:
   `mac_accel/mac_accel/conv_accel/` (VLNV: `xilinx.com:hls:conv_accel:1.0`)

2. Add the IP repository to your Vivado project:
   ```tcl
   set_property ip_repo_paths [list /path/to/1tee_accel/mac_accel/mac_accel] [current_project]
   update_ip_catalog
   ```

## Block Design Integration

The existing `design_1tee` block design has a MicroBlaze RISC-V soft core connected to a SmartConnect (`TEE_io`) with 5 master ports (M00-M04) and 3 slave ports. To add `conv_accel`, you need to:

1. Add the IP and 3 Block RAM generators
2. Connect the AXI-Lite control port to the SmartConnect
3. Wire each BRAM port to its own Block Memory Generator
4. Connect clocks, resets, and (optionally) the interrupt

### Step 1: Instantiate the IP

```tcl
# Add conv_accel
set conv_accel_0 [create_bd_cell -type ip -vlnv xilinx.com:hls:conv_accel:1.0 conv_accel_0]
```

### Step 2: Add Block Memory Generators

Each BRAM port needs a dedicated Block Memory Generator. The HLS IP exposes raw BRAM interfaces (address + data + enable + write-enable), not AXI -- so use `blk_mem_gen`, not an AXI BRAM controller.

```tcl
# Weight BRAM -- 128 KB, read-only from accelerator side.
# Port A: accelerator (read).  Port B: MicroBlaze via AXI BRAM Controller (read/write to preload weights).
set weight_bram [create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 weight_bram]
set_property -dict [list \
  CONFIG.Memory_Type {True_Dual_Port_RAM} \
  CONFIG.Write_Width_A {8} \
  CONFIG.Read_Width_A {8} \
  CONFIG.Write_Depth_A {131072} \
  CONFIG.Write_Width_B {8} \
  CONFIG.Read_Width_B {8} \
  CONFIG.Enable_B {Use_ENB_Pin} \
  CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
  CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
] $weight_bram

# Activation BRAM A -- 48 KB
set act_bram_a [create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 act_bram_a]
set_property -dict [list \
  CONFIG.Memory_Type {True_Dual_Port_RAM} \
  CONFIG.Write_Width_A {8} \
  CONFIG.Read_Width_A {8} \
  CONFIG.Write_Depth_A {49152} \
  CONFIG.Write_Width_B {8} \
  CONFIG.Read_Width_B {8} \
  CONFIG.Enable_B {Use_ENB_Pin} \
  CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
  CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
] $act_bram_a

# Activation BRAM B -- 48 KB
set act_bram_b [create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 act_bram_b]
set_property -dict [list \
  CONFIG.Memory_Type {True_Dual_Port_RAM} \
  CONFIG.Write_Width_A {8} \
  CONFIG.Read_Width_A {8} \
  CONFIG.Write_Depth_A {49152} \
  CONFIG.Write_Width_B {8} \
  CONFIG.Read_Width_B {8} \
  CONFIG.Enable_B {Use_ENB_Pin} \
  CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
  CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
] $act_bram_b
```

### Step 3: Connect BRAM Ports

Connect Port A of each Block Memory Generator to the accelerator's BRAM interfaces:

```tcl
connect_bd_intf_net [get_bd_intf_pins conv_accel_0/weight_bram_PORTA] [get_bd_intf_pins weight_bram/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins conv_accel_0/act_bram_a_PORTA]  [get_bd_intf_pins act_bram_a/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins conv_accel_0/act_bram_b_PORTA]  [get_bd_intf_pins act_bram_b/BRAM_PORTA]
```

### Step 4: Connect AXI-Lite Control

Expand the SmartConnect to add a master port for the accelerator's control registers, then connect:

```tcl
# Add one more master port to TEE_io (existing design has NUM_MI=5)
set_property CONFIG.NUM_MI {6} [get_bd_cells TEE_io]

# Connect new master port to conv_accel AXI-Lite slave
connect_bd_intf_net [get_bd_intf_pins TEE_io/M05_AXI] [get_bd_intf_pins conv_accel_0/s_axi_ctrl]
```

### Step 5: Expose BRAMs to the MicroBlaze (for data loading)

The MicroBlaze needs to read/write all three BRAMs to preload weights and shuttle activations. Add AXI BRAM Controllers and connect them to Port B of each Block Memory Generator:

```tcl
# AXI BRAM controller for weight BRAM
set weight_ctrl [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 weight_bram_ctrl]
set_property -dict [list \
  CONFIG.SINGLE_PORT_BRAM {1} \
  CONFIG.DATA_WIDTH {32} \
  CONFIG.ECC_TYPE {0} \
] $weight_ctrl
connect_bd_intf_net [get_bd_intf_pins weight_bram_ctrl/BRAM_PORTA] [get_bd_intf_pins weight_bram/BRAM_PORTB]

# AXI BRAM controller for activation BRAM A
set act_a_ctrl [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 act_bram_a_ctrl]
set_property -dict [list \
  CONFIG.SINGLE_PORT_BRAM {1} \
  CONFIG.DATA_WIDTH {32} \
  CONFIG.ECC_TYPE {0} \
] $act_a_ctrl
connect_bd_intf_net [get_bd_intf_pins act_bram_a_ctrl/BRAM_PORTA] [get_bd_intf_pins act_bram_a/BRAM_PORTB]

# AXI BRAM controller for activation BRAM B
set act_b_ctrl [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 act_bram_b_ctrl]
set_property -dict [list \
  CONFIG.SINGLE_PORT_BRAM {1} \
  CONFIG.DATA_WIDTH {32} \
  CONFIG.ECC_TYPE {0} \
] $act_b_ctrl
connect_bd_intf_net [get_bd_intf_pins act_bram_b_ctrl/BRAM_PORTA] [get_bd_intf_pins act_bram_b/BRAM_PORTB]

# Connect BRAM controllers to the SmartConnect
set_property CONFIG.NUM_MI {9} [get_bd_cells TEE_io]
connect_bd_intf_net [get_bd_intf_pins TEE_io/M06_AXI] [get_bd_intf_pins weight_bram_ctrl/S_AXI]
connect_bd_intf_net [get_bd_intf_pins TEE_io/M07_AXI] [get_bd_intf_pins act_bram_a_ctrl/S_AXI]
connect_bd_intf_net [get_bd_intf_pins TEE_io/M08_AXI] [get_bd_intf_pins act_bram_b_ctrl/S_AXI]
```

### Step 6: Clock and Reset

Everything runs on the single PL clock (`pl_clk0`, 100 MHz):

```tcl
# Clock
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] \
  [get_bd_pins conv_accel_0/ap_clk] \
  [get_bd_pins weight_bram_ctrl/s_axi_aclk] \
  [get_bd_pins act_bram_a_ctrl/s_axi_aclk] \
  [get_bd_pins act_bram_b_ctrl/s_axi_aclk]

# Reset
connect_bd_net [get_bd_pins rst_ps8_0_99M/peripheral_aresetn] \
  [get_bd_pins conv_accel_0/ap_rst_n] \
  [get_bd_pins weight_bram_ctrl/s_axi_aresetn] \
  [get_bd_pins act_bram_a_ctrl/s_axi_aresetn] \
  [get_bd_pins act_bram_b_ctrl/s_axi_aresetn]
```

### Step 7: Interrupt (Optional)

Connect the accelerator's `ap_done` interrupt to the existing interrupt controller:

```tcl
connect_bd_net [get_bd_pins conv_accel_0/interrupt] [get_bd_pins axi_intc_0/intr]
```

If `axi_intc_0/intr` is already connected (e.g. to `ps_pl_intr`), use a `concat` block to merge interrupt sources:

```tcl
set xlconcat_0 [create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0]
set_property CONFIG.NUM_PORTS {2} $xlconcat_0

# Disconnect existing intr connection, then reconnect through concat
disconnect_bd_net [get_bd_nets ps_pl_intr_gpio_io_o] [get_bd_pins axi_intc_0/intr]
connect_bd_net [get_bd_pins ps_pl_intr/gpio_io_o]    [get_bd_pins xlconcat_0/In0]
connect_bd_net [get_bd_pins conv_accel_0/interrupt]   [get_bd_pins xlconcat_0/In1]
connect_bd_net [get_bd_pins xlconcat_0/dout]          [get_bd_pins axi_intc_0/intr]
```

### Step 8: Address Map

Assign addresses in the MicroBlaze address space. The suggested layout keeps the accelerator in the 0x8005_0000+ range, consistent with the existing peripheral mapping:

```tcl
# conv_accel AXI-Lite registers (256 bytes, 0x00-0x94 used)
assign_bd_address -offset 0x80050000 -range 0x00010000 \
  -target_address_space [get_bd_addr_spaces microblaze_riscv_0/Data] \
  [get_bd_addr_segs conv_accel_0/s_axi_ctrl/Reg] -force

# Weight BRAM (128 KB)
assign_bd_address -offset 0x80060000 -range 0x00020000 \
  -target_address_space [get_bd_addr_spaces microblaze_riscv_0/Data] \
  [get_bd_addr_segs weight_bram_ctrl/S_AXI/Mem0] -force

# Activation BRAM A (48 KB -> round up to 64 KB range)
assign_bd_address -offset 0x80080000 -range 0x00010000 \
  -target_address_space [get_bd_addr_spaces microblaze_riscv_0/Data] \
  [get_bd_addr_segs act_bram_a_ctrl/S_AXI/Mem0] -force

# Activation BRAM B (48 KB -> round up to 64 KB range)
assign_bd_address -offset 0x80090000 -range 0x00010000 \
  -target_address_space [get_bd_addr_spaces microblaze_riscv_0/Data] \
  [get_bd_addr_segs act_bram_b_ctrl/S_AXI/Mem0] -force
```

Also assign addresses in the MDM debug master space if needed (mirror the above offsets for `mdm_1/Data`).

## AXI-Lite Register Map

All registers are in the `s_axi_ctrl` port (base + offset):

| Offset | Register       | Width | Description                              |
|--------|----------------|-------|------------------------------------------|
| 0x00   | AP_CTRL        | 32    | bit 0: ap_start, bit 1: ap_done, bit 2: ap_idle, bit 7: auto_restart |
| 0x10   | in_h           | 8     | Input height                             |
| 0x18   | in_w           | 8     | Input width                              |
| 0x20   | in_c           | 16    | Input channels                           |
| 0x28   | out_h          | 8     | Output height                            |
| 0x30   | out_w          | 8     | Output width                             |
| 0x38   | out_c          | 16    | Output channels                          |
| 0x40   | stride         | 2     | Convolution stride (1 or 2)              |
| 0x48   | pad_same       | 1     | 1 = SAME padding, 0 = VALID              |
| 0x50   | is_depthwise   | 1     | 1 = depthwise 3x3, 0 = pointwise 1x1    |
| 0x58   | relu6_en       | 1     | 1 = apply ReLU6 clamp after requantise   |
| 0x60   | weight_base    | 20    | Byte offset into weight BRAM             |
| 0x68   | bias_base      | 20    | Byte offset into weight BRAM (biases)    |
| 0x70   | input_base     | 20    | Byte offset into activation BRAM (input) |
| 0x78   | output_base    | 20    | Byte offset into activation BRAM (output)|
| 0x80   | requant_base   | 20    | Byte offset for requant table            |
| 0x88   | input_zp       | 8     | Input zero point (signed)                |
| 0x90   | output_zp      | 8     | Output zero point (signed)               |

## Weight BRAM Layout

All model data is packed into the 128 KB weight BRAM. For each layer, data is laid out at byte offsets specified by `weight_base`, `bias_base`, and `requant_base`:

**Weights** (at `weight_base`):
- Pointwise: `out_c * in_c` bytes, row-major `[oc][ic]`
- Depthwise: `9 * in_c` bytes, `[kh*3+kw][c]`

**Biases** (at `bias_base`):
- `num_channels * 4` bytes, each bias is a little-endian int32

**Requantisation table** (at `requant_base`):
- `num_channels * 8` bytes per channel, packed as:
  - Bytes 0-3: multiplier (little-endian int32)
  - Byte 4: shift (int8, HLS convention: `hls_shift = 31 - tflite_shift`)
  - Byte 5: act_min (int8, quantised activation minimum for ReLU6)
  - Byte 6: act_max (int8, quantised activation maximum for ReLU6)
  - Byte 7: padding (unused)

## Firmware Usage (Bare-Metal from MicroBlaze)

```c
#include <stdint.h>

// Base addresses (must match your address map)
#define CONV_ACCEL_BASE  0x80050000
#define WEIGHT_BRAM_BASE 0x80060000
#define ACT_BRAM_A_BASE  0x80080000
#define ACT_BRAM_B_BASE  0x80090000

// Register offsets
#define AP_CTRL      0x00
#define REG_IN_H     0x10
#define REG_IN_W     0x18
#define REG_IN_C     0x20
#define REG_OUT_H    0x28
#define REG_OUT_W    0x30
#define REG_OUT_C    0x38
#define REG_STRIDE   0x40
#define REG_PAD_SAME 0x48
#define REG_IS_DW    0x50
#define REG_RELU6    0x58
#define REG_W_BASE   0x60
#define REG_B_BASE   0x68
#define REG_IN_BASE  0x70
#define REG_OUT_BASE 0x78
#define REG_RQ_BASE  0x80
#define REG_IN_ZP    0x88
#define REG_OUT_ZP   0x90

static inline void reg_write(uint32_t base, uint32_t offset, uint32_t val) {
    *(volatile uint32_t *)(base + offset) = val;
}
static inline uint32_t reg_read(uint32_t base, uint32_t offset) {
    return *(volatile uint32_t *)(base + offset);
}

// 1. Preload weights into weight BRAM (once at init)
void load_weights(const uint8_t *model_weights, uint32_t size) {
    volatile uint8_t *dst = (volatile uint8_t *)WEIGHT_BRAM_BASE;
    for (uint32_t i = 0; i < size; i++)
        dst[i] = model_weights[i];
}

// 2. Load input activations into act_bram_a
void load_input(const int8_t *input, uint32_t offset, uint32_t size) {
    volatile int8_t *dst = (volatile int8_t *)(ACT_BRAM_A_BASE + offset);
    for (uint32_t i = 0; i < size; i++)
        dst[i] = input[i];
}

// 3. Run one convolution layer
void run_conv_layer(
    uint8_t in_h, uint8_t in_w, uint16_t in_c,
    uint8_t out_h, uint8_t out_w, uint16_t out_c,
    uint8_t stride, uint8_t pad_same, uint8_t is_depthwise,
    uint8_t relu6_en,
    uint32_t weight_base, uint32_t bias_base,
    uint32_t input_base, uint32_t output_base,
    uint32_t requant_base,
    int8_t input_zp, int8_t output_zp
) {
    // Write all layer parameters
    reg_write(CONV_ACCEL_BASE, REG_IN_H,     in_h);
    reg_write(CONV_ACCEL_BASE, REG_IN_W,     in_w);
    reg_write(CONV_ACCEL_BASE, REG_IN_C,     in_c);
    reg_write(CONV_ACCEL_BASE, REG_OUT_H,    out_h);
    reg_write(CONV_ACCEL_BASE, REG_OUT_W,    out_w);
    reg_write(CONV_ACCEL_BASE, REG_OUT_C,    out_c);
    reg_write(CONV_ACCEL_BASE, REG_STRIDE,   stride);
    reg_write(CONV_ACCEL_BASE, REG_PAD_SAME, pad_same);
    reg_write(CONV_ACCEL_BASE, REG_IS_DW,    is_depthwise);
    reg_write(CONV_ACCEL_BASE, REG_RELU6,    relu6_en);
    reg_write(CONV_ACCEL_BASE, REG_W_BASE,   weight_base);
    reg_write(CONV_ACCEL_BASE, REG_B_BASE,   bias_base);
    reg_write(CONV_ACCEL_BASE, REG_IN_BASE,  input_base);
    reg_write(CONV_ACCEL_BASE, REG_OUT_BASE, output_base);
    reg_write(CONV_ACCEL_BASE, REG_RQ_BASE,  requant_base);
    reg_write(CONV_ACCEL_BASE, REG_IN_ZP,    (uint32_t)(uint8_t)input_zp);
    reg_write(CONV_ACCEL_BASE, REG_OUT_ZP,   (uint32_t)(uint8_t)output_zp);

    // Start accelerator
    reg_write(CONV_ACCEL_BASE, AP_CTRL, 0x01);

    // Poll for completion
    while (!(reg_read(CONV_ACCEL_BASE, AP_CTRL) & 0x02))
        ;  // bit 1 = ap_done

    // Output is now in act_bram_b at output_base
}

// 4. Read output activations from act_bram_b
void read_output(int8_t *output, uint32_t offset, uint32_t size) {
    volatile int8_t *src = (volatile int8_t *)(ACT_BRAM_B_BASE + offset);
    for (uint32_t i = 0; i < size; i++)
        output[i] = src[i];
}
```

## Resource Budget

After synthesis at 100 MHz on xczu3eg:

| Resource | Used    | Available | %  |
|----------|---------|-----------|----|
| LUT      | 40,486  | 70,560    | 57 |
| FF       | 29,003  | 141,120   | 20 |
| DSP      | 142     | 360       | 39 |
| BRAM     | ~110    | 432       | 25 |

BRAM usage above is for the three memory blocks (128 KB + 48 KB + 48 KB = 224 KB). The HLS IP itself uses 0 BRAM internally; all storage is in the external Block Memory Generators.

## Important Notes

- **Pointwise caller pre-strides**: The pointwise kernel has no concept of stride. For strided 1x1 convolutions, rearrange the activation buffer to contain only strided pixels before invoking the accelerator. `spatial = out_h * out_w` in the call.

- **BRAM offsets vs AXI addresses**: The `weight_base`, `bias_base`, `input_base`, `output_base`, and `requant_base` registers are **byte offsets within the BRAM**, not AXI addresses. For example, if biases start at byte 1024 in the weight BRAM, write `1024` to `bias_base`, regardless of where the AXI BRAM controller maps the BRAM in the address space.

- **Activation double-buffering**: The accelerator always reads from `act_bram_a` and writes to `act_bram_b`. To chain layers, swap which BRAM you preload and which you read back, or copy `act_bram_b` output into `act_bram_a` for the next layer's input.

- **Requant shift convention**: The shift stored in the weight BRAM uses HLS convention (`hls_shift = 31 - tflite_shift`), not TFLite's native convention. The firmware must convert before preloading.
