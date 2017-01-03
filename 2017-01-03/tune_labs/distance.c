#include "distance.h"
#include <unistd.h>
#include <math.h>

#ifdef ALL_IN_ONE

double 
distance(particle_t *p, int n) {
    double dist = 0;
    double tot = 0;

    for(int i = 0; i<n; i++) {
        dist = sqrt(p[i].x*p[i].x + p[i].y*p[i].y + p[i].z*p[i].z);
        p[i].dist = dist;
        tot += dist;
    }
    return tot;
}

#else

double 
distance(particle_t *p, double *v, int n) {
    double dist = 0;
    double tot = 0;

    for(int i = 0; i<n; i++) {
        dist = sqrt(p[i].x*p[i].x + p[i].y*p[i].y + p[i].z*p[i].z);
        v[i] = dist;
        tot += dist;
    }
    return tot;
}

#endif
