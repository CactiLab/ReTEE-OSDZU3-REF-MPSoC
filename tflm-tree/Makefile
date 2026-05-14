# TFLM static library build
#
# Usage:
#   make riscv-hfloat   # RISC-V 32-bit with hardware float (default)
#   make riscv-sfloat   # RISC-V 32-bit with soft float
#   make cortexa-neon   # ARMv8-A Cortex-A53 with NEON
#
# Bare `make` builds riscv-hfloat.

# Target architecture: riscv (default) or cortex-a
TARGET_ARCH ?= riscv

# Float configuration (default: 1 = hardware float)
FLOAT ?= 1

# ---- Architecture-specific configuration ----

ifeq ($(TARGET_ARCH),cortex-a)
  # ARM Cortex-A (ARMv8-A, AArch64 with NEON)
  ifneq ($(FLOAT),1)
    $(error cortex-a target does not support FLOAT=0)
  endif
  TOOLCHAIN_PREFIX ?= /opt/petalinux/2025.1/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-amd-linux/aarch64-amd-linux-
  CXX := $(TOOLCHAIN_PREFIX)g++
  CC  := $(TOOLCHAIN_PREFIX)gcc
  AR  := $(TOOLCHAIN_PREFIX)ar
  SYSROOT ?= /opt/petalinux/2025.1/sysroots/cortexa72-cortexa53-amd-linux
  ARCH_FLAGS := -march=armv8-a+simd -mtune=cortex-a53 --sysroot=$(SYSROOT)
  BUILD_DIR := build-cortexa-neon

else ifeq ($(TARGET_ARCH),riscv)
  # MicroBlaze V (32-bit RISC-V) — Xilinx Vitis 2025.2 toolchain
  TOOLCHAIN_PREFIX := /tools/Xilinx/2025.2/gnu/riscv/lin/bin/riscv64-unknown-elf-
  CXX := $(TOOLCHAIN_PREFIX)g++
  CC  := $(TOOLCHAIN_PREFIX)gcc
  AR  := $(TOOLCHAIN_PREFIX)ar

  ifeq ($(FLOAT),1)
    ARCH_FLAGS := -march=rv32imf_zicsr_zifencei -mabi=ilp32f
    BUILD_DIR := build-riscv-hfloat
  else
    ARCH_FLAGS := -march=rv32im_zicsr_zifencei -mabi=ilp32
    BUILD_DIR := build-riscv-sfloat
  endif

else
  $(error Unknown TARGET_ARCH=$(TARGET_ARCH). Supported: riscv, cortex-a)
endif

# Include paths
INCLUDES := \
	-I. \
	-I./third_party/flatbuffers/include \
	-I./third_party/gemmlowp \
	-I./third_party/kissfft \
	-I./third_party/ruy

# Common flags
COMMON_FLAGS := \
	$(ARCH_FLAGS) \
	$(INCLUDES) \
	-DTF_LITE_STATIC_MEMORY \
	-DTF_LITE_MCU_DEBUG_LOG \
	-DNDEBUG \
	-Os \
	-fno-exceptions \
	-fno-rtti \
	-fno-unwind-tables \
	-fno-use-cxa-atexit \
	-fno-asynchronous-unwind-tables \
	-ffunction-sections \
	-fdata-sections \
	-fmessage-length=0 \
	-fno-threadsafe-statics \
	-Wall \
	-Wextra \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-Wno-sign-compare

CXXFLAGS := $(COMMON_FLAGS) -std=c++17
CFLAGS   := $(COMMON_FLAGS) -std=c11

# Output library
TARGET := $(BUILD_DIR)/libtflm.a

# ---- Source files ----

# Core TFLite
TFLITE_CORE_SRCS := \
	tensorflow/lite/core/api/flatbuffer_conversions.cc \
	tensorflow/lite/core/api/tensor_utils.cc \
	tensorflow/lite/core/c/common.cc \
	tensorflow/lite/kernels/internal/common.cc \
	tensorflow/lite/kernels/internal/portable_tensor_utils.cc \
	tensorflow/lite/kernels/internal/quantization_util.cc \
	tensorflow/lite/kernels/internal/reference/comparisons.cc \
	tensorflow/lite/kernels/internal/reference/portable_tensor_utils.cc \
	tensorflow/lite/kernels/internal/runtime_shape.cc \
	tensorflow/lite/kernels/internal/tensor_ctypes.cc \
	tensorflow/lite/kernels/internal/tensor_utils.cc \
	tensorflow/lite/kernels/kernel_util.cc

# MLIR/schema
SCHEMA_SRCS := \
	tensorflow/compiler/mlir/lite/core/api/error_reporter.cc \
	tensorflow/compiler/mlir/lite/schema/schema_utils.cc

