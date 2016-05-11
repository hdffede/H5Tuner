#
# Copyright by The HDF Group.
# All rights reserved.
#
#
lib_LTLIBRARIES=libautotuner.la
#
libautotuner_la_SOURCES = autotuner_hdf5_static.c autotuner_hdf5.c
libautotuner_la_LIBADD = @AM_MXML_LIB@

all: ../lib/libautotuner_static.a ../lib/libautotuner.so

../lib/autotuner_hdf5_static.o: autotuner_hdf5_static.c autotuner.h
				$(CC) $(CFLAGS) @AM_CFLAGS@ -c $< -o $@ @AM_HDF5_LIB@ $(HDF5_LIB) $(MXML_LIB) @AM_MXML_LIB@ @AM_ADDFLAGS@

../lib/autotuner_hdf5.po: autotuner_hdf5.c autotuner.h
				$(CC) $(CFLAGS_SHARED) @AM_CFLAGS_SHARED@	$(LDFLAGS_SHARED) @AM_LDFLAGS_SHARED@ -c $< -o $@ @AM_ADDFLAGS_SHARED@

../lib/libautotuner_static.a: ../lib/autotuner_hdf5_static.o
				ar rcs $@ $^
				rm ../lib/autotuner_hdf5_static.o

../lib/libautotuner.so: ../lib/autotuner_hdf5.po
				$(CC) $(CFLAGS_SHARED) @AM_CFLAGS_SHARED@ $(LDFLAGS_SHARED) @AM_LDFLAGS_SHARED@ -o $@ $^ $(HDF5_LIB) @AM_HDF5_LIB@ $(MXML_LIB) @AM_MXML_LIB@ $(LIBS) @AM_LIBS@ @AM_ADDFLAGS_SHARED@
				rm ../lib/autotuner_hdf5.po

clean:
				rm -f *.o *.a lib/*.o lib/*.a lib/*.so lib/*.po

include $(top_srcdir)/config/conclude.am
						   
