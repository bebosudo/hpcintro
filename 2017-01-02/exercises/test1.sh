#!/bin/sh
#PBS -N sleeper
#PBS -q hpcintro
#PBS -l walltime=2:00
cd $PBS_O_WORKDIR

sleep 10
