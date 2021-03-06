// #include <stdio.h>

// Write a first sequential implementation (matmult gpu1()) of matrix multiplication on the
// GPU that uses only a single thread. It should work for all matrix sizes. Hints:
// – You need CUDA code to allocate memory on the GPU, transfer A and B to the
//     GPU, transfer C back to the CPU, and free the allocated memory.
//
// Time your kernel for small matrix sizes and compare to the reference DGEMM on the CPU.

// matrix times matrix
// m represents the number of rows (the vertical length) of A and C,
// k represents the number of columns of A and the n. of rows of B,
// n represents the number of columns (the horizontal length) of B and C.
//    ____k____            ____n____          ____n____
//    |        |           |        |         |       |
//  m |   A    |    X    k |   B    |  =   m  |   C   |
//    |        |           |        |         |       |
//    ---------            ---------          ---------

#include <cuda_runtime.h>
#include "cublas_v2.h"
#include "stdio.h"

extern "C" {
  void matmult_gpulib(int m, int n, int k, double *A, double *B, double *C) {
    cudaSetDevice(2);
    
    cublasHandle_t handle;
    cublasCreate(&handle);

    double alpha = 1.0, beta = 0.0;

    double* d_A, * d_B, * d_C;
    cudaMalloc((void**) &d_A, m*k * sizeof(double));
    cudaMalloc((void**) &d_B, k*n * sizeof(double));
    cudaMalloc((void**) &d_C, m*n * sizeof(double));
    cudaMemcpy(d_A, A,  m*k * sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B,  k*n * sizeof(double), cudaMemcpyHostToDevice);
    cudaMemset(d_C, 0,  m*n * sizeof(double));

    cublasDgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, m, n, k, &alpha, &d_A[0], k, &d_B[0], n, &beta, &d_C[0], n);

    cublasDestroy(handle);

    cudaMemcpy(C, d_C,  m*n * sizeof(double), cudaMemcpyDeviceToHost);
    cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);

  }
}
