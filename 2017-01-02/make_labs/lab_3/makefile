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
#io.o: io.h io.c
#io.o: io.h 
#data.o: data.h data.c
#main.o: main.c data.h io.h
# DO NOT DELETE

data.o: /usr/include/stdio.h /usr/include/features.h
data.o: /usr/include/stdc-predef.h /usr/include/sys/cdefs.h
data.o: /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h
data.o: /usr/include/bits/types.h /usr/include/bits/typesizes.h
data.o: /usr/include/libio.h /usr/include/_G_config.h /usr/include/wchar.h
data.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h data.h
io.o: /usr/include/stdio.h /usr/include/features.h /usr/include/stdc-predef.h
io.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
io.o: /usr/include/gnu/stubs.h /usr/include/bits/types.h
io.o: /usr/include/bits/typesizes.h /usr/include/libio.h
io.o: /usr/include/_G_config.h /usr/include/wchar.h
io.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h io.h
main.o: /usr/include/stdio.h /usr/include/features.h
main.o: /usr/include/stdc-predef.h /usr/include/sys/cdefs.h
main.o: /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h
main.o: /usr/include/bits/types.h /usr/include/bits/typesizes.h
main.o: /usr/include/libio.h /usr/include/_G_config.h /usr/include/wchar.h
main.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h
main.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
main.o: /usr/include/bits/waitstatus.h /usr/include/endian.h
main.o: /usr/include/bits/endian.h /usr/include/bits/byteswap.h
main.o: /usr/include/bits/byteswap-16.h /usr/include/sys/types.h
main.o: /usr/include/time.h /usr/include/sys/select.h
main.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
main.o: /usr/include/bits/time.h /usr/include/sys/sysmacros.h
main.o: /usr/include/bits/pthreadtypes.h /usr/include/alloca.h
main.o: /usr/include/bits/stdlib-float.h io.h data.h
