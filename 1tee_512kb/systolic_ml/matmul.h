#ifndef MATMUL_H
#define MATMUL_H

#include <ap_int.h>
#include <hls_stream.h>

// ============================================================
// Configuration — change N here to resize (16, 32, etc.)
// ============================================================
constexpr int N = 16;

// Data types
typedef ap_int<8>  data_t;    // INT8 input elements
typedef ap_int<32> acc_t;     // 32-bit accumulator (safe for N<=256 with INT8)

// Top-level function prototype
void matmul(
    data_t A[N][N],
    data_t B[N][N],
    acc_t  C[N][N]
);

#endif