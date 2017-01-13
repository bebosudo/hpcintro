#!/bin/bash
# 02614 - High-Performance Computing, January 2017
# 
# batch script to run collect on a decidated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
# Note: to get more cores, change the ppn value below to the
#       number of cores you want to use.  Later on, use the
#       $PBS_NUM_PPN variable to use this number, e.g. in
#       export OMP_NUM_THREADS=$PBS_NUM_PPN
#
#PBS -N 3.3bis
#PBS -q hpcintro
#PBS -l nodes=1:ppn=4
#PBS -l walltime=10:00

cd $PBS_O_WORKDIR

module load studio

# define the executable here
#
EXECUTABLE=3_omp_jacobi

# define any command line options for your executable here
# N kmax threshold
#EXECOPTS=10000 100 0.001

# set some OpenMP variables here
#
# no. of threads
export OMP_NUM_THREADS=$PBS_NUM_PPN
#
# keep idle threads spinning (needed to monitor idle times!)
export OMP_WAIT_POLICY=active
#
# if you use a runtime schedule, define it below
# export OMP_SCHEDULE=


# experiment name 
#
JID=`echo ${PBS_JOBID%.*}`
EXPOUT="$PBS_JOBNAME.${JID}.er"

# start the collect command with the above settings
#collect -o $EXPOUT ./$EXECUTABLE $EXECOPTS
collect -o $EXPOUT ./$EXECUTABLE 5000 100 0.001
