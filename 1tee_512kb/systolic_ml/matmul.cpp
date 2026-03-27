#include "matmul.h"

// ============================================================
// Systolic-style Matrix Multiply: C = A × B
//
// Strategy:
//   - Local BRAM buffers for A, B, C to avoid external memory
//     access during compute.
//   - Array partitioning along the inner dimension (k) so the
//     MAC inner loop can be fully unrolled → each unrolled
//     iteration maps to one DSP48 slice.
//   - Pipeline the outer loops to get a new result element
//     every cycle after the initial pipeline fill.
//
// Resource estimate (N=16):
//   DSP48:  16  (one per unrolled MAC)
//   BRAM:   depends on partitioning; ~2-4 BRAM18K
//   Latency: ~N*N*II + pipeline depth ≈ 256–300 cycles
//
// For N=32:
//   DSP48:  32
//   Latency: ~1024–1100 cycles
// ============================================================

void matmul(
    data_t A[N][N],
    data_t B[N][N],
    acc_t  C[N][N]
)
{
    // --------------------------------------------------------
    // Interface directives
    // --------------------------------------------------------
    // Use AXI4 memory-mapped for data arrays (easy SoC integration)
    #pragma HLS INTERFACE m_axi port=A offset=slave bundle=gmem0 depth=N*N
    #pragma HLS INTERFACE m_axi port=B offset=slave bundle=gmem1 depth=N*N
    #pragma HLS INTERFACE m_axi port=C offset=slave bundle=gmem2 depth=N*N

    // AXI-Lite control bus for start/done/idle + base addresses
    #pragma HLS INTERFACE s_axilite port=A     bundle=control
    #pragma HLS INTERFACE s_axilite port=B     bundle=control
    #pragma HLS INTERFACE s_axilite port=C     bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control

    // --------------------------------------------------------
    // Local buffers in BRAM
    // --------------------------------------------------------
    data_t A_local[N][N];
    data_t B_local[N][N];
    acc_t  C_local[N][N];

    // Partition along the k-dimension (dim=2 for A, dim=1 for B)
    // so all k-elements are accessible simultaneously.
    #pragma HLS ARRAY_PARTITION variable=A_local dim=2 complete
    #pragma HLS ARRAY_PARTITION variable=B_local dim=1 complete
    // C_local doesn't need partitioning — we write one element at a time
    #pragma HLS ARRAY_PARTITION variable=C_local dim=0 off

    // --------------------------------------------------------
    // Load A from external memory into local BRAM
    // --------------------------------------------------------
    LOAD_A_ROW:
    for (int i = 0; i < N; i++) {
        LOAD_A_COL:
        for (int j = 0; j < N; j++) {
            #pragma HLS PIPELINE II=1
            A_local[i][j] = A[i * N + j];
        }
    }

    // --------------------------------------------------------
    // Load B from external memory into local BRAM
    // --------------------------------------------------------
    LOAD_B_ROW:
    for (int i = 0; i < N; i++) {
        LOAD_B_COL:
        for (int j = 0; j < N; j++) {
            #pragma HLS PIPELINE II=1
            B_local[i][j] = B[i * N + j];
        }
    }

    // --------------------------------------------------------
    // Compute: systolic-style MAC
    // --------------------------------------------------------
    // The k-loop is fully unrolled → N parallel multipliers
    // The i,j loops are pipelined → one C element per cycle
    // --------------------------------------------------------
    COMP_I:
    for (int i = 0; i < N; i++) {
        COMP_J:
        for (int j = 0; j < N; j++) {
            #pragma HLS PIPELINE II=1

            acc_t sum = 0;

            COMP_K:
            for (int k = 0; k < N; k++) {
                #pragma HLS UNROLL
                sum += (acc_t)A_local[i][k] * (acc_t)B_local[k][j];
            }

            C_local[i][j] = sum;
        }
    }

    // --------------------------------------------------------
    // Store C back to external memory
    // --------------------------------------------------------
    STORE_C_ROW:
    for (int i = 0; i < N; i++) {
        STORE_C_COL:
        for (int j = 0; j < N; j++) {
            #pragma HLS PIPELINE II=1
            C[i * N + j] = C_local[i][j];
        }
    }
}