#
# AT_DIR=/path/to/H5Tuner (set with an enviroment variable)

# MXMLROOT is set with the correpondent environment variable
# for instance MXMLROOT=${AT_DIR}/opt/mxml-2.9
# HDF5ROOT is set with the correpondent environment variable
# HDF5ROOT=${AT_DIR}/opt/hdf5-1.8.12
# MPI set with environment variable MPIROOT
# for instance export MPIROOT=/opt/mpich2

# Detect OS from shell
OS := $(shell uname)

CC = mpicc

CFLAGS = -I . -I${MPIROOT}/include -I${MXMLROOT}/include -I${HDF5ROOT}/include
CFLAGS_SHARED = -I . -I${MPIROOT}/include -I${MXMLROOT}/include -I${HDF5ROOT}/include -shared -fpic -DPIC
LDFLAGS =
LDFLAGS_SHARED = -ldl

OS := $(shell uname)
ifeq $(OS) Darwin
  # On MacOS
  LIBS = -lpthread -lz
else
  # set for Linux
  LIBS = -lpthread -lrt -lz
endif

MXML_LIB = ${MXMLROOT}/lib/libmxml.so
HDF5_LIB = -L${HDF5ROOT}/lib -lhdf5

ADDFLAGS = -DDEBUG
ADDFLAGS_SHARED = -DDEBUG

all: lib/libautotuner_static.a lib/libautotuner.so

lib/autotuner_hdf5_static.o: src/autotuner_hdf5_static.c src/autotuner.h
	$(CC) $(CFLAGS) -c $< -o $@  $(HDF5_LIB) $(ADDFLAGS)

lib/autotuner_hdf5.po: src/autotuner_hdf5.c src/autotuner.h
	$(CC) $(CFLAGS_SHARED) -c $< -o $@ $(ADDFLAGS_SHARED)

lib/libautotuner_static.a: lib/autotuner_hdf5_static.o
	ar rcs $@ $^
	rm lib/autotuner_hdf5_static.o

lib/libautotuner.so: lib/autotuner_hdf5.po
	$(CC) $(CFLAGS_SHARED) $(LDFAGS_SHARED) -o $@ $^ $(HDF5_LIB) $(LIBS) $(ADDFLAGS_SHARED)
	rm lib/autotuner_hdf5.po

clean:
	rm -f *.o *.a lib/*.o lib/*.a lib/*.so lib/*.po