# Micro core
MICRO_CORE_SRCS := \
	tensorflow/lite/micro/arena_allocator/non_persistent_arena_buffer_allocator.cc \
	tensorflow/lite/micro/arena_allocator/persistent_arena_buffer_allocator.cc \
	tensorflow/lite/micro/arena_allocator/recording_single_arena_buffer_allocator.cc \
	tensorflow/lite/micro/arena_allocator/single_arena_buffer_allocator.cc \
	tensorflow/lite/micro/debug_log.cc \
	tensorflow/lite/micro/flatbuffer_utils.cc \
	tensorflow/lite/micro/hexdump.cc \
	tensorflow/lite/micro/memory_helpers.cc \
	tensorflow/lite/micro/memory_planner/greedy_memory_planner.cc \
	tensorflow/lite/micro/memory_planner/linear_memory_planner.cc \
	tensorflow/lite/micro/memory_planner/non_persistent_buffer_planner_shim.cc \
	tensorflow/lite/micro/micro_allocation_info.cc \
	tensorflow/lite/micro/micro_allocator.cc \
	tensorflow/lite/micro/micro_context.cc \
	tensorflow/lite/micro/micro_interpreter.cc \
	tensorflow/lite/micro/micro_interpreter_context.cc \
	tensorflow/lite/micro/micro_interpreter_graph.cc \
	tensorflow/lite/micro/micro_log.cc \
	tensorflow/lite/micro/micro_op_resolver.cc \
	tensorflow/lite/micro/micro_profiler.cc \
	tensorflow/lite/micro/micro_resource_variable.cc \
	tensorflow/lite/micro/micro_time.cc \
	tensorflow/lite/micro/micro_utils.cc \
	tensorflow/lite/micro/recording_micro_allocator.cc \
	tensorflow/lite/micro/system_setup.cc \
	tensorflow/lite/micro/tflite_bridge/flatbuffer_conversions_bridge.cc \
	tensorflow/lite/micro/tflite_bridge/micro_error_reporter.cc

