#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#define M 10
#define N 3
#define MAX 1000
// allocate a double-prec m x n matrix
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
  // de-allocting memory, allocated with
// dmalloc_2d
void dfree_2d(double **A) {
  free(A[0]);
  free(A);
}

int main(void){
  clock_t t1, t2;
  double tcpu;
  double ** A = dmalloc_2d(M,N);
  double * b = malloc(N*sizeof(double));
  double * c = malloc(M*sizeof(double));
  for (int i = 0; i < M; i++){
    for (int j = 0; j < N; j++){
      A[i][j] = 1;
    }
  for (int i = 0; i < N; i++){
    b[i] = 1;
  }
  }
  t1 = clock();
  for (int k = 0; k < MAX; k++){
    for (int i = 0; i < M; i++){
      c[i] = 0;
      for (int j = 0; j < N; j++){
        c[i] += b[j]*A[i][j];
      }
    }
  }
  t2 = clock();
  tcpu = (double)((t2 - t1)/CLOCKS_PER_SEC)/MAX;
  printf("\n");
  printf("CPU time: %lf",tcpu);
  printf("\n");
  printf("c = \n");
  for (int i = 0; i<M; i++){
    printf("%lf\n",c[i]);
  }
  dfree_2d(A);
  free(b);
  free(c);
}
