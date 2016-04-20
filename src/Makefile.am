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
        $(CC) $(CFLAGS_SHARED) @AM_CFLAGS_SHARED@  $(LDFLAGS_SHARED) @AM_LDFLAGS_SHARED@ -c $< -o $@ @AM_ADDFLAGS_SHARED@

../lib/libautotuner_static.a: ../lib/autotuner_hdf5_static.o
        ar rcs $@ $^
        rm ../lib/autotuner_hdf5_static.o

../lib/libautotuner.so: ../lib/autotuner_hdf5.po
        $(CC) $(CFLAGS_SHARED) @AM_CFLAGS_SHARED@ $(LDFLAGS_SHARED) @AM_LDFLAGS_SHARED@ -o $@ $^ $(HDF5_LIB) @AM_HDF5_LIB@ $(MXML_LIB) @AM_MXML_LIB@ $(LIBS) @AM_LIBS@ @AM_ADDFLAGS_SHARED@
        rm ../lib/autotuner_hdf5.po

clean:
        rm -f *.o *.a lib/*.o lib/*.a lib/*.so lib/*.po

# Automake needs to be taught how to build lib, progs, and tests targets.
# These will be filled in automatically for the most part (e.g.,
# lib_LIBRARIES are built for lib target), but EXTRA_LIB, EXTRA_PROG, and
# EXTRA_TEST variables are supplied to allow the user to force targets to
# be built at certain times.
LIB = $(lib_LIBRARIES) $(lib_LTLIBRARIES) $(noinst_LIBRARIES)                 \
      $(noinst_LTLIBRARIES) $(check_LIBRARIES) $(check_LTLIBRARIES) $(EXTRA_LIB)
PROGS = $(bin_PROGRAMS) $(bin_SCRIPTS) $(noinst_PROGRAMS) $(noinst_SCRIPTS)   \
        $(EXTRA_PROG)
chk_TESTS = $(check_PROGRAMS) $(check_SCRIPTS) $(EXTRA_TEST)
TESTS = $(TEST_PROG) $(TEST_SCRIPT) $(EXTRA_TEST)

TEST_EXTENSIONS = .sh
SH_LOG_COMPILER = $(SHELL)
AM_SH_LOG_FLAGS =

# lib/progs/tests targets recurse into subdirectories. build-* targets
# build files in this directory.
build-lib: $(LIB)
build-progs: $(LIB) $(PROGS)
build-tests: $(LIB) $(PROGS) $(chk_TESTS)

# General rule for recursive building targets.
# BUILT_SOURCES contain targets that need to be built before anything else
# in the directory (e.g., for Fortran type detection)
lib progs tests check-s check-p :: $(BUILT_SOURCES)
        @$(MAKE) $(AM_MAKEFLAGS) build-$@ || exit 1;
        @for d in X $(SUBDIRS); do                                             \
            if test $$d != X && test $$d != .; then                           \
                (set -x; cd $$d && $(MAKE) $(AM_MAKEFLAGS) $@) || exit 1;     \
            fi;                                                               \
        done

# General rule for recursive cleaning targets.  Like the rule above,
# but doesn't require building BUILT_SOURCES.
check-clean ::
        @$(MAKE) $(AM_MAKEFLAGS) build-$@ || exit 1;
        @for d in X $(SUBDIRS); do                                             \
            if test $$d != X && test $$d != .; then                           \
                (set -x; cd $$d && $(MAKE) $(AM_MAKEFLAGS) $@) || exit 1;     \
            fi;                                                               \
        done
