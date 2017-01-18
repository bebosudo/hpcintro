#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <omp.h>
// M is the length of the vector, while N is the other side of the (MxN)matrix.
#define M 5678
#define N 12340

// Matrix: MxN, Vector: Nx1, Result (vector): (MxN X Nx1) --> Mx1.

// matrix vector multiplication
void __global__ mxv(int m, int n, double *matrix, double *vector, double* vec_ret) {
    int i, j;
    double sum;

    for (i=0; i<m; i++) {
        sum = 0.0;
        for (j=0; j<n; j++) {
            sum += matrix[i*n+j] * vector[j];
        }
        vec_ret[i] = sum;
    }
}


int main(void){
    // The results are stored in A.
    double * mat = (double *)malloc(M*N * sizeof(double));
    double * vec = (double *)malloc(N * sizeof(double));
    double * vec_out = (double *)malloc(M * sizeof(double));

    double *d_mat, *d_vec, *d_vec_out;
    cudaMalloc((void**)&d_mat, M*N * sizeof(double));
    cudaMalloc((void**)&d_vec, N * sizeof(double));
    cudaMalloc((void**)&d_vec_out, M * sizeof(double));

    // here we should check whether all these allocations are gone well.

    double time1 = omp_get_wtime();
    for (int i = 0; i < N*M; i++){
        mat[i] = 1;
    }
    for (int i = 0; i < N; i++){
        vec[i] = 1;
    }
    double elapsed1 = omp_get_wtime() - time1;

    // for (int i = 0; i < M; i++){
    //     vec_out[i] = 0;
    // }

    // we don't need to copy the output vector, since we are going to overwrite it.
    // cudaMemcpy(A_d, A, M*sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(d_mat, mat, M*N * sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(d_vec, vec, N * sizeof(double), cudaMemcpyHostToDevice);

    // M is the length of the vector, while N is the other side of the matrix.
    // int m_size = M;
    // int n_size = N;
    // if (m_size > 1024) {
    //     m_size = 1024;
    // }

    double time2 = omp_get_wtime();
    mxv<<<4, 32>>>(M, N, d_mat, d_vec, d_vec_out);
    cudaDeviceSynchronize();
    double elapsed2 = omp_get_wtime() - time2;

    double time3 = omp_get_wtime();
    cudaMemcpy(vec_out, d_vec_out, M * sizeof(double), cudaMemcpyDeviceToHost);
    double elapsed3 = omp_get_wtime() - time3;

    printf("memcpy HtoD: %lf\nmxv: %lf\nmemcpy DtoH: %lf\n\nTOTAL: %lf\n", elapsed1, elapsed2, elapsed3, elapsed1+elapsed2+elapsed3);

    // printf("vec_out[0] = %lf\n", vec_out[0]);
    // for (int i = 0; i<M; i++) {
    //     printf("%lf\n",vec_out[i]);
    // }

    free(mat); free(vec); free(vec_out);
    cudaFree(d_mat); cudaFree(d_vec); cudaFree(d_vec_out);
}
