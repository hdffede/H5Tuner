## Makefile.am -- Process this file with automake to produce Makefile.in

# tells Autoconf to look for additional Autoconf macros in the m4 subdirectory
ACLOCAL_AMFLAGS=-I m4

SUBDIRS = \
        doc \
        src \
        test \
        examples \
        lib

# directive tells Automake to place the file autogen.sh in the distribution archive - file is shipped to our users
EXTRA_DIST = autogen.sh

MAINTAINERCLEANFILES = \
        config.h \
        config.log \
        config.status

MAINTAINERCLEANFILES    = Makefile.in

bin_PROGRAMS =
H5Tuner_SOURCES = autotuner_hdf5_static.c autotuner_hdf5.c
H5Tuner_LDADD = @MXMLLIB@
