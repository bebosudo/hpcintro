#include <stdio.h>
#include "cblas.h"
#include <stdlib.h>

// version from the 1st assignment, adapted to use single pointer array access.
extern void matmult_lib(int m, int n, int k, double *A, double *B, double *C){
  double alpha = 1.0, beta = 0.0;
  cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,
              m,n,k, alpha, A, k, B, n, beta, C, n);
}
