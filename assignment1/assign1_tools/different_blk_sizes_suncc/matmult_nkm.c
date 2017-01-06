#include <time.h>
#include <stdlib.h>
#include <stdio.h>

void matmult_nkm(int m,int n,int k,double **A,double **B,double **C){
	for (int i = 0; i < m; i++) {
		for (int j = 0; j < n; j++) {
    		C[i][j] = 0;
    	}
    }

    for (int j = 0; j < n; j++) {
        for (int h = 0; h < k; h++){
	        for (int i = 0; i < m; i++) {
				C[i][j] += A[i][h]*B[h][j];
			}
		}
	}
}