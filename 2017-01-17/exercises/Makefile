TARGET	= mxv
OBJS	= mxv.o

OPT	= -g
ISA	=
PARA	=

XOPTS = -G -Xptxas=-v		#from cuda makefile
ARCH  = -arch=sm_30			#from cuda makefile
OMP   = -fopenmp 			#from cuda makefile

# PNGWRITERPATH = pngwriter
# PARCH	      = $(shell uname -p)
# PNGWRTLPATH   = $(PNGWRITERPATH)/lib/$(PARCH)
# PNGWRTIPATH   = $(PNGWRITERPATH)/include
# PNGWRITERLIB  = $(PNGWRTLPATH)/libpngwriter.a

CCC	= nvcc
CXX	= nvcc
# CXXFLAGS= -I $(PNGWRTIPATH)

CUDA_PATH ?= /appl/cuda/8.0
INCLUDES = -I$(CUDA_PATH)/include -I$(CUDA_PATH)/samples/common/inc

CFLAGS	= $(OPT) $(ISA) $(PARA) $(XOPT)  --compiler-options "$(OPT) $(PIC) $(OMP)"

F90C  	= f90

# LIBS	= -L $(PNGWRTLPATH) -lpngwriter -lpng


# all: $(PNGWRITERLIB) $(TARGET)
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CCC) $(CFLAGS) -o $@ $(OBJS) $(LIBS)

.SUFFIXES: .cu
.cu.o:
	$(CXX) -o $*.o -c $*.cu $(CXXFLAGS) $(SOFLAGS) $(INCLUDES)
#
# $(PNGWRITERLIB):
# 	@cd pngwriter/src && $(MAKE) -f Makefile.gnu

clean:
	@/bin/rm -f *.o core

realclean: clean
	# @cd pngwriter/src && $(MAKE) clean
	# @rm -f $(PNGWRITERLIB)
	@rm -f $(TARGET)
	# @rm -f mandelbrot.png

# dependencies
#
mxv.o  : mxv.cu
# mandel.o: mandel.cu
# writepng.o: writepng.h writepng.cc
