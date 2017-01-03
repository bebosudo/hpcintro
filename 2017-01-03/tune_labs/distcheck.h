#ifndef __DISTCHECK_H
#define __DISTCHECK_H

#include "data.h"

#ifdef ALL_IN_ONE
double distcheck(particle_t *, int);
#else
double distcheck(double *, int);
#endif

#define CHECK_FLOP 1	// put the right value here!
#endif
