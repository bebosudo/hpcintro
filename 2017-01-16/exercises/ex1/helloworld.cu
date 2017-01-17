#include <stdio.h>
#include <helper_cuda.h>

__global__ void hello();

int main(int argc, char const *argv[]) {

    hello<<<100, 100>>>();
    // checkCudaErrors(cudaDeviceSynchronize());
    cudaDeviceSynchronize();

    return 0;
}


__global__ void hello() {
    if (blockIdx.x*blockDim.x+threadIdx.x == 100) {
        int* a = (int*) 0x10000; *a = 0;
    }

    printf("Hello! I'm thread %d out of %d in block %d. My global thread is "
            "%d out of %d.\n",
            threadIdx.x, blockDim.x, blockIdx.x,
            blockIdx.x*blockDim.x+threadIdx.x,
            gridDim.x*blockDim.x);
}
