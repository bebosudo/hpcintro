CC = gcc
WARN = -Wall
OPT = -g -O3
CFLAGS = $(OPT) $(WARN)
OBJECTS = main.o data.o io.o
OUT = out_file

all: $(OBJECTS)
	$(CC) $(CFLAGS) -o $(OUT) $(OBJECTS)

clean: 
	@rm -f *.o $(OUT)


# dependencies
io.o: io.h io.c
data.o: data.h data.c
main.o: main.c data.h io.h
