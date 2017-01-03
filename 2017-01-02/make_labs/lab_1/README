Make and Makefiles - exercise 1
--------------------------------

a) Use the source files in this directory and craft a Makefile that
   satisfies the following dependency graph:

               + data.o --- +  data.c  
               |             \ 
               |              + data.h
               |             /
excer1.exe --- + main.o --- + main.c
               |             \ 
               |              + io.h
               |             /
               +  io.o  --- + io.c

Please do not use the built-in rules of make, yet, i.e. your Makefile
should also work with 'make -r'.

b) modify one of the source files and check if make does the right thing.
   Hint: use 'make -n'!

c) add a target 'clean', that removes all the object (.o) files, so you
   will be able to rebuild by doing a

    make clean
    make
