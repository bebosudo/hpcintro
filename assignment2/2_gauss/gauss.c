//#include <math.h>
#include <stdio.h>

void gauss (double * unew, double * uold, double * f, double lambda,
            int N, int kmax, double treshold) {

  double d = treshold+1;
  int M = N + 2;
  int k = 0;
  double lambda2 = lambda * lambda;
  for (k = 0; (k < kmax && d > treshold); k++){
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
  }

  printf("%d %d ",N,k);
}
