#!/usr/bin/env python3
"""
TFLite Model Packer — separates weights from metadata for the conv_accel HW.

Outputs:
  <model>_weights.bin   — packed weight BRAM image (weights + biases + requant)
  <model>_meta.h        — C header with per-layer descriptors and a model header
  <model>_meta.bin      — binary layer descriptor table (for runtime loading)

Weight BRAM layout per conv/dwconv layer (packed sequentially):
  [weights][biases (int32)][requant table (8 bytes/channel)]

Requant table entry (8 bytes):
  bytes 0-3: multiplier (int32, little-endian)
  byte  4:   hls_shift  (= 31 - tflite_shift)
  byte  5:   act_min    (int8, clamp lower bound)
  byte  6:   act_max    (int8, clamp upper bound)
  byte  7:   padding (0)
"""

import argparse
import struct
import sys
from pathlib import Path

import numpy as np
from tflite.Model import Model
from tflite.BuiltinOperator import BuiltinOperator
from tflite.Conv2DOptions import Conv2DOptions
from tflite.DepthwiseConv2DOptions import DepthwiseConv2DOptions
from tflite.Padding import Padding
from tflite.ActivationFunctionType import ActivationFunctionType


# ---------------------------------------------------------------------------
#  Helpers
# ---------------------------------------------------------------------------

def load_model(path: str) -> Model:
    buf = bytearray(open(path, "rb").read())
    return Model.GetRootAs(buf, 0)


def get_buffer_data(model: Model, tensor) -> np.ndarray:
    buf = model.Buffers(tensor.Buffer())
    if buf is None or buf.DataLength() == 0:
        return np.array([], dtype=np.int8)
    return buf.DataAsNumpy()


def tensor_shape(tensor) -> list:
    return [tensor.Shape(i) for i in range(tensor.ShapeLength())]


def compute_multiplier_shift(scale: float):
    """Convert float scale to (int32 multiplier, int shift) for TFLite-style
    fixed-point requantization. multiplier in [2^30, 2^31)."""
    if scale == 0:
        return 0, 0
    shift = 0
    while scale < 0.5:
        scale *= 2.0
        shift += 1
    while scale >= 1.0:
        scale /= 2.0
        shift -= 1
    q = round(scale * (1 << 31))
    if q == (1 << 31):
        q //= 2
        shift -= 1
    return int(q), int(shift)


def activation_clamp(act_fn, output_zp):
    if act_fn == ActivationFunctionType.RELU6:
        return max(-128, int(output_zp)), 127
    elif act_fn == ActivationFunctionType.RELU:
        return max(-128, int(output_zp)), 127
    else:
        return -128, 127


def pack_requant_entry(multiplier: int, tflite_shift: int,
                       act_min: int, act_max: int) -> bytes:
    hls_shift = 31 - tflite_shift
    return struct.pack("<iBbbb",
                       multiplier,
                       hls_shift,
                       act_min & 0xFF if act_min >= 0 else act_min,
                       act_max & 0xFF if act_max >= 0 else act_max,
                       0)


# ---------------------------------------------------------------------------
#  Op type constants
# ---------------------------------------------------------------------------
OP_CONV2D     = 0
OP_DWCONV2D   = 1
OP_AVG_POOL   = 2
OP_RESHAPE    = 3
OP_SOFTMAX    = 4
OP_OTHER      = 0xFF

BUILTIN_TO_OP = {
    BuiltinOperator.CONV_2D:            OP_CONV2D,
    BuiltinOperator.DEPTHWISE_CONV_2D:  OP_DWCONV2D,
    BuiltinOperator.AVERAGE_POOL_2D:    OP_AVG_POOL,
    BuiltinOperator.RESHAPE:            OP_RESHAPE,
    BuiltinOperator.SOFTMAX:            OP_SOFTMAX,
}

