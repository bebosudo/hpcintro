#!/bin/sh
### General options
### –- specify queue --
#BSUB -q hpc
### -- set the job Name --
#BSUB -J My_Application
### -- ask for number of cores (default: 1) --
#BSUB -n 8
### -- set walltime limit: hh:mm --
#BSUB -W 1:00
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
#BSUB -o Output_%J.out
#BSUB -e Error_%J.err
#BSUB -R "select[model=XeonE5_2660v3]"

# here follow the commands you want to execute

declare -A size_its
size_its=( [512]=1000 [1024]=100 [2048]=10 [4096]=1 [8192]=1 [10240]=1 )

for method in lib
do
    for size in 512 1024 2048 4096 8192 #10240
    do
        printf "${method} "
        MFLOPS_MAX_IT=${size_its[${size}]} MATMULT_COMPARE=0 ./matmult_f.nvcc2 $method $size $size $size
    done
done