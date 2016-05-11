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
	$(CC) -shlib -c -o $@ $< -I.

ph5example: ph5example.o
	#$(CC) $(CFLAGS) -o ph5example ph5example.o -I. $(LIB) $(H5LIB) $(ZLIB) $(MPILIB) $(ADD_FLAGS)
	#rm ph5example.o
	$(CC) -shlib -o ph5example ph5example.o -I.

# H5Tuner independent write tests
test_independent_write_01: test_independent_write_01_threshold.o
	$(CC) -shlib -o test_independent_write_01_threshold test_independent_write_01_threshold.o -I.

test_independent_write_02: test_independent_write_02_alignment.o
	$(CC) -shlib -o test_independent_write_02_alignment test_independent_write_02_alignment.o -I.

test_independent_write_03: test_independent_write_03_sieve_buffer_size.o
	$(CC) -shlib -o test_independent_write_03_sieve_buffer_size test_independent_write_03_sieve_buffer_size.o -I.

test_independent_write_04: test_independent_write_04_striping_factor.o
	$(CC) -shlib -o test_independent_write_04_striping_factor test_independent_write_04_striping_factor.o -I.

test_independent_write_05: test_independent_write_05_striping_unit.o
	$(CC) -shlib -o test_independent_write_05_striping_unit test_independent_write_05_striping_unit.o -I.

test_independent_write_06: test_independent_write_06_cb_buffer_size.o
	$(CC) -shlib -o test_independent_write_06_cb_buffer_size test_independent_write_06_cb_buffer_size.o -I.

test_independent_write_07: test_independent_write_07_cb_nodes.o
	$(CC) -shlib -o test_independent_write_07_cb_nodes test_independent_write_07_cb_nodes.o -I.


# H5Tuner collective write tests
test_collective_write_01_threshold: test_collective_write_01_threshold.o
	  $(CC) -shlib -o test_collective_write_01_threshold test_collective_write_01_threshold.o -I.

test_collective_write_02: test_collective_write_02_alignment.o
	  $(CC) -shlib -o test_collective_write_02_alignment test_collective_write_02_alignment.o -I.

test_collective_write_03: test_collective_write_03_sieve_buffer_size.o
	  $(CC) -shlib -o test_collective_write_03_sieve_buffer_size test_collective_write_03_sieve_buffer_size.o -I.

test_collective_write_04: test_collective_write_04_striping_factor.o
		$(CC) -shlib -o test_collective_write_04_striping_factor test_collective_write_04_striping_factor.o -I.

test_collective_write_05: test_collective_write_05_striping_unit.o
		$(CC) -shlib -o test_collective_write_05_striping_unit test_collective_write_05_striping_unit.o -I.

test_collective_write_06: test_collective_write_06_cb_buffer_size.o
		$(CC) -shlib -o test_collective_write_06_cb_buffer_size test_collective_write_06_cb_buffer_size.o -I.

test_collective_write_07: test_collective_write_07_cb_nodes.o
		$(CC) -shlib -o test_collective_write_07_cb_nodes test_collective_write_07_cb_nodes.o -I.

ph5example_at: ph5example.o
	$(CC) -g -o ph5example_at ph5example.o -I. $(LIB) $(H5LIB) $(ZLIB) $(MPILIB) $(MXMLLIB) $(ADD_FLAGS) $(H5ATLIB) -Wl,-wrap,H5Fcreate -Wl,-wrap,H5Fopen --verbose
	#rm ph5example_at.o

clean_ph5example:
	rm  -f ph5example ph5example_at

cleano:
	rm *.o

cleanx:
	rm  -f test_independent_write_01_threshold
	rm  -f test_independent_write_02_alignment
	rm  -f test_independent_write_03_sieve_buffer_size
	rm  -f test_independent_write_04_striping_factor
	rm  -f test_independent_write_05_striping_unit
	rm  -f test_independent_write_06_cb_buffer_size
	rm  -f test_independent_write_07_cb_nodes

	rm  -f test_collective_write_01_threshold
	rm  -f test_collective_write_02_alignment
	rm  -f test_collective_write_03_sieve_buffer_size
	rm  -f test_collective_write_04_striping_factor
	rm  -f test_collective_write_05_striping_unit
	rm  -f test_collective_write_06_cb_buffer_size
	rm  -f test_collective_write_07_cb_nodes

clean:
	rm  -f test_independent_write_01_threshold test_independent_write_01_threshold.o
	rm  -f test_independent_write_02_alignment test_independent_write_02_alignment.o
	rm  -f test_independent_write_03_sieve_buffer_size test_independent_write_03_sieve_buffer_size.o
	rm  -f test_independent_write_04_striping_factor test_independent_write_04_striping_factor.o
	rm  -f test_independent_write_05_striping_unit test_independent_write_05_striping_unit.o
	rm  -f test_independent_write_06_cb_buffer_size test_independent_write_06_cb_buffer_size.o
	rm  -f test_independent_write_07_cb_nodes test_independent_write_07_cb_nodes.o

	rm  -f test_collective_write_01_threshold test_collective_write_01_threshold.o
	rm  -f test_collective_write_02_alignment test_collective_write_02_alignment.o
	rm  -f test_collective_write_03_sieve_buffer_size test_collective_write_03_sieve_buffer_size.o
	rm  -f test_collective_write_04_striping_factor test_collective_write_04_striping_factor.o
	rm  -f test_collective_write_05_striping_unit test_collective_write_05_striping_unit.o
	rm  -f test_collective_write_06_cb_buffer_size test_collective_write_06_cb_buffer_size.o
	rm  -f test_collective_write_07_cb_nodes test_collective_write_07_cb_nodes.o

	rm  -f ph5example ph5example_at
	rm  -f ph5example.o ph5example_at.o
