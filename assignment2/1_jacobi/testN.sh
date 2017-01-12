#!/bin/bash
for N in 16 32 64 128 256 512 1024
do
	./1_jacobi $N 100000 0.001
done
