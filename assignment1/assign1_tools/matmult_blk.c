#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#define MIN(a, b)  (((a) < (b)) ? (a) : (b))
void matmult_blk (int m,int n,int k,double **A,double **B,double **C, int bs){
	for (int i = 0; i < m; i++) {
		for (int j = 0; j < n; j++) {
    		C[i][j] = 0;
    	}
  }
	for (int i1 = 0; i1 < m; i1+=bs){
		int M = MIN(m-i1,bs);
		for (int h1 = 0; h1 < k; h1+=bs){
			int N = MIN(k-h1,bs);
			for (int j1 = 0; j1 < n; j1+=bs){
				int K = MIN(n-j1,bs);
				for (int i2 = 0; i2<M; i2++){
					for (int h2 = 0; h2<N; h2++)
						for (int j2 = 0; j2<K; j2++){
							C[i1+i2][j1+j2] += A[i1+i2][h1+h2]*B[h1+h2][j1+j2];
					}
				}
			}
		}
	}
}
