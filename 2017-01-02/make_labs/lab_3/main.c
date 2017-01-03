#include <stdio.h>
#include <stdlib.h>
#include "io.h"
#include "data.h"
int
main ( int argc, char *argv[] )   {
	
	printf("Starting my job...\n");
	io();
        data();
	printf("Done with my job.\n");
        return(EXIT_SUCCESS);
}
