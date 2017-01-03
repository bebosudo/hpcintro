#include <stdio.h>
#include "data.h"

void 
data(void) { 
    double x, y;
    int i;

    printf("Working on data...\n");

    for(i = 0; i < 20; i++ ) {
	x = 0.5 * M_PI * i;
	y = sin(x);
	printf("%lf\t%+lf\n", x, y);
    }
    printf("...done.\n");
};
