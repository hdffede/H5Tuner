CC = mpicc

all: lib/libautotuner_static.a lib/libautotuner.so

MXMLroot=/opt/mxml-2.7
HDF5root=/opt/hdf5-1.8.9
MPIroot=/opt/mpich2-1.4.1p1

CFLAGS = -I . -I${MPIroot}/include -I${MXMLroot}/include -I${HDF5root}/include
CFLAGS_SHARED = -I . -I${MPIroot}/include -I${MXMLroot}/include -I${HDF5root}/include -g -shared -fpic -DPIC
LDFLAGS =

LIBS = -lz
MXML_LIB = ${MXMLroot}/lib/libmxml.so
HDF5_LIB = -L${HDF5root}/lib -lhdf5

ADDFLAGS = -DDEBUG
ADDFLAGS_SHARED = #-DDEBUG

lib/autotuner_hdf5_static.o: lib/autotuner_hdf5_static.c lib/autotuner.h
	$(CC) $(CFLAGS) -c $< -o $@  $(HDF5_LIB) $(ADDFLAGS)

lib/autotuner_hdf5.po: lib/autotuner_hdf5.c lib/autotuner.h
	$(CC) $(CFLAGS_SHARED) -c $< -o $@ $(ADDFLAGS_SHARED)

lib/libautotuner_static.a: lib/autotuner_hdf5_static.o
	ar rcs $@ $^
	rm lib/autotuner_hdf5_static.o

lib/libautotuner.so: lib/autotuner_hdf5.po
	$(CC) $(CFLAGS_SHARED) $(LDFAGS) $(ADDFLAGS_SHARED) $(HDF5_LIB) -ldl -o $@ $^ -lpthread -lrt -lz
	rm lib/autotuner_hdf5.po

clean:
	rm -f *.o *.a lib/*.o lib/*.a
