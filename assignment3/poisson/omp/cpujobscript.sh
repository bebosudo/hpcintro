#!/bin/sh
### General options
### –- specify queue --
#BSUB -q hpc
### -- set the job Name --
#BSUB -J omp
### -- ask for number of cores (default: 1) --
#BSUB -n 8
### -- set walltime limit: hh:mm --
#BSUB -W 0:30
### -- set the email address --
# please uncomment the following line and put in your e-mail address,
# if you want to receive e-mail notifications on a non-default address
##BSUB -u your_email_address
### -- send notification at start --
#BSUB -B
### -- send notification at completion --
#BSUB -N
### -- Specify the output and error file. %J is the job-id --
### -- -o and -e mean append, -oo and -eo mean overwrite --
#BSUB -o cpuOMP%J.out
#BSUB -e cpuOMP%J.err
#BSUB -R "select[model=XeonE5_2660v3]"

# here follow the commands you want to execute

for N in 16 32 64 128 256 512 1024 2048 4096 8192
do
	OMP_NUM_THREADS=8 ./3_omp_jacobi $N 100
done
