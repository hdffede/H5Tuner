#
# Copyright by The HDF Group.
# All rights reserved.
#
#
#

TEST_PROG=test_collective_write_01_threshold \
	  test_collective_write_02_alignment \
	  test_collective_write_03_sieve_buffer_size \
	  test_collective_write_04_striping_factor \
	  test_collective_write_05_striping_unit \
	  test_collective_write_06_cb_buffer_size \
	  test_collective_write_07_cb_nodes \
          test_independent_write_01_threshold.c \
	  test_independent_write_02_alignment.c \
	  test_independent_write_03_sieve_buffer_size.c \
	  test_independent_write_04_striping_factor.c \
	  test_independent_write_05_striping_unit.c \
	  test_independent_write_06_cb_buffer_size.c \
	  test_independent_write_07_cb_nodes.c


check_PROGRAMS=$(TEST_PROG)

LDADD=@AM_HDF5_LIB@ @AM_MXML_LIB@ @AM_MPI_LIB@


include $(top_srcdir)/config/conclude.am
						   
