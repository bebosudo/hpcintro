#include <stdio.h>
// #include <helper_cuda.h>
#include "mandel.h"
#include "writepng.h"
#include <math.h>


int main(int argc, char const *argv[]) {

    int   width, height;
    int	  max_iter;
    int   *image;

    width = height = 2601;
    max_iter = 400;

    // command line argument sets the dimensions of the image
    if ( argc == 2 ) width = height = atoi(argv[1]);

    // image = (int *)malloc( width * height * sizeof(int));
    cudaMalloc(image, width * height * sizeof(int));
    if ( image == NULL ) {
       fprintf(stderr, "memory allocation for the image failed!\n");
       return(1);
    }

    // mandel(width, height, image, max_iter);

    // 32 is the number of threads for each GPUs
    int num_blocks = ceil(width/32.0);
    mandel<<<num_blocks, 32>>>(width, height, image, max_iter);

    // checkCudaErrors(cudaDeviceSynchronize());
    cudaDeviceSynchronize();

    writepng("mandelbrot.png", image, width, height);

    cudaFree(image);
    
    return(0);
}
