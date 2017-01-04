/* datatools.h - support functions for the matrix examples
 *
 * Author:  Bernd Dammann, DTU Compute
 * Version: $Revision: 1.1 $ $Date: 2015/11/10 11:01:43 $
 */
#ifndef __DATATOOLS_H
#define __DATATOOLS_H

void init_data (int m, 		/* number of rows               */
                int n, 		/* number of columns            */
		double **A, 	/* two-dim array of size m-by-n */
		double **B  	/* two-dim array of size m-by-n */
               );

int check_results(char *comment, /* comment string 		 */
                  int m,         /* number of rows               */
		  int n,         /* number of columns            */
		  double **a      /* vector of length m           */
		 );

double ** malloc_2d(int m, 	/* number of rows               */
                    int n	/* number of columns            */
		   );

void free_2d(double **A);       /* free data allocated by malloc_2d */
#endif