OP_NAMES = {
    OP_CONV2D: "CONV_2D", OP_DWCONV2D: "DEPTHWISE_CONV_2D",
    OP_AVG_POOL: "AVG_POOL_2D", OP_RESHAPE: "RESHAPE",
    OP_SOFTMAX: "SOFTMAX", OP_OTHER: "OTHER",
}

# Layer descriptor: matches conv_accel_set_layer args (32 bytes)
LAYER_DESC_FMT = "<BBHBBHBBBBIIIIIbb2x"
LAYER_DESC_SIZE = struct.calcsize(LAYER_DESC_FMT)


# ---------------------------------------------------------------------------
#  Main packing logic
# ---------------------------------------------------------------------------

def pack_model(model_path: str, output_dir: str):
    model = load_model(model_path)
    stem = Path(model_path).stem
    subgraph = model.Subgraphs(0)

    weight_blob = bytearray()
    layers_meta = []

    for op_idx in range(subgraph.OperatorsLength()):
        op = subgraph.Operators(op_idx)
        opcode = model.OperatorCodes(op.OpcodeIndex())
        builtin_code = opcode.BuiltinCode()
        if builtin_code == 0:
            builtin_code = opcode.DeprecatedBuiltinCode()

        input_indices = [op.Inputs(i) for i in range(op.InputsLength())]
        output_indices = [op.Outputs(i) for i in range(op.OutputsLength())]
        input_tensor = subgraph.Tensors(input_indices[0])
        output_tensor = subgraph.Tensors(output_indices[0])

        layer = {
            "op_idx": op_idx,
            "op_type": BUILTIN_TO_OP.get(builtin_code, OP_OTHER),
            "builtin_code": builtin_code,
            "in_shape": tensor_shape(input_tensor),
            "out_shape": tensor_shape(output_tensor),
            "weight_base": 0, "bias_base": 0, "requant_base": 0,
            "weight_size": 0,
            "stride": 1, "pad_same": 0, "is_depthwise": 0, "relu6_en": 0,
            "input_zp": 0, "output_zp": 0,
            "has_weights": False,
        }

        # Quantization zero points
        in_quant = input_tensor.Quantization()
        if in_quant and not in_quant.ZeroPointIsNone() and in_quant.ZeroPointLength() > 0:
            layer["input_zp"] = int(in_quant.ZeroPoint(0))
        out_quant = output_tensor.Quantization()
        if out_quant and not out_quant.ZeroPointIsNone() and out_quant.ZeroPointLength() > 0:
            layer["output_zp"] = int(out_quant.ZeroPoint(0))

        def pack_conv_weights(weight_tensor, bias_tensor, act_fn, out_c):
            """Pack weights + biases + requant for a conv layer."""
            weight_data = get_buffer_data(model, weight_tensor)
            bias_data = get_buffer_data(model, bias_tensor)

            w_quant = weight_tensor.Quantization()
            w_scales = [w_quant.Scale(i) for i in range(w_quant.ScaleLength())]
            in_scale = in_quant.Scale(0) if in_quant and not in_quant.ScaleIsNone() else 1.0
            out_scale = out_quant.Scale(0) if out_quant and not out_quant.ScaleIsNone() else 1.0

            # Weights (int8, row-major as stored in tflite)
            layer["weight_base"] = len(weight_blob)
            weight_blob.extend(weight_data.tobytes())
            layer["has_weights"] = True

            # Align to 4 bytes for biases
            while len(weight_blob) % 4:
                weight_blob.append(0)
            layer["bias_base"] = len(weight_blob)
            weight_blob.extend(bias_data.tobytes())

            # Requant table
            while len(weight_blob) % 4:
                weight_blob.append(0)
            layer["requant_base"] = len(weight_blob)
            act_min, act_max = activation_clamp(act_fn, layer["output_zp"])
            for ch in range(out_c):
                eff_scale = (in_scale * w_scales[ch]) / out_scale
                mult, shift = compute_multiplier_shift(eff_scale)
                weight_blob.extend(pack_requant_entry(mult, shift, act_min, act_max))

            layer["weight_size"] = len(weight_blob) - layer["weight_base"]

        # --- CONV_2D ---
        if builtin_code == BuiltinOperator.CONV_2D:
            opts = Conv2DOptions()
            opts.Init(op.BuiltinOptions().Bytes, op.BuiltinOptions().Pos)
            layer["stride"] = opts.StrideH()
            layer["pad_same"] = 1 if opts.Padding() == Padding.SAME else 0
            act_fn = opts.FusedActivationFunction()
            layer["relu6_en"] = 1 if act_fn == ActivationFunctionType.RELU6 else 0

            wt = subgraph.Tensors(input_indices[1])
            bt = subgraph.Tensors(input_indices[2])
            out_c = tensor_shape(wt)[0]
            pack_conv_weights(wt, bt, act_fn, out_c)

        # --- DEPTHWISE_CONV_2D ---
        elif builtin_code == BuiltinOperator.DEPTHWISE_CONV_2D:
            opts = DepthwiseConv2DOptions()
            opts.Init(op.BuiltinOptions().Bytes, op.BuiltinOptions().Pos)
            layer["stride"] = opts.StrideH()
            layer["pad_same"] = 1 if opts.Padding() == Padding.SAME else 0
            layer["is_depthwise"] = 1
            act_fn = opts.FusedActivationFunction()
            layer["relu6_en"] = 1 if act_fn == ActivationFunctionType.RELU6 else 0

            wt = subgraph.Tensors(input_indices[1])
            bt = subgraph.Tensors(input_indices[2])
            out_c = tensor_shape(wt)[3]  # [1, kH, kW, out_c]
            pack_conv_weights(wt, bt, act_fn, out_c)

        layers_meta.append(layer)

    # Align total blob to 16 bytes
    while len(weight_blob) % 16:
        weight_blob.append(0)

    # -----------------------------------------------------------------------
    #  Write outputs
    # -----------------------------------------------------------------------
    out_dir = Path(output_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    # 1) Weight binary
    weight_path = out_dir / f"{stem}_weights.bin"
    weight_path.write_bytes(weight_blob)
    print(f"Wrote {weight_path}  ({len(weight_blob)} bytes, "
          f"{len(weight_blob)/1024:.1f} KB)")

    # 2) Binary layer descriptor table
    conv_layers = [l for l in layers_meta if l["has_weights"]]
    meta_bin = bytearray()
    meta_bin.extend(struct.pack("<II", 0x4C544650, len(conv_layers)))  # "PFLT"
    for l in conv_layers:
        s = l["in_shape"]
        o = l["out_shape"]
        in_h  = s[1] if len(s) == 4 else 0
        in_w  = s[2] if len(s) == 4 else 0
        in_c  = s[3] if len(s) == 4 else 0
        out_h = o[1] if len(o) == 4 else 0
        out_w = o[2] if len(o) == 4 else 0
        out_c = o[3] if len(o) == 4 else 0
        meta_bin.extend(struct.pack(
            LAYER_DESC_FMT,
            in_h, in_w, in_c, out_h, out_w, out_c,
            l["stride"], l["pad_same"], l["is_depthwise"], l["relu6_en"],
            l["weight_base"], l["bias_base"],
            0, 0,  # input/output_base: set at runtime
            l["requant_base"],
            l["input_zp"], l["output_zp"],
        ))

    meta_bin_path = out_dir / f"{stem}_meta.bin"
    meta_bin_path.write_bytes(meta_bin)
    print(f"Wrote {meta_bin_path}  ({len(meta_bin)} bytes)")

    # 3) C header
    header_path = out_dir / f"{stem}_meta.h"
    with open(header_path, "w") as f:
        guard = f"{stem.upper()}_META_H"
        f.write(f"#ifndef {guard}\n#define {guard}\n\n")
        f.write("#include <stdint.h>\n\n")
        f.write(f"#define MODEL_WEIGHT_BLOB_SIZE  {len(weight_blob)}\n")
        f.write(f"#define MODEL_NUM_LAYERS        {len(layers_meta)}\n")
        f.write(f"#define MODEL_NUM_CONV_LAYERS   {len(conv_layers)}\n\n")

        f.write("typedef struct __attribute__((__packed__)) {\n"
                "    uint8_t  in_h;\n"
                "    uint8_t  in_w;\n"
                "    uint16_t in_c;\n"
                "    uint8_t  out_h;\n"
                "    uint8_t  out_w;\n"
                "    uint16_t out_c;\n"
                "    uint8_t  stride;\n"
                "    uint8_t  pad_same;\n"
                "    uint8_t  is_depthwise;\n"
                "    uint8_t  relu6_en;\n"
                "    uint32_t weight_base;\n"
                "    uint32_t bias_base;\n"
                "    uint32_t input_base;\n"
                "    uint32_t output_base;\n"
                "    uint32_t requant_base;\n"
                "    int8_t   input_zp;\n"
                "    int8_t   output_zp;\n"
                "    uint8_t  _pad[2];\n"
                "} layer_desc_t;\n\n")

        f.write("static const layer_desc_t conv_layer_table[] = {\n")
        for i, l in enumerate(conv_layers):
            s, o = l["in_shape"], l["out_shape"]
            ih = s[1] if len(s) == 4 else 0
            iw = s[2] if len(s) == 4 else 0
            ic = s[3] if len(s) == 4 else 0
            oh = o[1] if len(o) == 4 else 0
            ow = o[2] if len(o) == 4 else 0
            oc = o[3] if len(o) == 4 else 0
            kind = "DW" if l["is_depthwise"] else ("PW" if ic > 1 else "CONV")
            f.write(f"    /* [{i}] {kind} {ih}x{iw}x{ic} -> "
                    f"{oh}x{ow}x{oc} s{l['stride']} */\n")
            f.write(f"    {{ {ih}, {iw}, {ic}, "
                    f"{oh}, {ow}, {oc}, "
                    f"{l['stride']}, {l['pad_same']}, "
                    f"{l['is_depthwise']}, {l['relu6_en']}, "
                    f"0x{l['weight_base']:06X}, "
                    f"0x{l['bias_base']:06X}, "
                    f"0, 0, "
                    f"0x{l['requant_base']:06X}, "
                    f"{l['input_zp']}, {l['output_zp']}, {{0}} }},\n")
        f.write("};\n\n")

        f.write("/* Full operator list */\n")
        for i, l in enumerate(layers_meta):
            name = OP_NAMES.get(l["op_type"], "UNKNOWN")
            f.write(f"/*  op[{i:2d}] {name:25s}  "
                    f"{'x'.join(map(str, l['in_shape'])):>20s} -> "
                    f"{'x'.join(map(str, l['out_shape'])):<20s} */\n")

        f.write(f"\n#endif /* {guard} */\n")

    print(f"Wrote {header_path}")
    print(f"\n--- Summary ---")
    print(f"Total ops: {len(layers_meta)}")
    for op_type, name in OP_NAMES.items():
        count = sum(1 for l in layers_meta if l["op_type"] == op_type)
        if count:
            print(f"  {name}: {count}")
    print(f"Weight blob: {len(weight_blob)} bytes ({len(weight_blob)/1024:.1f} KB)")
    if len(weight_blob) > 256 * 1024:
        print(f"  WARNING: exceeds 256 KB weight BRAM!")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Pack TFLite model: separate weights from metadata")
    parser.add_argument("model", help="Path to .tflite model file")
    parser.add_argument("-o", "--output", default=".",
                        help="Output directory (default: current dir)")
    args = parser.parse_args()
    pack_model(args.model, args.output)
