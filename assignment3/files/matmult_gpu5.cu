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


__global__ void m5(int m, int n, int k, double *A, double *B, double *C) {
    int i = blockIdx.x*blockDim.x+threadIdx.x;
    int j = blockIdx.y*blockDim.y+threadIdx.y;
    
    if (i < m && j < n){
      A_s[threadIdx.x*blockDim.y + threadId.y] = A[i*n + j];
      B_s[threadIdx.y*blockDim.x + threadId.x] = B[i*n + j];

      __syncthreads();

      for (int h = 0; h < blockDim.x; h++) {
          C[i*n + j] += A_s[i*k + h] * B_s[h*n + j];
      }
    }
  }


extern "C" {
    void matmult_gpu5(int m, int n, int k, double *A, double *B, double *C) {
        double* d_A, * d_B, * d_C;
        cudaMalloc((void**)&d_A, m*k * sizeof(double));
        cudaMalloc((void**)&d_B, k*n * sizeof(double));
        cudaMalloc((void**)&d_C, m*n * sizeof(double));


        cudaMemcpy(d_A, A, m*k * sizeof(double), cudaMemcpyHostToDevice);
        cudaMemcpy(d_B, B, k*n * sizeof(double), cudaMemcpyHostToDevice);

        // Initialize the output matrix with zeroes.
        cudaMemset(d_C, 0, m*n * sizeof(double));

        dim3 blockDim(16,16);
        dim3 gridDim( (m-1)/blockDim.x+1, (n-1)/blockDim.y+1 );

        __shared__ double * d_A_s, * d_B_s;
        cudaMalloc((void**)&d_A_s, blockDim.x * blockDim.y * sizeof(double));
        cudaMalloc((void**)&d_B, blockDim.x * blockDim.y * sizeof(double));

        m5<<<blockDim,gridDim>>>(m, n, k, d_A, d_B, d_C);
        cudaDeviceSynchronize();

        cudaMemcpy(C, d_C, m*n * sizeof(double), cudaMemcpyDeviceToHost);

        cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
    }
}
