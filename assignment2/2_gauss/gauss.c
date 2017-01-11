//#include <math.h>
#include <stdio.h>

void gauss (double * unew, double * uold, double * f, double lambda,
            unsigned int N, unsigned int kmax, double treshold) {

  double d = 0;
  int M = N + 2;
  int k = 0;
  double lambda2 = lambda * lambda;

  do {
//    printf("%d\n", k);
    d = 0;
    for (int i = 1; i < N+1; i++) {
      for (int j = 1; j < N+1; j++) {

        unew[i*M+j] = 0.25 * ( unew[(i-1)*M + j] + uold[(i+1)*M + j] +
                        unew[i*M + (j-1)] + uold[i*M + (j+1)] +
                        lambda2 * f[i*M + j] );

        d += (unew[i*M + j] - uold[i*M + j]) * (unew[i*M + j] - uold[i*M + j]);
        uold[i*M + j] = unew[i*M + j];
      }
    }
    k++;
  } while (k < kmax && d > treshold);

  printf("k=%d - d=%lf\n", k, d);
}
