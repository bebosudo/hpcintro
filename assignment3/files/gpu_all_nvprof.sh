#!/bin/sh
### General options
### –- specify queue --
#BSUB -q k40
### -- set the job Name --
#BSUB -J k40job
### -- ask for number of cores (default: 1) --
#BSUB -n 2
### -- Select the resources: 2 gpus in exclusive process mode --
#BSUB -R "rusage[ngpus_excl_p=2]"
### -- set walltime limit: hh:mm --
#BSUB -W 00:30
### -- set the email address --
# please uncomment the following line and put in your e-mail address,
# if you want to receive e-mail notifications on a non-default address
#BSUB -u your_email_address
### -- send notification at start --
##BSUB -B
### -- send notification at completion--
#BSUB -N
### -- Specify the output and error file. %J is the job-id --
### -- -o and -e mean append, -oo and -eo mean overwrite --
#BSUB -o gpu-ALL-profiling.out
#BSUB -e gpu-ALL-profiling.err

# -- end of LSF options --

# Load the cuda module
module load cuda/8.0

# * this program sees only the gpu's which are requested.
# * double check the number of your requested gpus above.
# * max-walltime in this queue is 30 minutes
# * this node has only 12 cores, so please don't request more
#   than 2 cpu-cores
#

declare -A size_its
size_its=( [512]=100 [1024]=10 [2048]=1 [4096]=1 [8192]=1 [10240]=1 )

# change TYPE also in the output file accordingly!!!
# gpu1 (the 1-thread sequential version) takes a lot of time (and usually is 
# killed by the walltime), so we need to reduce the sizes to make it work on.
# 
# for size in 512 1024 #2048 4096 8192 #10240
# do
#     printf "gpu1 "
#     MFLOPS_MAX_IT=${size_its[${size}]} MATMULT_COMPARE=0 ./matmult_f.nvcc2 gpu1 $size $size $size
# done

# The 'lib' version has to be sent on the CPU cluster nodes, with the other submitter, not on this GPU cluster.
# for method in gpu2 gpu3 gpu4 gpulib
for method in gpu1 gpu2 gpu3 gpu4 gpu5 gpu6 gpulib
do
    for size in 1600 #10240
    do
        printf "${method} "
        MFLOPS_MAX_IT=1 MATMULT_COMPARE=0 nvprof --metrics flops_dp ./matmult_f.nvcc2 $method $size $size $size
    done
done