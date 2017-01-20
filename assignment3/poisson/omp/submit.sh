#!/bin/bash
# 02614 - High-Performance Computing, January 2017
# 
# batch script to run collect on a dedicated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
#PBS -N 3_omp_jac
#PBS -q hpcintro
#PBS -l nodes=1:ppn=20
#PBS -l walltime=1:00:00
OUTFILE=omp.txt
#PBS -o $OUTFILE

cd $PBS_O_WORKDIR

module load studio > /dev/null

EXECUTABLE=3_omp_jacobi
ITERATIONS_MAX=100  # we use a small number of iterations in order to make the
                    # program hit the stopping criterion, we don't need it to
                    # reach the end of the whole calculation.
THRESHOLD=0.0000001

# The N value 1260 is due to the comparison with the Mandelbrot function.
for N in 16 32 64 128 256 512 1024 2048 4096 8192
do
    for num_th in 8
    do
        printf "${num_th} " >> $OUTFILE
        OMP_NUM_THREADS=${num_th} ./${EXECUTABLE} $N $ITERATIONS_MAX $THRESHOLD >> $OUTFILE
    done
done

# experiment name
#
#JID=`echo ${PBS_JOBID%.*}`
#EXPOUT="$PBS_JOBNAME.${JID}.er"

# uncomment the HWCOUNT line, if you want to use hardware counters
# define an option string for the harwdware counters (see output of
# 'collect -h' for valid values.  The format is:
# -h cnt1,on,cnt2,on,...  (up to four counters at a time)
#
# the example below is for L1 hits, L1 misses, L2 hits, L2 misses
#
#HWCOUNT="-h dch,on,dcm,on,l2h,on,l2m,on"

#collect -o $EXPOUT $HWCOUNT ./${EXECUTABLE} $N $ITERATIONS_MAX $THRESHOLD