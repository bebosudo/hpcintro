#include <stdio.h>
#include <stdlib.h>
#include "data.h"
#include "xtime.h"
#include "init_data.h"
#include "distance.h"
#include "distcheck.h"

int
main(int argc, char *argv[]) {

    particle_t 	*parts = NULL;
#ifndef ALL_IN_ONE
    double	*dist = NULL;
#endif
    double 	total_length, check_length;
    int 	i, loops;
    int		nparts = NUM_OF_PARTS;
    double	ts, te_init, te_dist, te_check, ts_main, te_main;
    double	mf_dist, mf_check, mf_main;
    double	memory, mflops;

    if ( argc >= 2 ) {
	loops = atoi(argv[1]);
    } else {
	loops = 1;
    }
    if ( argc == 3 ) {
	nparts = atoi(argv[2]);
    }

    // allocate memory
    if ( (parts = calloc( nparts, sizeof(particle_t) )) == NULL ) {
        perror("main(__LINE__), allocation failed");
        exit(1);
    }

#ifndef ALL_IN_ONE
    if ( (dist = calloc( nparts, sizeof(double) )) == NULL ) {
        perror("main(__LINE__), allocation failed");
        exit(1);
    }
#endif

    init_timer();

    ts = xtime();
    ts_main = ts;
    init_data(parts, nparts);
    te_init = xtime() - ts;

    te_dist  = 0.0;
    te_check = 0.0;

    for( i = 0; i < loops; i++ ) {
	ts = xtime();
#ifdef ALL_IN_ONE
	total_length = distance(parts, nparts);
#else
	total_length = distance(parts, dist, nparts);
#endif
	te_dist += (xtime() - ts);

	ts = xtime();
#ifdef ALL_IN_ONE
	check_length = distcheck(parts, nparts);
#else
	check_length = distcheck(dist, nparts);
#endif
	te_check += (xtime() - ts);
    }

    te_main = xtime() - ts_main;


    memory  = nparts * sizeof(particle_t);
#ifndef ALL_IN_ONE
    memory += nparts * sizeof(double);
#endif
    memory /= 1024.0;	// in kbytes

    mflops   = 1.0e-06 * nparts * loops;
    mf_dist  = DIST_FLOP  * mflops / te_dist;
    mf_check = CHECK_FLOP * mflops / te_check;
    mf_main =  (DIST_FLOP + CHECK_FLOP) * mflops / te_main;

#ifndef DATA_ANALYSIS

    printf("Times (secs):\n");
    printf("\tInitialize : %lf\n", te_init);
    printf("\tCalculation: %lf\n", te_dist);
    printf("\tChecks     : %lf\n", te_check);
    printf("\tTotal      : %lf\n", te_main);

    printf("\nTotal length: %lf\n", total_length);
    printf("Check length: %lf\n", check_length);

    printf("Size of particle_t: %d", sizeof(particle_t));
#ifdef ALL_IN_ONE
    printf(" (incl. dist)\n");
#else
    printf("\n");
#endif
    printf("Filling bytes: %d\n", NBYTES);

    printf("Memory footprint (bytes): %7.2lf\n", memory);

#else 

    /*
    printf("%7.2lf %le %le %le %le\n", 
	   memory, te_init, te_dist, te_check, te_main);
    */
    printf("%10.2lf %le %le %le %le\n", 
	   memory, mf_dist, mf_check, mf_main, te_main);
#endif

    free(parts); 
#ifndef ALL_IN_ONE
    free(dist);
#endif
    return(0);
}
