#!/usr/bin/env sh
#PBS -N looper
#PBS -q hpcintro
OUTFILE=$PBS_JOBNAME.$PBS_JOBID.out
ERRFILE=$PBS_JOBNAME.$PBS_JOBID.err
#PBS -o $OUTFILE
#PBS -e $ERRFILE

cd $PBS_O_WORKDIR


# to submit to the cluster (adapt walltime in case of need):
#   qsub -m abe -q hpc -l walltime=30:00 submit.sh

# NOTE: in (ba)sh, to append (!) we must use two angle brackets `>>':
# a single angle bracket overwrites any data already in the file.


for npart in 1000 5000 10000 50000 100000 200000 400000
do
    for nloops in 1000 2000 5000 7500 10000
    do
        for nbytes in 10 100 1000
        do
            echo "Executing internal with ${npart} particles, with ${nloops} loops and ${nbytes} bytes."
            printf "int ${npart} ${nloops} ${nbytes} " >> $OUTFILE
            ./internal_${nbytes}nB $nloops $npart >> $OUTFILE

            echo "Executing external with ${npart} particles, with ${nloops} loops and ${nbytes} bytes."
            printf "ext ${npart} ${nloops} ${nbytes} " >> $OUTFILE
            ./external_${nbytes}nB $nloops $npart >> $OUTFILE
        done
    done
done


exit 0

