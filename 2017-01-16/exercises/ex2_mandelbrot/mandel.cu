#include <stdio.h>
// #include <helper_cuda.h>
#include "mandel.h"
#include "writepng.h"
#include <math.h>

__global__ void mandel(int disp_width, int disp_height,
                       int *array, int max_iter) {

    double 	scale_real, scale_imag;
    double 	x, y, u, v, u2, v2;
    int 	i, j, iter;

    scale_real = 3.5 / (double)disp_width;
    scale_imag = 3.5 / (double)disp_height;

    i = blockIdx.y * blockDim.y + threadIdx.y;
    j = blockIdx.x * blockDim.x + threadIdx.x;

    // If we are trying to access fields out of the array size, return.
    // if (col < disp_width) {
    if (i < disp_width && j < disp_height) {
    // for(i = 0; i < disp_width; i++)
        // printf("col: %d\n", col);

        // i = col; j = row;
        // i = row * gridDim.x * blockDim.x + col;
        x = ((double)i * scale_real) - 2.25;

        // for(j = 0; j < disp_height; j++) {

        y = ((double)j * scale_imag) - 1.75;

        u = v = u2 = v2 = 0.0;
        iter = 0;

        while ( u2 + v2 < 4.0 &&  iter < max_iter ) {
            v = 2 * v * u + y;
            u = u2 - v2 + x;
            u2 = u*u;
            v2 = v*v;
            iter = iter + 1;
        }

        // if we exceed max_iter, reset to zero
        iter = iter == max_iter ? 0 : iter;

        array[i*disp_width + j] = iter;
        // printf("%d \n", array[i*disp_height + j]);
    }
}
