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
    int i = blockIdx.x*blockDim.x + threadIdx.x;
    int j = blockIdx.y*blockDim.y + threadIdx.y;

    // This variable 'two_blocks' (the name can be changed to whatever) comes
    // from the kernel invocation, and we have to "split" it manually into the
    // two variables we want to use.
    extern __shared__ double two_blocks[];
    __shared__ double* A_s;
    A_s = &two_blocks[0];
    __shared__ double* B_s;
    B_s = &two_blocks[blockDim.x*blockDim.y];

    if (i < m && j < n) {
        A_s[threadIdx.x*blockDim.y + threadIdx.y] = A[i*n + j];
        B_s[threadIdx.y*blockDim.x + threadIdx.x] = B[i*n + j];

        __syncthreads();

        int ii = threadIdx.x;
        int jj = threadIdx.x;
        double sum = 0.0;

        for (int h = 0; h < blockDim.y; h++) {
            sum += A_s[ii*blockDim.y + h] * B_s[h*n + jj];
        }
        C[i*n + j] += sum;
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


        // https://devblogs.nvidia.com/parallelforall/using-shared-memory-cuda-cc/
        // dynamically "pass" the shared memory to the kernel function.
        // Otherwise we should place some constants in the kernel function.
        m5<<<blockDim, gridDim, (blockDim.x*blockDim.y * 2 * sizeof(double))>>>(m, n, k, d_A, d_B, d_C);
        cudaDeviceSynchronize();

        cudaMemcpy(C, d_C, m*n * sizeof(double), cudaMemcpyDeviceToHost);

        cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
    }
}
