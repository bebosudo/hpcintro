#include <stdio.h>

void
jacobi(double * unew, double * uold, double * f,
      double lambda, int N, int kmax, double treshold, int * k){

  double lambda2 = lambda*lambda;
  int M = N+2;
  int i,j;
  double d = treshold;
  *k = 0;

  printf("here\n");

    #pragma omp parallel shared(d)
    {
        while (*k < kmax && d >= treshold) {
            printf("-");
            #pragma omp master
            {
                printf(".");
                (*k)++;
                d = 0;
            }

            #pragma omp for
            for (i = 1; i < N+1; i++) {
              for (j = 1; j < N+1; j++) {
                unew[i*M+j] = ( 0.25*(uold[(i-1)*M+j]+uold[(i+1)*M+j]+
                              uold[i*M+j-1]+uold[i*M+j+1]+lambda2*f[i*M+j]) );
              }
            } // implicit barrier here

            #pragma omp for reduction(+: d)
            for (i = 1; i < N+1; i++){
              for (j = 1; j < N+1; j++){
                d += (unew[i*M+j]-uold[i*M+j])*(unew[i*M+j]-uold[i*M+j]);
                uold[i*M+j] = unew[i*M+j];
              }
            } // implicit barrier here
      }
  }

}
