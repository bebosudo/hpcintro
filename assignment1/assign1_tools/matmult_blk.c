#include <time.h>
#include <stdlib.h>
#include <stdio.h>

#define MIN(a, b)  (((a) < (b)) ? (a) : (b))

void matmult_blk (int m,int n,int k,double **A,double **B,double **C){
	for (int i = 0; i < m; i++) {
		for (int j = 0; j < n; j++) {
    		C[i][j] = 0;
    	}
    }
	int nbi = 100;
	int nbj = 100;
	int nbk = 100;
	for (int i1 = 0; i1 < m; i1+=nbi){
		for (int j1 = 0; j1 < n; j1+=nbj){
			for (int h1 = 0; h1 < k; h1+=nbk){
				for (int i2 = 0; i2<MIN(m-i1,nbi); i2++){
					for (int j2 = 0; i2<MIN(n-j1,nbj); j2++){
						for (int h2 = 0; h2<MIN(k-h1,nbi); h2++)
							C[i1+i2][j1+j2] += A[i1+i2][h1+h2]*B[h1+h2][j1+j2];
					}
				}
			}
		}
	}
}