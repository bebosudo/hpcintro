#include <stdio.h>
#include <helper_cuda.h>
#include "mandel.h"
#include "writepng.h"
#include <math.h>
#include <omp.h>


int main(int argc, char const *argv[]) {

    // just to avoid running the code on the 1st GPU (GPU=0) as everyone else.
    cudaSetDevice(6);
    int   width, height;
    int	  max_iter;
    int   *h_image;
    int   *d_image;

    width = height = 2601;
    max_iter = 400;

    // command line argument sets the dimensions of the image
    if ( argc == 2 ) width = height = atoi(argv[1]);

    int size_array = width * height * sizeof(int);

    // allocate space for two arrays on both the device and the host, but there's nothing to copy.
    h_image = (int *)malloc( size_array );
    checkCudaErrors(cudaMalloc(&d_image, size_array ));
    if ( h_image == NULL || d_image == NULL ) {
       fprintf(stderr, "memory allocation for the image failed!\n");
       return(1);
    }

    // mandel(width, height, image, max_iter);

    // dim3 dimBlock(32);   // 1D
    // The nvidia GPUs we are working on allow us to spawn at most 1024 threads
    // per block, so we can use blocks of 32 threads for each side. 32**2=1024.
    dim3 dimBlock(32, 32);

    // In this way we round up to the greatest integer without having to do casts.
    // (width-31)/dimBlock.x
    dim3 dimGrid(((width+dimBlock.x-1)/dimBlock.x), ((height+dimBlock.y-1)/dimBlock.y));

    // --------------- MANDEL EXECUTION  ----------------
    double time = omp_get_wtime();
    mandel<<<dimGrid, dimBlock>>>(width, height, d_image, max_iter);
    checkCudaErrors(cudaDeviceSynchronize());
    double elapsed = omp_get_wtime()-time;
    printf("\nmandel exec time = %lf\n", elapsed);
    // --------------------------------------------------


    // ----------------- COPY DtoH ----------------------
    double time_mem = omp_get_wtime();
    checkCudaErrors(cudaMemcpy(h_image, d_image, size_array, cudaMemcpyDeviceToHost));
    double elapsed_mem = omp_get_wtime()-time;
    printf("\ncopy DtoH time = %lf\n", elapsed_mem);
    // --------------------------------------------------


    writepng("mandelbrot.png", h_image, width, height);

    cudaFree(d_image);
    free(h_image);

    return(0);
}
