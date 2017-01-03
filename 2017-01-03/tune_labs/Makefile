CC	= gcc
#OPT	= -g -fast
OPT     = -g -std=gnu99 -O3
CHIP	=
ISA	= 
DEFS	= -DDATA_ANALYSIS #-DNBYTES=8
LIBS	= -lm
CFLAGS  = $(OPT) $(CHIP) $(ISA) $(DEFS) $(XOPT)

SOURCES = init_data.c main.c distance.c distcheck.c xtime.c
OBJECTS	= init_data.o main.o distance.o distcheck.o xtime.o

all: 
	$(MAKE) $(MAKEFLAGS) clean
	$(MAKE) $(MAKEFLAGS) internal
	$(MAKE) $(MAKEFLAGS) clean
	$(MAKE) $(MAKEFLAGS) external

internal: DEFS += -DALL_IN_ONE

internal: clean $(OBJECTS)
	$(CC) -o $@ $(CFLAGS) $(OBJECTS) $(LIBS)

external: clean  $(OBJECTS)
	$(CC) -o $@ $(CFLAGS) $(OBJECTS) $(LIBS)

clean:
	@/bin/rm -f $(OBJECTS) core

realclean: clean
	@/bin/rm -f external internal

depend: $(SOURCES)
	makedepend -Y $(SOURCES) 2> /dev/null

# DO NOT DELETE

init_data.o: data.h init_data.h
main.o: data.h init_data.h distance.h distcheck.h xtime.h
distance.o: data.h distance.h
distcheck.o: data.h distcheck.h
