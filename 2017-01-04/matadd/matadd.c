void
matadd(int m, int n, double **A, double **B, double **C) {
    
    int i, j;

    for(i = 0; i < m; i++)
	for(j = 0; j < n; j++)
	    C[i][j] = A[i][j] + B[i][j];
}
