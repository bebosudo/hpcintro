#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

#define PRINT 1

__global__ void jacobi(double * uold, double * unew, double * f, int width, int height, double lambda2);

int main(int argc, char * argv[]){
	if (argc != 3){
		printf("Wrong number of argument (N kmax)");
		return -1;
	}

	int N = atoi(argv[1]);
	int M = N+2;
	int kmax = atoi(argv[2]);
	double lambda2 = (double)4/(M*M);

	// M*M room split into sections of M*Ha and M*Hb
	int HALF = M/2*M;	
	int HALF_1 = (M/2-1)*M;
	int H0 = (M/2) + 1;
	int H1 = 1+(M-1)/2 + 1;

	int size0 = M*H0*sizeof(double);
	int size1 = M*H1*sizeof(double);

	double *u1, *u2, *f;

	u1 =(double *)calloc(M*M,sizeof(double));
	u2 = (double *)calloc(M*M,sizeof(double));
	f = (double *)calloc(M*M,sizeof(double));
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
	}

	for (int i = 2*M/3; i <= 5*M/6; i++){
		for (int j = M/2; j <= 2*M/3; j++){
			f[i*M+j] = 200;
		}

	}

	double *d0_u1, *d0_u2, *d0_f;
	double *d1_u1, *d1_u2, *d1_f;

	cudaSetDevice(0);
	cudaDeviceEnablePeerAccess(1,0);
	cudaMalloc( (void**)&d0_u1, size0);
	cudaMalloc( (void**)&d0_u2, size0);
	cudaMalloc( (void**)&d0_f, size0);

	cudaMemcpy( d0_u1, u1, size0, cudaMemcpyHostToDevice );
	cudaMemcpy( d0_u2, u2, size0, cudaMemcpyHostToDevice );
	cudaMemcpy( d0_f, f, size0, cudaMemcpyHostToDevice );

	cudaSetDevice(1);
	cudaDeviceEnablePeerAccess(0,0);
	cudaMalloc( (void**)&d1_u1, size1);
	cudaMalloc( (void**)&d1_u2, size1);
	cudaMalloc( (void**)&d1_f, size1);

	cudaMemcpy( d1_u1, &u1[HALF_1], size1, cudaMemcpyHostToDevice );
	cudaMemcpy( d1_u2, &u2[HALF_1], size1, cudaMemcpyHostToDevice );
	cudaMemcpy( d1_f, &f[HALF_1], size1, cudaMemcpyHostToDevice );


	int blockSize = 32;
	dim3 dimBlock(blockSize,blockSize,1); 
  	int gridSize = 1 + ((M - 1) / (2*blockSize)); // M/(2*blockSize) round up.
  	dim3 dimGrid(gridSize,gridSize,1);

	double ts, te;
	ts = omp_get_wtime();
	for(int k = 0; k<kmax; k++){
		cudaMemcpy(d1_u1, &d0_u1[HALF_1], M*sizeof(double),cudaMemcpyDefault);
		cudaMemcpy(&d0_u1[HALF], &d1_u1[M], M*sizeof(double),cudaMemcpyDefault);

		// Update u2
		cudaSetDevice(0);
		jacobi<<<dimGrid,dimBlock>>>(d0_u1,d0_u2,d0_f,N,H0-2,lambda2);
		cudaSetDevice(1);
		jacobi<<<dimGrid,dimBlock>>>(d1_u1,d1_u2,d1_f,N,H1-2,lambda2);

		cudaMemcpy(d1_u2, &d0_u2[HALF_1], M*sizeof(double),cudaMemcpyDefault);
		cudaMemcpy(&d0_u2[HALF], &d1_u2[M], M*sizeof(double),cudaMemcpyDefault);

		// Update u1
		cudaSetDevice(0);
		jacobi<<<dimGrid,dimBlock>>>(d0_u2,d0_u1,d0_f,N,H0-2,lambda2);
		cudaSetDevice(1);
		jacobi<<<dimGrid,dimBlock>>>(d1_u2,d1_u1,d1_f,N,H1-2,lambda2);
	}
	cudaDeviceSynchronize();

	te = omp_get_wtime() - ts;

	cudaMemcpy(u1, d0_u1, HALF*sizeof(double), cudaMemcpyDeviceToHost );
	cudaMemcpy(&u1[HALF], &d1_u1[M], (M*M - HALF)*sizeof(double), cudaMemcpyDeviceToHost );

	fprintf(stderr,"%s\n", cudaGetErrorString(cudaGetLastError()));
	printf("%d %d %lf\n",N,kmax,te);

	#if PRINT
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
	#endif

	cudaFree(d0_u1);
	cudaFree(d0_u2);
	cudaFree(d0_f);
	cudaFree(d1_u1);
	cudaFree(d1_u2);
	cudaFree(d1_f);
	free(u1);
	free(u2);
	free(f);

	return 0;
}
