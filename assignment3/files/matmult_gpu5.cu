#include <stdio.h>

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
    // This variable 'two_blocks' (the name can be changed to whatever) comes
    // from the kernel invocation, and we have to "split" it manually into the
    // two variables we want to use.
    extern __shared__ double two_blocks[];
    __shared__ double* A_s;
    A_s = &two_blocks[0];
    __shared__ double* B_s;
    B_s = &two_blocks[blockDim.x*blockDim.y];

    int topleft_row_A = blockIdx.y*blockDim.y*k;
    int topleft_col_B = blockIdx.x*blockDim.x;

    // The blocks HAVE to have the same size, otherwise this matrix-matrix 
    // mult on the small matrices cannot work.
    const int bl_side = blockDim.x;
    double sum;

    for (int w = 0; w < k; w += bl_side) {

        // We have to iterate over the two lines until reaching k.
        int topleft_row_A_curr_block = topleft_row_A + w;
        int topleft_col_B_curr_block = topleft_col_B + w*n;

        A_s[threadIdx.y*bl_side + threadIdx.x] = A[topleft_row_A_curr_block + threadIdx.y*k + threadIdx.x];
        // We just need each thread to load a single cell from the huge matrix
        // A & B, no matter if they don't load the same they are going to work on.
        B_s[threadIdx.y*bl_side + threadIdx.x] = B[topleft_col_B_curr_block + threadIdx.y*k + threadIdx.x];

        __syncthreads();

        sum = 0.0;
        for (int it=0; it < bl_side; it++) {
            sum += ( A_s[threadIdx.y*bl_side + it] * B_s[bl_side*it + threadIdx.x] );
        }

        // This second barrier syncronization is needed because there could be
        // some threads that could repeat the w_for loop and change A_s and B_s
        // while other are still reading from them.
        __syncthreads();

        // C[topleft_row_A_curr_block*n + topleft_col_B_curr_block + threadIdx.y*n + threadIdx.x] += sum;
        C[blockIdx.y*blockDim.y*n + threadIdx.y*n + blockIdx.x*blockDim.x + threadIdx.x] += sum;

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

        // Initialize the output C matrix with zeroes.
        cudaMemset(d_C, 0, m*n * sizeof(double));

        int bs = 16;
        dim3 blockDim(bs, bs);
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
