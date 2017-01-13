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
#PBS -l nodes=1:ppn=1
#PBS -l walltime=1:00:00
OUTFILE=3_omp_jac.3rd_version.${PBS_JOBID}.txt
#PBS -o $OUTFILE

cd $PBS_O_WORKDIR

module load studio > /dev/null

EXECUTABLE=3_omp_jacobi
ITERATIONS_MAX=1000000
THRESHOLD=0.001

for N in 512 1024
do
    for num_th in 1 2 4 8 16 32
    do
        OMP_NUM_THREADS=${num_th} ./${EXECUTABLE} $N $ITERATIONS_MAX $THRESHOLD > $OUTFILE
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