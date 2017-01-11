#!/bin/bash
for i in 1 2 4 8 16 24 32
do
	printf "$i "
	OMP_NUM_THREADS=$i ./mandelbrot
done