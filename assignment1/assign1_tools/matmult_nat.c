#include <time.h>
#include <stdlib.h>
#include <stdio.h>

void matmult_nat(int m,int n,int k,double **A,double **B,double **C){
	for (int c = 0; c < reps; c++){
		for (int i = 0; i < m; i++) {
			for (int j = 0; j < n; j++) {
				for (int h = 0; h<k; h++){
					C[i][j] += A[i][h]*B[h][j];
				}
			}
		}
	}
	return C;
}