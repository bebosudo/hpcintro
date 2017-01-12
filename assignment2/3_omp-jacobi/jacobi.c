#include <stdio.h>

void
jacobi(double * unew, double * uold, double * f,
      double lambda, int N, int kmax, double treshold, int * k){

  double d = treshold+1;
  double lambda2 = lambda*lambda;
  int M = N+2;
  int i,j;

  #pragma omp parallel reduction(+: d)
  {
  for (*k = 0; (*k < kmax && d > treshold); (*k)++){
    d = 0;
    #pragma omp for
    for (i = 1; i < N+1; i++) {
      for (j = 1; j < N+1; j++) {
        unew[i*M+j] = ( 0.25*(uold[(i-1)*M+j]+uold[(i+1)*M+j]+
                      uold[i*M+j-1]+uold[i*M+j+1]+lambda2*f[i*M+j]) );

        d += (unew[i*M+j]-uold[i*M+j])*(unew[i*M+j]-uold[i*M+j]);
      }
    }
    for (i = 1; i < N+1; i++){
      for (j = 1; j < N+1; j++){
        uold[i*M+j] = unew[i*M+j];
      }
    }
  }
  }
}
