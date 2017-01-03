#ifndef __DISTANCE_H
#define __DISTANCE_H

#include "data.h"

#ifdef ALL_IN_ONE
double distance(particle_t *, int);
#else
double distance(particle_t *, double *, int);
#endif

#define DIST_FLOP 10 // put the right value here
#endif
