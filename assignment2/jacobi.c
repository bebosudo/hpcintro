void
jacobi(double * unew, double * uold, double * f, double lambda, unsigned int N, unsigned int kmax, double treshold){
  double d = treshold;
  for (int k = 0; (k > kmax || d < treshold); k++){
    for (int i = 1; i < N+1; i++){
      for (int j = 1; j < N+1; j++){
        unew[i*N+j] = ( 0.25*(unew[(i-1)*N+j]+uold[(i+1)*N+j]+
                      unew[i*N+j-1]+uold[i*N+j+1]+lambda*lambda*f[i*N+j]) );
        d = (unew[i*N+j]-uold[i*N+j])*(unew[i*N+j]-uold[i*N+j]);
      }
    }
  }
}
