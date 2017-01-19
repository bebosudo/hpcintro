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
//    ____k____            ____n____           ____n____
//    |        |           |        |          |       |
//  m |    A   |   X    k  |    B   |  =    m  |   C   |
//    |        |           |        |          |       |
//    ---------            ---------           ---------
#include <helper_cuda.h>
__global__ void m6(int m, int n, int k, double *A, double *B, double *C) {

  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  __shared__ double A_s[16*16];
  __shared__ double B_s[16*16];
  int ii = threadIdx.x;
  int jj = threadIdx.y;
  if (i < m && j < n){
    for (int w = 0; w < k; w += blockDim.x){
      A_s[threadIdx.x*blockDim.y + threadIdx.y] = A[blockIdx.x*blockDim.x*k+threadIdx.x*k+threadIdx.y+w];
      B_s[threadIdx.y*blockDim.x + threadIdx.x] = B[blockIdx.x*blockDim.y+threadIdx.y*n+threadIdx.x+w*n];
      for (int h = 0; h < blockDim.x; h++) {
        C[i*n + j] += A_s[ii*blockDim.x + h] * B_s[h*blockDim.x + jj];
      }
    }
  }
}


extern "C" {
    void matmult_gpu6(int m, int n, int k, double *A, double *B, double *C) {
        double* d_A, * d_B, * d_C;
        cudaMalloc((void**)&d_A, m*k * sizeof(double));
        cudaMalloc((void**)&d_B, k*n * sizeof(double));
        cudaMalloc((void**)&d_C, m*n * sizeof(double));


        cudaMemcpy(d_A, A, m*k * sizeof(double), cudaMemcpyHostToDevice);
        cudaMemcpy(d_B, B, k*n * sizeof(double), cudaMemcpyHostToDevice);

        // Initialize the output matrix with zeroes.
        cudaMemset(d_C, 0, m*n * sizeof(double));
        dim3 BlockDim(16,16);
        dim3 NumBlocks((m-1)/16+1,(n-1)/16+1);
        m6<<<NumBlocks,BlockDim>>>(m, n, k, d_A, d_B, d_C);
        checkCudaErrors(cudaDeviceSynchronize());

        cudaMemcpy(C, d_C, m*n * sizeof(double), cudaMemcpyDeviceToHost);

        cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
    }
}
