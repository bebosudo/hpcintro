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

__global__ void m4(int m, int n, int k, double *A, double *B, double *C) {
  double sum1 = 0, sum2 = 0, sum3 = 0, sum4 = 0;
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;
  i *= 4;
  if (i < m && j < n){
      for (int h = 0; h < k; h++) {
        sum1 += A[i*k + h] * B[h*n + j];
        sum2 += A[i*k + h] * B[h*n + j+1];
        sum3 += A[i*k + h] * B[h*n + j+2];
        sum4 += A[i*k + h] * B[h*n + j]+3;
      }
  C[i*n + j] = sum1;
  C[(i+1)*n + j+1] = sum2;
  C[(i+2)*n + j+2] = sum3;
  C[(i+3)*n + j+3] = sum4;
  }
}


extern "C" {
    void matmult_gpu4(int m, int n, int k, double *A, double *B, double *C) {
        double* d_A, * d_B, * d_C;
        cudaMalloc((void**)&d_A, m*k * sizeof(double));
        cudaMalloc((void**)&d_B, k*n * sizeof(double));
        cudaMalloc((void**)&d_C, m*n * sizeof(double));


        cudaMemcpy(d_A, A, m*k * sizeof(double), cudaMemcpyHostToDevice);
        cudaMemcpy(d_B, B, k*n * sizeof(double), cudaMemcpyHostToDevice);

        // Initialize the output matrix with zeroes.
        cudaMemset(d_C, 0, m*n * sizeof(double));
        dim3 BlockDim(16,16);
        dim3 NumBlocks((m/4-1)/16+1,((n-1)/16+1));
        m4<<<NumBlocks,BlockDim>>>(m, n, k, d_A, d_B, d_C);
        cudaDeviceSynchronize();

        cudaMemcpy(C, d_C, m*n * sizeof(double), cudaMemcpyDeviceToHost);

        cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
    }
}
