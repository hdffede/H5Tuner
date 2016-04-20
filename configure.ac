dnl Process this file with autoconf to produce a configure script.

AC_PREREQ(2.69)

AC_INIT(autotuner, 0.1.1, fede@hdfgroup.org)

AC_CONFIG_SRCDIR([src/autotuner_hdf5.c])
AC_CONFIG_HEADERS([src/autotuner.h])

AC_CONFIG_MACRO_DIRS([m4])

LT_INIT([dlopen])



AM_INIT_AUTOMAKE

AC_PROG_CC

AC_SUBST([AM_CFLAGS])
AC_SUBST([AM_CFLAGS_SHARED])
AC_SUBST([AM_LDFLAGS])
AC_SUBST([AM_LDFLAGS_SHARED])
AC_SUBST([AM_ADDFLAGS])
AC_SUBST([AM_ADDFLAGS_SHARED])
AC_SUBST([AM_LIBS])
AC_SUBST([AM_MXML_LIB])
AC_SUBST([AM_HDF5_LIB])


dnl Detect OS from shell
OS=`uname`

if test $OS = Darwin; then
  dnl On MacOS
  AM_LIBS="-lpthread -lz"
else
  dnl set for Linux
  AM_LIBS="-lpthread -lrt -lz"
fi

AM_CFLAGS="-I . -I${MPIROOT}/include -I${MXMLROOT}/include -I${HDF5ROOT}/include"
AM_CFLAGS_SHARED="-I . -I${MPIROOT}/include -I${MXMLROOT}/include -I${HDF5ROOT}/include -g -shared -fpic -DPIC"
AM_LDFLAGS=
AM_LDFLAGS_SHARED=-ldl

AM_MXML_LIB="-L${MXMLROOT}/lib/ -lmxml"
AM_HDF5_LIB="-L${HDF5ROOT}/lib -lhdf5"

AM_ADDFLAGS=-DDEBUG
AM_ADDFLAGS_SHARED=-DDEBUG

AC_CONFIG_FILES([Makefile
                 src/Makefile])

AC_OUTPUT
