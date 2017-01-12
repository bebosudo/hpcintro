#!/bin/bash
#PBS -N collector
#PBS -q hpcintro
#PBS -l walltime=0:05:00
OUTFILE=timing.${PBS_JOBID}.txt
#PBS -o $OUTFILE
cd $PBS_O_WORKDIR
module load studio


for N in 16 32 64 128 256
do
	./1_jacobi $N 100000 0.001 > $OUTFILE
done
