CC = mpicc
#CC = h5pcc

all: lib/libautotuner_static.a lib/libautotuner.so

LIBBASE=/mnt/hdf/fede/AT/AT_march

MXMLroot=${LIBBASE}/opt/mxml-2.9
HDF5root=${LIBBASE}/opt/hdf5-1.8.12
MPIroot=/opt/mpich2

CFLAGS = -I . -I${MPIroot}/include -I${MXMLroot}/include -I${HDF5root}/include
CFLAGS_SHARED = -I . -I${MPIroot}/include -I${MXMLroot}/include -I${HDF5root}/include -g -shared -fpic -DPIC
LDFLAGS =
LDFLAGS_SHARED = -ldl

LIBS = -lpthread -lrt -lz
MXML_LIB = ${MXMLroot}/lib/libmxml.so
HDF5_LIB = -L${HDF5root}/lib -lhdf5

ADDFLAGS = -DDEBUG
ADDFLAGS_SHARED = -DDEBUG

lib/autotuner_hdf5_static.o: lib/autotuner_hdf5_static.c lib/autotuner.h
	$(CC) $(CFLAGS) -c $< -o $@  $(HDF5_LIB) $(ADDFLAGS)

lib/autotuner_hdf5.po: lib/autotuner_hdf5.c lib/autotuner.h
	$(CC) $(CFLAGS_SHARED) -c $< -o $@ $(ADDFLAGS_SHARED)

lib/libautotuner_static.a: lib/autotuner_hdf5_static.o
	ar rcs $@ $^
	rm lib/autotuner_hdf5_static.o

lib/libautotuner.so: lib/autotuner_hdf5.po
	$(CC) $(CFLAGS_SHARED) $(LDFAGS_SHARED) -o $@ $^ $(HDF5_LIB) $(LIBS) $(ADDFLAGS_SHARED) 
	rm lib/autotuner_hdf5.po

clean:
	rm -f *.o *.a lib/*.o lib/*.a
