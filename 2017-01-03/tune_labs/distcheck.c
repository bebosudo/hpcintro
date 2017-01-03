#include "distcheck.h"
#include <unistd.h>

#ifdef ALL_IN_ONE

double 
distcheck(particle_t *p, int n) {
    double tot = 0;
    for(int i = 0; i<n; i++) {
        tot += p[i].dist;
    }

    return tot;
}

#else

double 
distcheck(double *v, int n) {
    double tot = 0;
    for(int i = 0; i<n; i++) {
        tot += v[i];
    }

    return tot;
}

#endif
