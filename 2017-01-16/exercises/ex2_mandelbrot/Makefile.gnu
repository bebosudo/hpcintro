TARGET	= mandelbrot
OBJS	= main.o mandel.o writepng.o 

OPT	= -g -O3
ISA	= 
PARA	= 

PNGWRITERPATH = pngwriter
ARCH	      = $(shell uname -p)
PNGWRTLPATH   = $(PNGWRITERPATH)/lib/$(ARCH)
PNGWRTIPATH   = $(PNGWRITERPATH)/include
PNGWRITERLIB  = $(PNGWRTLPATH)/libpngwriter.a

CC	= gcc

CCC	= g++
CXX	= g++
CXXFLAGS= -I $(PNGWRTIPATH)

CFLAGS	= $(OPT) $(ISA) $(PARA) $(XOPT)

F90C  	= gfortran
LIBS	= -L $(PNGWRTLPATH) -lpngwriter -lpng 


all: $(PNGWRITERLIB) $(TARGET)

$(TARGET): $(OBJS) 
	$(CCC) $(CFLAGS) -o $@ $(OBJS) $(LIBS)

$(PNGWRITERLIB):
	@cd pngwriter/src && $(MAKE) -f $(MAKEFILE_LIST)

clean:
	@/bin/rm -f *.o core

realclean: clean
	@cd pngwriter/src && $(MAKE) -f $(MAKEFILE_LIST) clean
	@rm -f $(PNGWRITERLIB)
	@rm -f $(TARGET)
	@rm -f mandelbrot.png

# dependencies
#
main.o  : main.c mandel.h
mandel.o: mandel.c
writepng.o: writepng.h writepng.cc