# Micro kernels (excluding ethosu which requires ARM Ethos-U NPU)
MICRO_KERNEL_SRCS := \
	tensorflow/lite/micro/kernels/activations.cc \
	tensorflow/lite/micro/kernels/activations_common.cc \
	tensorflow/lite/micro/kernels/add.cc \
	tensorflow/lite/micro/kernels/add_common.cc \
	tensorflow/lite/micro/kernels/add_n.cc \
	tensorflow/lite/micro/kernels/arg_min_max.cc \
	tensorflow/lite/micro/kernels/assign_variable.cc \
	tensorflow/lite/micro/kernels/batch_matmul.cc \
	tensorflow/lite/micro/kernels/batch_matmul_common.cc \
	tensorflow/lite/micro/kernels/batch_to_space_nd.cc \
	tensorflow/lite/micro/kernels/broadcast_args.cc \
	tensorflow/lite/micro/kernels/broadcast_to.cc \
	tensorflow/lite/micro/kernels/call_once.cc \
	tensorflow/lite/micro/kernels/cast.cc \
	tensorflow/lite/micro/kernels/ceil.cc \
	tensorflow/lite/micro/kernels/circular_buffer.cc \
	tensorflow/lite/micro/kernels/circular_buffer_common.cc \
	tensorflow/lite/micro/kernels/comparisons.cc \
	tensorflow/lite/micro/kernels/concatenation.cc \
	tensorflow/lite/micro/kernels/conv.cc \
	tensorflow/lite/micro/kernels/conv_common.cc \
	tensorflow/lite/micro/kernels/cumsum.cc \
	tensorflow/lite/micro/kernels/decode.cc \
	tensorflow/lite/micro/kernels/decode_state.cc \
	tensorflow/lite/micro/kernels/decode_state_huffman.cc \
	tensorflow/lite/micro/kernels/decode_state_lut.cc \
	tensorflow/lite/micro/kernels/decode_state_prune.cc \
	tensorflow/lite/micro/kernels/decompress.cc \
	tensorflow/lite/micro/kernels/decompress_common.cc \
	tensorflow/lite/micro/kernels/depth_to_space.cc \
	tensorflow/lite/micro/kernels/depthwise_conv.cc \
	tensorflow/lite/micro/kernels/depthwise_conv_common.cc \
	tensorflow/lite/micro/kernels/dequantize.cc \
	tensorflow/lite/micro/kernels/dequantize_common.cc \
	tensorflow/lite/micro/kernels/detection_postprocess.cc \
	tensorflow/lite/micro/kernels/div.cc \
	tensorflow/lite/micro/kernels/dynamic_update_slice.cc \
	tensorflow/lite/micro/kernels/elementwise.cc \
	tensorflow/lite/micro/kernels/elu.cc \
	tensorflow/lite/micro/kernels/embedding_lookup.cc \
	tensorflow/lite/micro/kernels/expand_dims.cc \
	tensorflow/lite/micro/kernels/exp.cc \
	tensorflow/lite/micro/kernels/fill.cc \
	tensorflow/lite/micro/kernels/floor.cc \
	tensorflow/lite/micro/kernels/floor_div.cc \
	tensorflow/lite/micro/kernels/floor_mod.cc \
	tensorflow/lite/micro/kernels/fully_connected.cc \
	tensorflow/lite/micro/kernels/fully_connected_common.cc \
	tensorflow/lite/micro/kernels/gather.cc \
	tensorflow/lite/micro/kernels/gather_nd.cc \
	tensorflow/lite/micro/kernels/hard_swish.cc \
	tensorflow/lite/micro/kernels/hard_swish_common.cc \
	tensorflow/lite/micro/kernels/if.cc \
	tensorflow/lite/micro/kernels/kernel_util.cc \
	tensorflow/lite/micro/kernels/l2norm.cc \
	tensorflow/lite/micro/kernels/l2_pool_2d.cc \
	tensorflow/lite/micro/kernels/leaky_relu.cc \
	tensorflow/lite/micro/kernels/leaky_relu_common.cc \
	tensorflow/lite/micro/kernels/logical.cc \
	tensorflow/lite/micro/kernels/logical_common.cc \
	tensorflow/lite/micro/kernels/logistic.cc \
	tensorflow/lite/micro/kernels/logistic_common.cc \
	tensorflow/lite/micro/kernels/log_softmax.cc \
	tensorflow/lite/micro/kernels/lstm_eval.cc \
	tensorflow/lite/micro/kernels/lstm_eval_common.cc \
	tensorflow/lite/micro/kernels/maximum_minimum.cc \
	tensorflow/lite/micro/kernels/micro_tensor_utils.cc \
	tensorflow/lite/micro/kernels/mirror_pad.cc \
	tensorflow/lite/micro/kernels/mul.cc \
	tensorflow/lite/micro/kernels/mul_common.cc \
	tensorflow/lite/micro/kernels/neg.cc \
	tensorflow/lite/micro/kernels/pack.cc \
	tensorflow/lite/micro/kernels/pad.cc \
	tensorflow/lite/micro/kernels/pad_common.cc \
	tensorflow/lite/micro/kernels/pooling.cc \
	tensorflow/lite/micro/kernels/pooling_common.cc \
	tensorflow/lite/micro/kernels/prelu.cc \
	tensorflow/lite/micro/kernels/prelu_common.cc \
	tensorflow/lite/micro/kernels/quantize.cc \
	tensorflow/lite/micro/kernels/quantize_common.cc \
	tensorflow/lite/micro/kernels/read_variable.cc \
	tensorflow/lite/micro/kernels/reduce.cc \
	tensorflow/lite/micro/kernels/reduce_common.cc \
	tensorflow/lite/micro/kernels/reshape.cc \
	tensorflow/lite/micro/kernels/reshape_common.cc \
	tensorflow/lite/micro/kernels/resize_bilinear.cc \
	tensorflow/lite/micro/kernels/resize_nearest_neighbor.cc \
	tensorflow/lite/micro/kernels/reverse.cc \
	tensorflow/lite/micro/kernels/round.cc \
	tensorflow/lite/micro/kernels/select.cc \
	tensorflow/lite/micro/kernels/shape.cc \
	tensorflow/lite/micro/kernels/slice.cc \
	tensorflow/lite/micro/kernels/softmax.cc \
	tensorflow/lite/micro/kernels/softmax_common.cc \
	tensorflow/lite/micro/kernels/space_to_batch_nd.cc \
	tensorflow/lite/micro/kernels/space_to_depth.cc \
	tensorflow/lite/micro/kernels/split.cc \
	tensorflow/lite/micro/kernels/split_v.cc \
	tensorflow/lite/micro/kernels/squared_difference.cc \
	tensorflow/lite/micro/kernels/squeeze.cc \
	tensorflow/lite/micro/kernels/strided_slice.cc \
	tensorflow/lite/micro/kernels/strided_slice_common.cc \
	tensorflow/lite/micro/kernels/sub.cc \
	tensorflow/lite/micro/kernels/sub_common.cc \
	tensorflow/lite/micro/kernels/svdf.cc \
	tensorflow/lite/micro/kernels/svdf_common.cc \
	tensorflow/lite/micro/kernels/tanh.cc \
	tensorflow/lite/micro/kernels/transpose.cc \
	tensorflow/lite/micro/kernels/transpose_common.cc \
	tensorflow/lite/micro/kernels/transpose_conv.cc \
	tensorflow/lite/micro/kernels/unidirectional_sequence_lstm.cc \
	tensorflow/lite/micro/kernels/unpack.cc \
	tensorflow/lite/micro/kernels/var_handle.cc \
	tensorflow/lite/micro/kernels/while.cc \
	tensorflow/lite/micro/kernels/zeros_like.cc

