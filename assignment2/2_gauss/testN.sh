#!/bin/bash
#PBS -N collector
#PBS -q hpcintro
#PBS -l walltime=0:45:00
OUTFILE=timingGauss.${PBS_JOBID}.txt
#PBS -o $OUTFILE
cd $PBS_O_WORKDIR
module load studio


for N in 16 32 64 128 256 512 1024
do
	./2_gauss $N 1000000 0.001 >> $OUTFILE
done
