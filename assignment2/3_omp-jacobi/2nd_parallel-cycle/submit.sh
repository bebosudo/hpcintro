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
OUTFILE=3_omp_jac.2nd_version.${PBS_JOBID}.txt
#PBS -o $OUTFILE

cd $PBS_O_WORKDIR

module load studio > /dev/null

EXECUTABLE=3_omp_jacobi
ITERATIONS_MAX=100  # we use a small number of iterations in order to make the
                    # program hit the stopping criterion, we don't need it to
                    # reach the end of the whole calculation.
THRESHOLD=0.001


for N in 128 256 512 1024 1260 2048 4096 8192 10000
do
    for num_th in 1 2 4 8 16 32
    do
        printf "${num_th} " >> $OUTFILE
        OMP_NUM_THREADS=${num_th} ./${EXECUTABLE} $N $ITERATIONS_MAX $THRESHOLD >> $OUTFILE
    done
done
