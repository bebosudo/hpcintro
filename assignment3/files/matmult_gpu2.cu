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
//  m |    A   |   X    k  |   B    |  =    m  |   C   |
//    |        |           |        |          |       |
//    ---------            ---------           ---------


__global__ m1(int m, int n, int k, double *A, double *B, double *C, int out_row, int out_col) {
    int r, c;
    int i, j;
    double sum;

    for (i=0; i<m; i++) {
        // sum = 0.0;
        for (j=0; j<n; j++) {
    // double sum = 0.0;
    C[out_row*n + out_col] = 0.0;

    for(i=0; i<k; i++) {
        C[out_row*n + out_col] += A[out_row*n + i] * B[out_col + i];
    }
}

extern "C" {
    void matmult_gpu1(int m, int n, int k, double *A, double *B, double *C) {
        double* d_A, * d_B, * d_C;
        cudaMalloc((void**)&d_A, m*k * sizeof(double));
        cudaMalloc((void**)&d_B, k*n * sizeof(double));
        cudaMalloc((void**)&d_C, m*n * sizeof(double));


        cudaMemcpy(d_A, A, m*k * sizeof(double), cudaMemcpyHostToDevice);
        cudaMemcpy(d_B, B, k*n * sizeof(double), cudaMemcpyHostToDevice);


        m1<<<1,1>>>(m, n, k, d_A, d_B, d_C, i, j);

        cudaMemcpy(C, d_C, m*n * sizeof(double), cudaMemcpyDeviceToHost);

        cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
    }
}
