#include <stdio.h>
__global__ void jacobi(double * uold, double * unew, double * f, int N, double lambda2){
	int M = N+2;
	for (int i = 1; i < N+1; i++){
		for (int j = 1; j < N+1; j++){
			unew[i*M+j] = ( 0.25*(uold[(i-1)*M+j]+uold[(i+1)*M+j]+
				uold[i*M+j-1]+uold[i*M+j+1]+lambda2*f[i*M+j]) );
		}
	}
}
