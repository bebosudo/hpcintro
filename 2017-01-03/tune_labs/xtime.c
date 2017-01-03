/* xtime.c - timer routines */

#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/resource.h>

#define MICRO (double)1.0E-6

static double t_ovh;

void   init_timer (void);
void   init_timer_(void);
double xtime      (void);
double xtime_     (void);


void 
init_timer(void) {

    struct rusage r_src;
    double t0, t1, tdummy, usert, syst;
    int    i, ier, nrep;

       ier  = getrusage(RUSAGE_SELF, &r_src);
       if ( ier != 0 ) {
         perror("init_timer - getrusage parent"); exit(-1);
       }
/*        else */
/*          printf("Timings will be based on CPU times\n"); */

       nrep = 100;

       /*-- Estimate call overhead --*/

       ier   = getrusage(RUSAGE_SELF, &r_src);
       usert = (double)(r_src.ru_utime.tv_sec+MICRO*r_src.ru_utime.tv_usec);
       syst  = (double)(r_src.ru_stime.tv_sec+MICRO*r_src.ru_stime.tv_usec);
       t0    = usert+syst;
       for (i=0; i<nrep; i++)
           ier = getrusage(RUSAGE_SELF, &r_src);
       ier   = getrusage(RUSAGE_SELF, &r_src);
   
       usert = (double)(r_src.ru_utime.tv_sec+MICRO*r_src.ru_utime.tv_usec);
       syst  = (double)(r_src.ru_stime.tv_sec+MICRO*r_src.ru_stime.tv_usec);
       t_ovh = (usert+syst-t0)/(double)(nrep+2);
}

double 
xtime() {

    struct rusage r_src;
    double usert, syst;
    int ier;

       ier = getrusage(RUSAGE_SELF, &r_src);

       usert  = (double)(r_src.ru_utime.tv_sec+MICRO*r_src.ru_utime.tv_usec);
       syst   = (double)(r_src.ru_stime.tv_sec+MICRO*r_src.ru_stime.tv_usec);
       return(usert+syst-t_ovh);
}

void 
init_timer_(void) {
   (void) init_timer();
}

double 
xtime_(void) {
   return(xtime());
}
