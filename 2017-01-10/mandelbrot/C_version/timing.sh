#!/bin/bash
#PBS -N collector
#PBS -q hpcintro
#PBS -l walltime=0:10:00
OUTFILE=timingMandelbrot.${PBS_JOBID}.txt
#PBS -o $OUTFILE
cd $PBS_O_WORKDIR
module load studio

for i in 1 2 4 8 16 32
do
	printf "$i "
	OMP_NUM_THREADS=$i ./mandelbrot 1259 >> $OUTFILE
done