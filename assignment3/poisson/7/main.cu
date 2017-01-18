#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

__global__ void jacobi(double * uold, double * unew, double * f,int N, double lambda2);

int main(int argc, char * argv[]){
	if (argc != 3){
		printf("Wrong number of argument (N kmax)");
		return -1;
	}

	int N = atoi(argv[1]);
	int M = N+2;
	int kmax = atoi(argv[2]);
	double lambda2 = (double)4/(M*M);

	int size = M*M*sizeof(double);

	double *u1 =(double *)calloc(M*M,sizeof(double));
	double *u2 = (double *)calloc(M*M,sizeof(double));
	double *f = (double *)calloc(M*M,sizeof(double));
	if (u1 == NULL || u2 == NULL || f == NULL){
		printf("Memory allocation failed");
		return -1;
	}

	for(int i = 0; i < N+1; i++){
		u2[i*M] = 20;
		u2[N+1+M*i] = 20;
		u2[i] = 20;
		u1[i*M] = 20;
		u1[(N+1)+i*M] = 20;
		u1[i] = 20;
		for (int i = 2*M/3; i <= 5*M/6; i++){
			for (int j = M/2; j <= 2*M/3; j++){
				f[i*M+j] = 200;
			}
		}
	}

	double *d_u1, *d_u2, *d_f;

	
	cudaMalloc( (void**)&d_u1, size);
	cudaMalloc( (void**)&d_u2, size);
	cudaMalloc( (void**)&d_f, size);

	cudaMemcpy( d_f, f, size, cudaMemcpyHostToDevice );
	cudaMemcpy( d_u1, u1, size, cudaMemcpyHostToDevice );
	cudaMemcpy( d_u2, u2, size, cudaMemcpyHostToDevice );

	double ts, te;
	ts = omp_get_wtime();
	for(int k = 0; k<kmax; k++){
		jacobi<<<1,1>>>(d_u1,d_u2,d_f,N,lambda2);
		cudaDeviceSynchronize();
	
		jacobi<<<1,1>>>(d_u2,d_u1,d_f,N,lambda2);
		cudaDeviceSynchronize();
	}
	te = omp_get_wtime() - ts;

	cudaMemcpy( u1, d_u1, size, cudaMemcpyDeviceToHost );
	
	printf("Time: %4.3lf s\n", te);
	FILE *fp1 = fopen("results.txt","w");
	if (fp1 == NULL) {
		printf("Error opening file\n");
		return -1;
	}

	for (int i = 0; i < M; i++){
		for (int j = 0; j < M; j++){
			fprintf(fp1,"%.2lf ",u1[i*M+j]);
		}
		fprintf(fp1,"\n");
	}

	cudaFree(d_u1);
	cudaFree(d_u2);
	cudaFree(d_f);
	return 0;
}
