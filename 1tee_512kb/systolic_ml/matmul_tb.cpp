#include <iostream>
#include <cstdlib>
#include <cstdint>
#include "matmul.h"

// ============================================================
// Testbench for matmul HLS kernel
//
// Usage in Vitis HLS:
//   1. Set this as the testbench file
//   2. Run C Simulation to verify correctness
//   3. Run C/RTL Co-simulation to verify cycle-accurate behavior
// ============================================================

// Golden reference: naive matmul
void matmul_ref(data_t A[N][N], data_t B[N][N], acc_t C[N][N]) {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            acc_t sum = 0;
            for (int k = 0; k < N; k++)
                sum += (acc_t)A[i][k] * (acc_t)B[k][j];
            C[i][j] = sum;
        }
}

int main() {
    data_t A[N][N], B[N][N];
    acc_t  C_dut[N][N], C_ref[N][N];

    // Seed for reproducibility
    srand(42);

    // --------------------------------------------------------
    // Test 1: Random values
    // --------------------------------------------------------
    std::cout << "Test 1: Random INT8 values (N=" << N << ")" << std::endl;

    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            A[i][j] = (data_t)(rand() % 256 - 128);  // -128 to 127
            B[i][j] = (data_t)(rand() % 256 - 128);
        }

    // Run DUT
    matmul(
        (data_t*)A,
        (data_t*)B,
        (acc_t*)C_dut
    );

    // Run reference
    matmul_ref(A, B, C_ref);

    // Compare
    int errors = 0;
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            if (C_dut[i][j] != C_ref[i][j]) {
                std::cout << "MISMATCH at [" << i << "][" << j << "]: "
                          << "DUT=" << C_dut[i][j]
                          << " REF=" << C_ref[i][j] << std::endl;
                errors++;
            }
        }

    // --------------------------------------------------------
    // Test 2: Identity matrix (A × I = A, widened to acc_t)
    // --------------------------------------------------------
    std::cout << "Test 2: Identity matrix" << std::endl;

    data_t I_mat[N][N];
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            I_mat[i][j] = (i == j) ? (data_t)1 : (data_t)0;

    matmul(
        (data_t*)A,
        (data_t*)I_mat,
        (acc_t*)C_dut
    );

    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            if (C_dut[i][j] != (acc_t)A[i][j]) {
                std::cout << "IDENTITY MISMATCH at [" << i << "][" << j << "]: "
                          << "DUT=" << C_dut[i][j]
                          << " Expected=" << (acc_t)A[i][j] << std::endl;
                errors++;
            }
        }

    // --------------------------------------------------------
    // Test 3: Zero matrix
    // --------------------------------------------------------
    std::cout << "Test 3: Zero matrix" << std::endl;

    data_t Z_mat[N][N] = {};

    matmul(
        (data_t*)A,
        (data_t*)Z_mat,
        (acc_t*)C_dut
    );

    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            if (C_dut[i][j] != 0) {
                std::cout << "ZERO MISMATCH at [" << i << "][" << j << "]: "
                          << "DUT=" << C_dut[i][j] << std::endl;
                errors++;
            }
        }

    // --------------------------------------------------------
    // Summary
    // --------------------------------------------------------
    if (errors == 0) {
        std::cout << "ALL TESTS PASSED" << std::endl;
        return 0;
    } else {
        std::cout << "FAILED: " << errors << " mismatches" << std::endl;
        return 1;
    }
}