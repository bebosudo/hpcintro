#include <stdlib.h>
#include <stdio.h>

void gauss (double * unew, double * uold, double * f, double lambda,
            unsigned int N, unsigned int kmax, double treshold);

void print_matrix(double* m, int row_width);

int main (int argc, char * argv[]){
  if (argc != 4){
    printf("Wrong number of arguments.\n usage: %s points_resolution kmax treshold.\n\n", argv[0]);
    return -1;
  }

  int N = atoi(argv[1]);
  int kmax = atoi(argv[2]);
  double lambda = (double)2/(N+2);
  double treshold = atof(argv[3]);
  double * unew =(double *)calloc((N+2)*(N+2),sizeof(double));
  double * uold = (double *)calloc((N+2)*(N+2),sizeof(double));
  double * f = (double *)calloc((N+2)*(N+2),sizeof(double));

  if (unew == NULL || uold == NULL || f == NULL){
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
  for (int i = N/2; i < 2*N/3+1; i++){
    for (int j = 2*N/3; j < 5*N/6+1; j++){
      f[i*(N+2)+j] = 200;
    }
  }
  }

  int row_width = N+2;


  printf("\n");
  printf("f:");
  print_matrix(f, row_width);

  printf("uold:");
  print_matrix(uold, row_width);


  gauss(unew, uold, f, lambda, N, kmax, treshold);

  printf("unew:");
  print_matrix(unew, row_width);

  return 0;
}




void print_matrix(double* m, int row_width) {
  for (int i = 0; i < row_width; i++) {
    printf("\n");
    for (int j = 0; j < row_width; j++) {
      printf("%.2lf ", m[i*row_width + j]);
    }
  }; printf("\n\n");
}
