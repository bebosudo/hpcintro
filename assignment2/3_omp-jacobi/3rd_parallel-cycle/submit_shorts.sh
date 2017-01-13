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

for N in 16 32 64 128 256
do
    for num_th in 1 2 4 8 16 32
    do
        printf "${num_th} " >> $OUTFILE
        OMP_NUM_THREADS=${num_th} ./${EXECUTABLE} $N $ITERATIONS_MAX $THRESHOLD >> $OUTFILE
    done
done
