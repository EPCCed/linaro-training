# Makefile for the molecular dynamics code

#
# C compiler and options for Cray/clang 
#


CC=     cc -g -O0 -fopenmp -std=c99

LIB=    -lm

LDFLAGS=

# C compiler and options for GNU 
#
#CC=     cc -O3 -fopenmp
#LIB=	-lm



#
# Object files
#
OBJ=    main.o \
	dfill.o \
	domove.o \
        dscal.o \
	fcc.o \
	forces.o \
	mkekin.o \
	mxwell.o \
	prnout.o \
	velavg.o

#
# Compile
#
md:	$(OBJ)
	$(CC) $(LDFLAGS) -o $@ $(OBJ) $(LIB)

.c.o:
	$(CC) -c $<

#
# Clean out object files and the executable.
#
clean:
	rm -f *.o md *.yaml *.json.gz
