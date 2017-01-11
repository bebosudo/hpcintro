#include <stdlib.h>
#include <stdio.h>
void
jacobi(double * unew, double * uold, double * f, double lambda, int N, int kmax, double treshold);

int main(int argc, char * argv[]){
  if (argc != 4){
    printf("Wrong number of argument (N kmax treshold)");
    return -1;
  }
  int N = atoi(argv[1]);
  int kmax = atoi(argv[2]);
  double lambda = (double)2/(N+2);
  double treshold = atof(argv[3]);
  double * unew =(double *)calloc((N+2)*(N+2),sizeof(double));
  if (unew == NULL){
    printf("Memory allocation failed");
    return -1;
  }
  double * uold = (double *)calloc((N+2)*(N+2),sizeof(double));
  if (uold == NULL){
    printf("Memory allocation failed");
    return -1;
  }
  double * f = (double *)calloc((N+2)*(N+2),sizeof(double));
  if (uold == NULL){
    printf("Memory allocation failed");
    return -1;
  }
  for(int i = 0; i < N+1; i++){
    uold[i*(N+2)] = 20;
    uold[N+1+(N+2)*i] = 20;
    uold[i] = 20;
    unew[i*(N+2)] = 20;
    unew[(N+1)+i*(N+2)] = 20;
    unew[i] = 20;
  for (int i = 2*N/3+4/3; i < 5*N/6+5/3; i++){
    for (int j = N/2+1; j < 2*N/3+4/3; j++){
      f[i*(N+2)+j] = 200;
    }
  }
  }
  jacobi(unew,uold,f,lambda,N,kmax,treshold);
  for (int i = 0; i < N+2; i++){
    printf("\n");
    for (int j = 0; j < N+2; j++){
      printf("%2.2lf ",unew[i*(N+2)+j]);
    }
  }
  printf("\n");
  for (int i = 0; i < N+2; i++){
    printf("\n");
    for (int j = 0; j < N+2; j++){
      printf("%3.2lf ",f[i*(N+2)+j]);
    }
  }
  return 0;
}
