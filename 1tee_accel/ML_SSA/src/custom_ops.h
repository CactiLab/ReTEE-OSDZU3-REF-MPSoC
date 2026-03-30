#ifndef CUSTOM_OPS_H
#define CUSTOM_OPS_H

#include "tensorflow/lite/micro/micro_common.h"

TFLMRegistration Register_CONV_2D_ACCEL();
TFLMRegistration Register_DEPTHWISE_CONV_2D_ACCEL();

#endif /* CUSTOM_OPS_H */