# Signal processing
SIGNAL_MICRO_SRCS := \
	signal/micro/kernels/delay.cc \
	signal/micro/kernels/energy.cc \
	signal/micro/kernels/fft_auto_scale_common.cc \
	signal/micro/kernels/fft_auto_scale_kernel.cc \
	signal/micro/kernels/filter_bank.cc \
	signal/micro/kernels/filter_bank_log.cc \
	signal/micro/kernels/filter_bank_spectral_subtraction.cc \
	signal/micro/kernels/filter_bank_square_root.cc \
	signal/micro/kernels/filter_bank_square_root_common.cc \
	signal/micro/kernels/framer.cc \
	signal/micro/kernels/irfft.cc \
	signal/micro/kernels/overlap_add.cc \
	signal/micro/kernels/pcan.cc \
	signal/micro/kernels/rfft.cc \
	signal/micro/kernels/stacker.cc \
	signal/micro/kernels/window.cc

SIGNAL_SRC_SRCS := \
	signal/src/circular_buffer.cc \
	signal/src/energy.cc \
	signal/src/fft_auto_scale.cc \
	signal/src/filter_bank.cc \
	signal/src/filter_bank_log.cc \
	signal/src/filter_bank_spectral_subtraction.cc \
	signal/src/filter_bank_square_root.cc \
	signal/src/irfft_int16.cc \
	signal/src/irfft_int32.cc \
	signal/src/kiss_fft_wrappers/kiss_fft_int16.cc \
	signal/src/kiss_fft_wrappers/kiss_fft_int32.cc \
	signal/src/log.cc \
	signal/src/max_abs.cc \
	signal/src/msb_32.cc \
	signal/src/msb_64.cc \
	signal/src/overlap_add.cc \
	signal/src/pcan_argc_fixed.cc \
	signal/src/rfft_int16.cc \
	signal/src/rfft_int32.cc \
	signal/src/square_root_32.cc \
	signal/src/square_root_64.cc \
	signal/src/window.cc

# Float signal sources (only included for float builds)
ifeq ($(FLOAT),1)
SIGNAL_SRC_SRCS += \
	signal/src/irfft_float.cc \
	signal/src/kiss_fft_wrappers/kiss_fft_float.cc \
	signal/src/rfft_float.cc
endif

# Third party C sources
THIRD_PARTY_C_SRCS := \
	third_party/kissfft/kiss_fft.c \
	third_party/kissfft/tools/kiss_fftr.c

# All C++ sources
CXX_SRCS := \
	$(TFLITE_CORE_SRCS) \
	$(SCHEMA_SRCS) \
	$(MICRO_CORE_SRCS) \
	$(MICRO_KERNEL_SRCS) \
	$(SIGNAL_MICRO_SRCS) \
	$(SIGNAL_SRC_SRCS)

C_SRCS := $(THIRD_PARTY_C_SRCS)

# Object files
CXX_OBJS := $(patsubst %.cc,$(BUILD_DIR)/%.o,$(CXX_SRCS))
C_OBJS   := $(patsubst %.c,$(BUILD_DIR)/%.o,$(C_SRCS))
ALL_OBJS := $(CXX_OBJS) $(C_OBJS)

# ---- Rules ----

.PHONY: all clean clean-all riscv-hfloat riscv-sfloat cortexa-neon

all: $(TARGET)
	@echo "Built $(TARGET) successfully (FLOAT=$(FLOAT))"
	@$(TOOLCHAIN_PREFIX)size $(TARGET)

riscv-hfloat:
	$(MAKE) TARGET_ARCH=riscv FLOAT=1

riscv-sfloat:
	$(MAKE) TARGET_ARCH=riscv FLOAT=0

cortexa-neon:
	$(MAKE) TARGET_ARCH=cortex-a FLOAT=1

$(TARGET): $(ALL_OBJS)
	@echo "AR  $@"
	@$(AR) rcs $@ $^

$(BUILD_DIR)/%.o: %.cc
	@mkdir -p $(dir $@)
	@echo "CXX $<"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	@echo "CC  $<"
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)

clean-all:
	rm -rf build-riscv-hfloat build-riscv-sfloat build-cortexa-neon
