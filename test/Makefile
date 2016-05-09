CC = h5pcc
#CC = mpicc

#AT_DIR is the path to H5Tuner directory
# setup ROOTs with env variables for example
#MXMLROOT=${AT_DIR}/opt/mxml-2.9
#HDF5ROOT=${AT_DIR}/opt/hdf5-1.8.16
#MPIROOT=/opt/mpich2
#H5PROOT=${AT_DIR}/opt/h5part-1.6.6
#ZROOT=${AT_DIR}/opt/zlib-1.2.8
#H5TUNEROOT=${AT_DIR}

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
	#$(CC) -g -c -o $@ $< $(CFLAGS) $(H5FLAGS) $(ADD_FLAGS)
	$(CC) -g -o $@ $< -I. -shlib

ph5example: ph5example.o
	#$(CC) $(CFLAGS) -o ph5example ph5example.o -I. $(LIB) $(H5LIB) $(ZLIB) $(MPILIB) $(ADD_FLAGS) --verbose
	#rm ph5example.o
	$(CC) -g -o ph5example ph5example.o -I. -shlib

test_indipendent_write_01: test_indipendent_write_01_threshold.o
	$(CC) -g -o test_indipendent_write_01_threshold test_indipendent_write_01_threshold.o -I. -shlib

test_indipendent_write_02: test_indipendent_write_02_alignment.o
	$(CC) -g -o test_indipendent_write_02_alignment test_indipendent_write_02_alignment.o -I. -shlib

test_indipendent_write_03: test_indipendent_write_03_sieve_buffer_size.o
	$(CC) -g -o test_indipendent_write_03_sieve_buffer_size test_indipendent_write_03_sieve_buffer_size.o -I. -shlib


ph5example_at: ph5example.o
	$(CC) -g -o ph5example_at ph5example.o -I. $(LIB) $(H5LIB) $(ZLIB) $(MPILIB) $(MXMLLIB) $(ADD_FLAGS) $(H5ATLIB) -Wl,-wrap,H5Fcreate -Wl,-wrap,H5Fopen --verbose
	#rm ph5example_at.o

clean_ph5example:
	rm  -f ph5example ph5example_at


clean:
	rm  -f test_indipendent_write_01_threshold test_indipendent_write_01_threshold.o
	rm  -f test_indipendent_write_02_alignment test_indipendent_write_02_alignment.o
	rm  -f test_indipendent_write_03_sieve_buffer_size test_indipendent_write_03_sieve_buffer_size.o
	rm  -f ph5example ph5example_at
	rm  -f ph5example.o ph5example_at.o
