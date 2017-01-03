#ifndef __DATA_H
#define __DATA_H

/* define defaults for some parameters 
 * overwrite at compile time with -D... 
 * or make them dynamic in the source
 */
#define NUM_OF_PARTS 1000000
#ifndef NBYTES
#define NBYTES 1000
#endif

/* definition of the data structure */
#ifdef ALL_IN_ONE
/* everything in one */
typedef struct particle {
    double x, y, z;
    char someinfo[NBYTES];
    double dist;
} particle_t;

#else
/* without the distance part 
 */
typedef struct particle {
    double x, y, z;
    char someinfo[NBYTES];
} particle_t;

#endif

#endif /* _DATA_H */
