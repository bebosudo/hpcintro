#include <stdio.h>

void
jacobi(double * unew, double * uold, double * f,
      double lambda, int N, int kmax, double treshold, int * k){

  double lambda2 = lambda*lambda;
  int M = N+2;
  double* swapper;
  double diff = 0, d = treshold+1;    // TODO add in the latex that we are
        // using a different var `diff` to avoid using the same variable `d`
        // both for checking whether to enter the loop and for storing the
        // difference.. this is a problem because ....
  *k = 0;

    #pragma omp parallel shared(k, unew, uold, f, lambda2, M)
    {
        while (*k < kmax && d >= treshold) {

          #pragma omp for reduction(+: diff)
            for (int i = 1; i < N+1; i++) {
              for (int j = 1; j < N+1; j++) {
                unew[i*M+j] = ( 0.25*(uold[(i-1)*M+j]+uold[(i+1)*M+j]+
                              uold[i*M+j-1]+uold[i*M+j+1]+lambda2*f[i*M+j]) );
                diff += (unew[i*M+j]-uold[i*M+j])*(unew[i*M+j]-uold[i*M+j]);
              }
            } // implicit barrier here

          #pragma omp single
          {
            d = diff;
            (*k)++;
            diff = 0;
            swapper = uold;
            uold = unew;
            unew = swapper;
          }
      }
  }

  swapper = unew;
  unew = uold;
  unew = swapper;

        // TODO: ask whether the barriers exist only at the end of a directive or also at the beginning.
//    printf("d:%lf\n", d);
}
