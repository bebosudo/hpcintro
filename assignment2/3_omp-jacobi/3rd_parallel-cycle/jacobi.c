#include <stdio.h>

void
jacobi(double * unew, double * uold, double * f,
      double lambda, int N, int kmax, double treshold, int * k){

  double lambda2 = lambda*lambda;
  int M = N+2;
  double d = treshold , diff = treshold;    // TODO add in the latex that we are
        // using a different var `diff` to avoid using the same variable `d`
        // both for checking whether to enter the loop and for storing the
        // difference.. this is a problem because ....
  *k = 0;

    #pragma omp parallel shared(k, d, unew, uold, f, lambda2, M)
    {
        while (*k < kmax && diff >= treshold) {

            #pragma omp barrier
            #pragma omp single
            {
//                printf("k=%d, d=%lf\n", *k, d);
//                print
                (*k)++;
                d = 0;
                diff = treshold+1;
            }
//            #pragma omp barrier

            #pragma omp for /*private(i, j)*/
            for (int i = 1; i < N+1; i++) {
              for (int j = 1; j < N+1; j++) {
                unew[i*M+j] = ( 0.25*(uold[(i-1)*M+j]+uold[(i+1)*M+j]+
                              uold[i*M+j-1]+uold[i*M+j+1]+lambda2*f[i*M+j]) );
              }
            } // implicit barrier here

            #pragma omp for reduction(+: d)
            for (int i = 1; i < N+1; i++){
              for (int j = 1; j < N+1; j++){
                d += (unew[i*M+j]-uold[i*M+j])*(unew[i*M+j]-uold[i*M+j]);
                uold[i*M+j] = unew[i*M+j];
              }
            } // implicit barrier here

            #pragma omp single nowait       // TODO check whether nowait is required.. but anyway it should improve the performances.
            {
                diff = d;
            }
      }
  }
        // TODO: ask whether the barriers exist only at the end of a directive or also at the beginning.
//    printf("d:%lf\n", d);
}
