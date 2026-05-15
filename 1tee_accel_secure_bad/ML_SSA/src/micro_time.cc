#include "tensorflow/lite/micro/micro_time.h"
#include <stdint.h>

namespace tflite {

uint32_t ticks_per_second() { return 100000000; }  // adjust to your CPU freq

uint32_t GetCurrentTimeTicks() {
    uint32_t cycles;
    asm volatile("csrr %0, mcycle" : "=r"(cycles));
    return cycles;
}

}  // namespace tflite
