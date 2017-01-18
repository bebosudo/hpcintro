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


__global__ m2(int m, int n, int k, double *A, double *B, double *C, int out_row, int out_col)
    int r, c;
    int i, j;
    double sum;
    i = blockIdx.x*blockDim.x+threadIdx.x;
    j = blockIdx.y*blockDim.y+threadIdx.y;
    if (i < m && j < n);
      for (int h = 0; h < k; h++){
          C[i][j] += A[i][h]*B[h][j];
		  }
    }
  }

extern "C" {
    void matmult_gpu2(int m, int n, int k, double *A, double *B, double *C) {
        double* d_A, * d_B, * d_C;
        cudaMalloc((void**)&d_A, m*k * sizeof(double));
        cudaMalloc((void**)&d_B, k*n * sizeof(double));
        cudaMalloc((void**)&d_C, m*n * sizeof(double));


        cudaMemcpy(d_A, A, m*k * sizeof(double), cudaMemcpyHostToDevice);
        cudaMemcpy(d_B, B, k*n * sizeof(double), cudaMemcpyHostToDevice);

        dim3 BlockDim(16,16);
        dim3 NumBlocks(k/16,m/16);
        double time = omp_get_wtime();
        m2<<<BlockDim,NumBlocks>>>(m, n, k, d_A, d_B, d_C, i, j);
        cudaDeviceSynchronize();
        double elapsed1 = omp_get_wtime() - time;

        cudaMemcpy(C, d_C, m*n * sizeof(double), cudaMemcpyDeviceToHost);

        printf("Kernel: %lf\n",elapsed1);
        cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
    }
}
