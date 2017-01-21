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
__global__ void m6(int m, int n, int k, double *A, double *B, double *C) {
  double sum;
  int i = blockIdx.x*blockDim.x+threadIdx.x;
  int j = blockIdx.y*blockDim.y+threadIdx.y;

  extern __shared__ double two_blocks[];
  __shared__ double* A_s;
  A_s = &two_blocks[0];
  __shared__ double* B_s;
  B_s = &two_blocks[blockDim.x*blockDim.y];

  int ii = threadIdx.x;
  int jj = threadIdx.y;
  const int blockdim = blockDim.x;

  for (int w = 0; w < k; w += blockdim){
      sum = 0.0;
      A_s[jj*blockdim + ii] = A[j*k+ii+w];
      B_s[jj*blockdim + ii] = B[i+jj*n+w*n];
    __syncthreads();
      for (int h = 0; h < blockdim; h++) {
        sum += A_s[jj*blockdim + h] * B_s[h*blockdim + ii];
      }
      __syncthreads();
      C[i*n + j] += sum;
  }
}


extern "C" {
    void matmult_gpu6(int m, int n, int k, double *A, double *B, double *C) {
        double* d_A, * d_B, * d_C;
        cudaSetDevice(2);
        cudaMalloc((void**)&d_A, m*k * sizeof(double));
        cudaMalloc((void**)&d_B, k*n * sizeof(double));
        cudaMalloc((void**)&d_C, m*n * sizeof(double));


        cudaMemcpy(d_A, A, m*k * sizeof(double), cudaMemcpyHostToDevice);
        cudaMemcpy(d_B, B, k*n * sizeof(double), cudaMemcpyHostToDevice);

        // Initialize the output matrix with zeroes.
        cudaMemset(d_C, 0, m*n * sizeof(double));

        int bs = 32;
        dim3 blockDim(bs, bs);
        dim3 gridDim( (m-1)/blockDim.x+1, (n-1)/blockDim.y+1 );


        // https://devblogs.nvidia.com/parallelforall/using-shared-memory-cuda-cc/
        // dynamically "pass" the shared memory to the kernel function.
        // Otherwise we should place some constants in the kernel function.
        m6<<<gridDim, blockDim, (blockDim.x*blockDim.y * 2 * sizeof(double))>>>(m, n, k, d_A, d_B, d_C);
        cudaDeviceSynchronize();

        cudaMemcpy(C, d_C, m*n * sizeof(double), cudaMemcpyDeviceToHost);

        cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
    }
}
