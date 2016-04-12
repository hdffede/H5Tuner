CC = h5pcc
#CC = mpicc

#AT_DIR is the path to H5Tuner direcorty (setup with env variable)
MXMLROOT=${AT_DIR}/opt/mxml-2.9
HDF5ROOT=${AT_DIR}/opt/hdf5-1.8.12
MPIROOT=/opt/mpich2
H5PROOT=${AT_DIR}/opt/h5part-1.6.6
ZROOT=${AT_DIR}/opt/zlib-1.2.8
H5TUNEROOT=${AT_DIR}

CFLAGS = -DUSE_V4_SSE -DOMPI_SKIP_MPICXX
H5PFLAGS = -I${MPIROOT}/include -I${HDF5ROOT}/include -I${H5PROOT}/include
H5FLAGS = -I${MPIROOT}/include -I${HDF5ROOT}/include

LIB = -L. -lm -ldl
H5PLIB = -L${HDF5ROOT}/lib -lhdf5 -L${H5PROOT}/lib -lH5Part
H5LIB = -L${HDF5ROOT}/lib -lhdf5
ZLIB = -L${ZROOT}/lib -lz
MPILIB = -L${MPIROOT}/lib -lmpich
MXMLLIB = -L${MXMLROOT}/lib -lmxml
H5ATLIB= -L${H5TUNEROOT}/lib -lautotuner_static

ADD_FLAGS = -DPARALLEL_IO

%.o: %.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS) $(H5FLAGS) $(ADD_FLAGS)

vpicio_uni: vpicio_uni.o
	$(CC) -o vpicio_uni vpicio_uni.o -I. $(LIB) $(H5PLIB) $(ZLIB) $(MPILIB) $(MXMLLIB) $(ADD_FLAGS)
	rm vpicio_uni.o

ph5example: ph5example.o
	#$(CC) $(CFLAGS) -o ph5example ph5example.o -I. $(LIB) $(H5LIB) $(ZLIB) $(MPILIB) $(ADD_FLAGS) --verbose
	#rm ph5example.o
	$(CC) -g -o ph5example ph5example.o -I. $(LIB) $(H5LIB) $(ZLIB) $(MPILIB) $(MXMLLIB) -shlib

AT: vpicio_uni.o
	$(CC) -o vpicio_uni_at vpicio_uni.o -I. $(LIB) $(H5PLIB) $(ZLIB) $(MPILIB) $(MXMLLIB) $(ADD_FLAGS) $(H5ATLIB) -Wl,-wrap,H5Fcreate -Wl,-wrap,H5Fopen
	rm vpicio_uni.o

ph5example_at: ph5example.o
	$(CC) -g -o ph5example_at ph5example.o -I. $(LIB) $(H5LIB) $(ZLIB) $(MPILIB) $(MXMLLIB) $(ADD_FLAGS) $(H5ATLIB) -Wl,-wrap,H5Fcreate -Wl,-wrap,H5Fopen --verbose
	#rm ph5example_at.o

clean_ph5example:
	rm  -f ph5example ph5example_at

clean_vpic:
	rm  -f vpicio_uni vpicio_uni_at

clean:
	rm  -f vpicio_uni vpicio_uni_at
	rm  -f ph5example ph5example_at
	rm  -f ph5example ph5example_at
	rm  -f ph5example.o ph5example_at.o
