#include <stdlib.h>
#include <stdio.h>

void
jacobi(double * unew, double * uold, double * f, double lambda, unsigned int N, unsigned int kmax, double treshold);

int main(int argc, char * argv[]){
  int N = 10;


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
  for(int j = 0; j < N+1; j++){
    uold[(j*(N+1)] = 20;
    uold[(N+1)+j*(N+1)] = 20;
    uold[j] = 20;
    unew[(j*(N+1)] = 20;
    unew[(N+1)+j*(N+1)] = 20;
    unew[j] = 20;
    f[]
  }
}
