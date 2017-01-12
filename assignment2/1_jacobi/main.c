#include <stdlib.h>
#include <stdio.h>
#include <omp.h>
void
jacobi(double * unew, double * uold, double * f,
      double lambda, int N, int kmax, double treshold, int * k);

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
    int M = N+2;
  for (int i = 2*M/3; i <= 5*M/6; i++){
    for (int j = M/2; j <= 2*M/3; j++){
      f[i*(N+2)+j] = 200;
    }
  }
  }
  double ts, te;
  ts = omp_get_wtime();
  int k = 0;
  jacobi(unew,uold,f,lambda,N,kmax,treshold,&k);
  te = omp_get_wtime() - ts;

  FILE *fp1 = fopen("results.txt","w");
  if (fp1 == NULL)
  {
    printf("Error opening file\n");
    return -1;
  }
  for (int i = 0; i < N+2; i++){
    for (int j = 0; j < N+2; j++){
      fprintf(fp1,"%.2lf ",unew[i*(N+2)+j]);
    }
    fprintf(fp1,"\n");
  }
  printf("%d %d %lf %lf\n",N,k,te,(double)k/te);
  return 0;
}
