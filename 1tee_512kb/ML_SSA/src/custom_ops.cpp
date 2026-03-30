// In your custom_ops.cpp
TfLiteStatus ConvEval(TfLiteContext* context, TfLiteNode* node) {
    // Get tensor data from TFLite
    const TfLiteTensor* input  = GetInput(context, node, 0);
    const TfLiteTensor* filter = GetInput(context, node, 1);
    const TfLiteTensor* bias   = GetInput(context, node, 2);
    TfLiteTensor* output       = GetOutput(context, node, 0);

    // Extract conv params (stride, padding, etc.)
    auto* params = reinterpret_cast<TfLiteConvParams*>(node->builtin_data);

    // Parse dimensions
    int batches   = input->dims->data[0];
    int in_h      = input->dims->data[1];
    int in_w      = input->dims->data[2];
    int in_ch     = input->dims->data[3];
    int out_ch    = filter->dims->data[0];
    int filt_h    = filter->dims->data[1];
    int filt_w    = filter->dims->data[2];

    if (filt_h == 1 && filt_w == 1 && in_ch >= 32) {
        // Route to systolic array
        accel_pointwise_conv(
            input->data.int8, filter->data.int8,
            bias->data.i32, output->data.int8,
            in_h, in_w, in_ch, out_ch,
            /* quantization params from tensor->params */
        );
    } else {
        // Fall back to CPU reference for small layers
        // or route to vector unit for depthwise
        tflite::reference_ops::Conv(/* ... */);
    }
    return kTfLiteOk;
}