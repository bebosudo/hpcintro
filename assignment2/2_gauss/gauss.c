//#include <math.h>
#include <stdio.h>

void gauss (double * u, double * f, double lambda,
  int N, int kmax, double treshold, int * k) {

  double d = treshold+1;
  int M = N + 2;
  double lambda2 = lambda * lambda;
  double T;
  for (*k = 0; (*k < kmax && d > treshold); (*k)++){
    d = 0;
    for (int i = 1; i < N+1; i++) {
      for (int j = 1; j < N+1; j++) {
        T = 0.25 * ( u[(i-1)*M + j] + u[(i+1)*M + j] + u[i*M + (j-1)] + 
        u[i*M + (j+1)] + lambda2 * f[i*M + j] );
        
        d += (T - u[i*M + j]) * (T - u[i*M + j]);
        u[i*M+j] = T;
      }
    }
  }
}
