TARGET	= matvec
OBJS	= main.o jacobi.o 

OPT	= -g
ISA	= 
PARA	=

XOPTS = -G -Xptxas=-v		#from cuda makefile
ARCH  = -arch=sm_30		#from cuda makefile
OMP   = -fopenmp 		#from cuda makefile

PARCH	      = $(shell uname -p)

CCC	= nvcc
CXX	= nvcc			
CXXFLAGS= -I

CFLAGS	= $(OPT) $(ISA) $(PARA) $(XOPT)

F90C  	= f90

LIBS	=  

CUDA_PATH ?= /appl/cuda/8.0
INCLUDES = -I$(CUDA_PATH)/include -I$(CUDA_PATH)/samples/common/inc

all: $(TARGET)

$(TARGET): $(OBJS) 
	$(CCC) $(CFLAGS) -o $@ $(OBJS) $(LIBS)

.SUFFIXES: .cu
.cu.o:
	$(CXX) -o $*.o -c $*.cu $(CXXFLAGS) $(SOFLAGS) $(INCLUDES)

clean:
	@/bin/rm -f *.o core

realclean: clean
	@rm -f $(TARGET)

# dependencies
#
main.o  : main.cu
matvec.o: matvec.cu
