#include <stdio.h>
#include <stdlib.h>
#include "data.h"
#include "init_data.h"

void
init_data(particle_t *data, int nparts) {

    int i;

    for(i = 0; i < nparts; i++ ) {
        data[i].x = drand48();
        data[i].y = drand48();
        data[i].z = drand48();
    }
}
