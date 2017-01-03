F90C	= f90
F90FLAGS= -g -O3
OBJECTS	= f90main.o

f90project: $(OBJECTS)
	$(F90C) $(F90FLAGS) -o $@ $(OBJECTS)

clean:
	@/bin/rm -f *.o core
