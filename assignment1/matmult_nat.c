#include <time.h>
#include <stdlib.h>
#include <stdio.h>

double ** dmalloc_2d(int m, int n) {
	if (m <= 0 || n <= 0) return NULL;
	double **A = malloc(m * sizeof(double *));
	if (A == NULL) return NULL;
	A[0] = malloc(m*n*sizeof(double));
	if (A[0] == NULL) {
		free(A);
		return NULL;
	}
	for (int i = 1; i < m; i++)
		A[i] = A[0] + i * n;
	return A;
}

void dfree_2d(double **A) {
	free(A[0]);
	free(A);
}

int main(void){

	int m = 3;
	int n = 2;
	int k = 5;

	double ** A = dmalloc_2d(m,k);
	double ** B = dmalloc_2d(k,n);
	double ** C = dmalloc_2d(m,n);

	for (int i = 0; i<m; i++){
		for (int j = 0; j<k; j++){
			A[i][j] = 10.0*(i+1) + j + 1;
		}
	}

	for (int i = 0; i<k; i++){
		for (int j = 0; j<n; j++){
			B[i][j] = 20.0*(i+1) + j + 1;
		}
	}

	for (int i = 0; i<m; i++){
		for (int j = 0; j<n; j++){
			C[i][j] = 0;
		}
	}

	int reps = 10000000;
	clock_t start, end;
	start = clock();
	for (int c = 0; c < reps; c++){
		for (int i = 0; i < m; i++) {
			for (int j = 0; j < n; j++) {
				for (int h = 0; h<k; h++){
					C[i][j] += A[i][h]*B[h][j];
				}
//				printf("%.2lf\t",C[i][j]);
			}
//			printf("\n");
		}
	}
	end = clock();
	double time = ((double) (end - start)) / CLOCKS_PER_SEC;
	double mflops = 2*m*n*k/time/1000000*reps;
	printf("%2f Mflops averaged over %d iterations in a total of %2f second\n",mflops,reps,time);

	dfree_2d(A);
	dfree_2d(B);
	dfree_2d(C);
}