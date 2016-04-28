## Process this file with autoconf to produce a configure script.
##
## This file is part of h5tuner. The full h5tuner copyright notice,
##  including terms governing use, modification, and redistribution, is 
## contained in the file COPYING, which can be found at the root of the 
## source code distribution tree.  If you do not have access to this file, 
## you may request a copy from help@hdfgroup.org.
##
##
##
## Initialize configure.
##
AC_PREREQ(2.69)

## AC_INIT takes the name of the package, the version number, and an
## email address to report bugs. AC_CONFIG_SRCDIR takes a unique file
## as its argument.
##
## NOTE: Do not forget to change the version number here when we do a
## release!!!
##
AC_INIT(autotuner, 0.1.1, fede@hdfgroup.org)

AC_CONFIG_SRCDIR([src/autotuner_hdf5.c])
AC_CONFIG_HEADERS([src/autotuner.h])

AC_CONFIG_MACRO_DIR([m4])

LT_INIT([dlopen])

## AM_INIT_AUTOMAKE takes a list of options that should be applied to
## every Makefile.am when automake is run.
AM_INIT_AUTOMAKE
AM_SILENT_RULES([yes])

## AM_MAINTAINER_MODE turns off "rebuild rules" that contain dependencies
## for Makefiles, configure, src/H5config.h, etc. If AM_MAINTAINER_MODE
## is enabled, these files will be rebuilt if out of date. This is a
## problem because if users try to build on a machine with
## the wrong versions of autoconf and automake, these files will be
## rebuilt with the wrong versions and bad things can happen.
## Also, CVS doesn't preserve dependencies between timestamps, so
## Makefiles will often think rebuilding needs to occur when it doesn't.
##
## By default, it is enabled. Users can configure with
## --disable-maintainer-mode to prevent running the autotools.
AM_MAINTAINER_MODE([enable])

AC_PROG_CC

## H5_CFLAGS (and company) are used by HDF5 for flags not exported to h5cc.
## That's not necessary here, but using them will allow copying the config
## files from HDF5 without modification.
AC_SUBST([H5_CFLAGS])
AC_SUBST([H5_CPPFLAGS])
AC_SUBST([H5_LDFLAGS])

## AM_CFLAGS (and company) are for CFLAGS that should be used on h5tuner
AC_SUBST([AM_CFLAGS])
AC_SUBST([AM_CFLAGS_SHARED])
AC_SUBST([AM_LDFLAGS])
AC_SUBST([AM_LDFLAGS_SHARED])
AC_SUBST([AM_ADDFLAGS])
AC_SUBST([AM_ADDFLAGS_SHARED])
AC_SUBST([AM_LIBS])
AC_SUBST([AM_MXML_LIB])
AC_SUBST([AM_HDF5_LIB])

## Make sure flags are initialized.
AM_CFLAGS="${AM_CFLAGS}"
AM_CPPFLAGS="${AM_CPPFLAGS}"
AM_LDFLAGS="${AM_LDFLAGS}"
CFLAGS="${CFLAGS}"
CPPFLAGS="${CPPFLAGS}"
LDFLAGS="${LDFLAGS}"

## Configure may need to alter any of the *FLAGS variables in order for
## various checks to work correctly. Save the user's value here so it
## can be restored once all configure checks are complete.
saved_user_CFLAGS="$CFLAGS"
saved_user_FCFLAGS="$FCFLAGS"
saved_user_CPPFLAGS="$CPPFLAGS"


## Detect OS from shell
OS=`uname`

if test $OS = Darwin; then
  dnl On MacOS
  AM_LIBS="-lpthread -lz"
else
  dnl set for Linux
  AM_LIBS="-lpthread -lrt -lz"
fi

## ----------------------------------------------------------------------
## Dump all shell variables values.
##
AC_MSG_CHECKING([shell variables initial values])
set >&AS_MESSAGE_LOG_FD
AC_MSG_RESULT([done])

## set some flag values.  These may be moved to platform specific config 
## files later.
AM_CFLAGS="-I . -I${MPIROOT}/include -I${MXMLROOT}/include -I${HDF5ROOT}/include"
AM_CFLAGS_SHARED="-I . -I${MPIROOT}/include -I${MXMLROOT}/include -I${HDF5ROOT}/include -g -shared -fpic -DPIC"
AM_LDFLAGS=
AM_LDFLAGS_SHARED=-ldl

AM_MXML_LIB="-L${MXMLROOT}/lib/ -lmxml"
AM_HDF5_LIB="-L${HDF5ROOT}/lib -lhdf5"

AM_ADDFLAGS=-DDEBUG
AM_ADDFLAGS_SHARED=-DDEBUG



## ----------------------------------------------------------------------
## Some platforms have broken basename, and/or xargs programs. Check
## that it actually does what it's supposed to do. Catch this early
## since configure and scripts relies upon them heavily and there's
## no use continuing if it's broken.
##
AC_MSG_CHECKING([if basename works])
BASENAME_TEST="`basename /foo/bar/baz/qux/basename_works`"
if test $BASENAME_TEST != "basename_works"; then
  AC_MSG_ERROR([basename program doesn't work])
else
  AC_MSG_RESULT([yes])
fi

## xargs basename used in configure to get the CC_BASENAME value
AC_MSG_CHECKING([if xargs works])
XARGS_TEST="`echo /foo/bar/baz/qux/xargs_works | xargs basename`"
if test $XARGS_TEST != "xargs_works"; then
  AC_MSG_ERROR([xargs program doesn't work])
else
  AC_MSG_RESULT([yes])
fi

## ----------------------------------------------------------------------
## Check that the cache file was build on the same host as what we're
## running on now.
##
AC_CACHE_CHECK([for cached host], [hdf5_cv_host], [hdf5_cv_host="none"]);
if test $hdf5_cv_host = "none"; then
  hdf5_cv_host=$host
elif test $hdf5_cv_host != $host; then
  echo "The config.cache file was generated on $hdf5_cv_host but"
  echo "this is $host.  Please remove that file and try again."
  AC_MSG_ERROR([config.cache file is invalid])
fi

## ----------------------------------------------------------------------
## Source any special files that we need.  These files normally aren't
## present but can be used by the maintainers to fine tune things like
## turning on debug or profiling flags for the compiler.  The search order
## is:
##
##    CPU-VENDOR-OS
##    VENDOR-OS
##    CPU-OS
##    CPU-VENDOR
##    OS
##    VENDOR
##    CPU
##
## If the `OS' ends with a version number then remove it. For instance,
## `freebsd3.1' would become `freebsd'

case $host_os in
  aix*)
    host_os_novers=aix
    ;;
  freebsd*)
    host_os_novers=freebsd
    ;;
  solaris*)
    host_os_novers=solaris
    ;;
  *)
    host_os_novers=$host_os
    ;;
esac

host_config="none"
for f in $host_cpu-$host_vendor-$host_os \
         $host_cpu-$host_vendor-$host_os_novers \
         $host_vendor-$host_os \
         $host_vendor-$host_os_novers \
         $host_cpu-$host_os \
         $host_cpu-$host_os_novers \
         $host_cpu-$host_vendor \
         $host_os \
         $host_os_novers \
         $host_vendor \
         $host_cpu ; do
  AC_MSG_CHECKING([for config $f])
  if test -f "$srcdir/config/$f"; then
    host_config=$srcdir/config/$f
    AC_MSG_RESULT([found])
    break
  fi
  AC_MSG_RESULT([no])
done
if test "X$host_config" != "Xnone"; then
  CC_BASENAME="`echo $CC | cut -f1 -d' ' | xargs basename 2>/dev/null`"
  . $host_config
fi

## Source any special site-specific file
hname="`hostname`"
while test -n "$hname"; do
  file=$srcdir/config/site-specific/host-$hname
  AC_MSG_CHECKING([for config $file])
  if test -f "$file"; then
    . $file
    AC_MSG_RESULT([found])
    break
  fi
  AC_MSG_RESULT([no])
  hname_tmp=$hname
  hname="`echo $hname | cut -d. -f2-99`"
  test "$hname_tmp" = "$hname" && break
done

## ----------------------------------------------------------------------
## Determine build mode (debug, production, clean).
## This has to be done early since the build mode is referred to
## frequently.
##
AC_MSG_CHECKING([build mode])
AC_ARG_ENABLE([build-mode],
              [AS_HELP_STRING([--enable-build-mode=(debug|production|clean)],
                              [Sets the build mode. Debug turns on symbols, API
                               tracing, asserts, and debug optimization,
                               as well as several other minor configure options
                               that aid in debugging.
                               Production turns high optimizations on.
                               Clean turns nothing on and disables optimization
                               (i.e.: a 'clean slate' configuration).
                               All these settings can be overridden by using
                               specific configure flags.
                               [default=clean]
                               ])],
              [BUILD_MODE=$enableval])

## Set the default
## Depends on branch, set via script at branch creation time
if test "X-$BUILD_MODE" = X- ; then
    BUILD_MODE=clean
fi

## Allow this variable to be substituted in
## other files (src/libhdf5.settings.in, etc.)
AC_SUBST([BUILD_MODE])

case "X-$BUILD_MODE" in
  X-clean)
    AC_MSG_RESULT([clean])
    ;;
  X-debug)
    AC_DEFINE([DEBUG_BUILD], [1], [Define if this is a debug build.])
    H5_CFLAGS="$H5_CFLAGS $DEBUG_CFLAGS"
    H5_CPPFLAGS="$H5_CPPFLAGS $DEBUG_CPPFLAGS"
    AC_MSG_RESULT([debug])
    ;;
  X-production)
    H5_CFLAGS="$H5_CFLAGS $PROD_CFLAGS"
    H5_CPPFLAGS="$H5_CPPFLAGS $PROD_CPPFLAGS"
    AC_MSG_RESULT([production])
    ;;
  *)
    AC_MSG_ERROR([Unrecognized build mode: $BUILD_MODE. Use debug, production, or clean.])
esac

## ----------------------------------------------------------------------
## Some built-in configure checks can only see CFLAGS (not AM_CFLAGS), so
## we need to add this in so configure works as intended. We will need to
## reset this value at the end of configure, to preserve the user's settings.
CFLAGS="${AM_CFLAGS} ${CFLAGS}"
CPPFLAGS="${AM_CPPFLAGS} ${CPPFLAGS}"
LDFLAGS="${AM_LDFLAGS} ${LDFLAGS}"

## ----------------------------------------------------------------------
## Enable dependency tracking unless the configure options or a
## site-specific file told us not to.  This prevents configure from
## silently disabling dependencies for some compilers.
##
if test -z "${enable_dependency_tracking}"; then
  enable_dependency_tracking="yes"
fi

## ----------------------------------------------------------------------
## Check for programs.
##
AC_PROG_CC
CC_BASENAME="`echo $CC | cut -f1 -d' ' | xargs basename 2>/dev/null`"

## Need to add the AM_ and H5_ into CFLAGS/CPPFLAGS to make them visible
## for configure checks.
## Note: Both will be restored by the end of configure.
CPPFLAGS="$H5_CPPFLAGS $AM_CPPFLAGS $CPPFLAGS"
CFLAGS="$H5_CFLAGS $AM_CFLAGS $CFLAGS"

## Checkpoint the cache
AC_CACHE_SAVE

## ----------------------------------------------------------------------
## Check if the compiler should include symbols
##
AC_MSG_CHECKING([enable debugging symbols])
AC_ARG_ENABLE([symbols],
              [AS_HELP_STRING([--enable-symbols=(yes|no|<custom>)],
                              [Add debug symbols to the library (e.g.: build with -g).
                               This is independent of the build mode and optimization
                               level. The custom string allows special settings like
                               -ggdb, etc. to be used.
                               [default=yes if debug build, otherwise no]
                               ])],
              [SYMBOLS=$enableval])

## Set default
if test "X-$SYMBOLS" = X- ; then
  if test "X-$BUILD_MODE" = "X-debug" ; then
    SYMBOLS=yes
  else
    SYMBOLS=no
  fi
fi

## Allow this variable to be substituted in
## other files (src/libhdf5.settings.in, etc.)
AC_SUBST([SYMBOLS])

case "X-$SYMBOLS" in
  X-yes)
    H5_CFLAGS="$H5_CFLAGS $SYMBOLS_CFLAGS"
    AC_MSG_RESULT([yes])
    ;;
  X-no)
    H5_CFLAGS="$H5_CFLAGS $NO_SYMBOLS_CFLAGS"
    AC_MSG_RESULT([no])
    ;;
  *)
    H5_CFLAGS="$H5_CFLAGS $SYMBOLS"
    SYMBOLS="custom ($SYMBOLS)"
    AC_MSG_RESULT([$SYMBOLS])
    ;;
esac

## ----------------------------------------------------------------------
## Check if the assert macro should be enabled
##
AC_MSG_CHECKING([enable asserts])
AC_ARG_ENABLE([asserts],
              [AS_HELP_STRING([--enable-asserts],
                              [Determines whether NDEBUG is defined or not, which
                               controls assertions.
                               This is independent of the build mode and presence
                               of debugging symbols.
                               [default=yes if debug build, otherwise no]
                               ])],
              [ASSERTS=$enableval])

## Set default
if test "X-$ASSERTS" = X- ; then
  if test "X-$BUILD_MODE" = "X-debug" ; then
    ASSERTS=yes
  else
    ASSERTS=no
  fi
fi

## Allow this variable to be substituted in
## other files (src/libhdf5.settings.in, etc.)
AC_SUBST([ASSERTS])

case "X-$ASSERTS" in
  X-yes)
    H5_CPPFLAGS="$H5_CPPFLAGS -UNDEBUG"
    AC_MSG_RESULT([yes])
    ;;
  X-no)
    H5_CPPFLAGS="$H5_CPPFLAGS -DNDEBUG"
    AC_MSG_RESULT([no])
    ;;
  *)
    AC_MSG_ERROR([Unrecognized value: $ASSERTS])
    ;;
esac

## ----------------------------------------------------------------------
## Check if the compiler should use profiling flags/settings
##
AC_MSG_CHECKING([profiling])
AC_ARG_ENABLE([profiling],
              [AS_HELP_STRING([--enable-profiling=(yes|no|<custom>)],
                              [Enable profiling flags (e.g.: -pg).
                               This can be set independently from the build mode.
                               The custom setting can be used to pass alternative
                               profiling flags (e.g.: -P for using Prof with gcc).
                               [default=no]
                               ])],
              [PROFILING=$enableval])

## Default is no profiling
if test "X-$PROFILING" = X- ; then
    PROFILING=no
fi

## Allow this variable to be substituted in
## other files (src/libhdf5.settings.in, etc.)
AC_SUBST([PROFILING])

case "X-$PROFILING" in
  X-yes)
    H5_CFLAGS="$H5_CFLAGS $PROFILE_CFLAGS"
    AC_MSG_RESULT([yes])
    ;;
  X-no)
    AC_MSG_RESULT([no])
    ;;
  *)
    H5_CFLAGS="$H5_CFLAGS $PROFILING"
    PROFILING="custom ($PROFILING)"
    AC_MSG_RESULT([$PROFILING])
    ;;
esac

## ----------------------------------------------------------------------
## Check if the compiler should use a particular optimization setting
##
AC_MSG_CHECKING([optimization level])
AC_ARG_ENABLE([optimization],
              [AS_HELP_STRING([--enable-optimization=(high|debug|none|<custom>)],
                              [Enable optimization flags/settings (e.g.: -O3).
                               This can be set independently from the build mode.
                               Optimizations for a given compiler can be specified
                               at several levels: High, with aggressive optimizations
                               turned on; debug, with optimizations that are
                               unlikely to interfere with debugging or profiling;
                               and none, with no optimizations at all.
                               See the compiler-specific config/*-flags file for more
                               details.
                               Alternatively, optimization options can
                               be specified directly by specifying them as a
                               string value. These custom optimzation flags will
                               completely replace all other optimization flags.
                               [default depends on build mode: debug=debug,
                                production=high, clean=none]
                               ])],
              [OPTIMIZATION=$enableval])

## Set the default optimization level. This depends on the compiler mode.
if test "X-$OPTIMIZATION" = X- ; then
  case "X-$BUILD_MODE" in
  X-debug)
    OPTIMIZATION=debug
    ;;
  X-production)
    OPTIMIZATION=high
    ;;
  X-clean)
    OPTIMIZATION=none
    ;;
  esac
fi

## Allow this variable to be substituted in
## other files (src/libhdf5.settings.in, etc.)
AC_SUBST([OPTIMIZATION])

case "X-$OPTIMIZATION" in
  X-high)
    H5_CFLAGS="$H5_CFLAGS $HIGH_OPT_CFLAGS"
    AC_MSG_RESULT([high])
    ;;
  X-debug)
    H5_CFLAGS="$H5_CFLAGS $DEBUG_OPT_CFLAGS"
    AC_MSG_RESULT([debug])
    ;;
  X-none)
    H5_CFLAGS="$H5_CFLAGS $NO_OPT_CFLAGS"
    AC_MSG_RESULT([none])
    ;;
  *)
    H5_CFLAGS="$H5_CFLAGS $OPTIMIZATION"
    OPTIMIZATION="custom ($OPTIMIZATION)"
    AC_MSG_RESULT([$OPTIMIZATION])
    ;;
esac

## Check if they would like the function stack support compiled in
##
AC_MSG_CHECKING([whether function stack tracking is enabled])
AC_ARG_ENABLE([codestack],
              [AS_HELP_STRING([--enable-codestack],
                              [Enable the function stack tracing (for developer debugging).
                               [default=no]
                              ])],
              [CODESTACK=$enableval])

## Set the default level.
if test "X-$CODESTACK" = X- ; then
  CODESTACK=no
fi

## Allow this variable to be substituted in
## other files (src/libhdf5.settings.in, etc.)
AC_SUBST([CODESTACK])

case "X-$CODESTACK" in
  X-yes)
      AC_MSG_RESULT([yes])
      AC_DEFINE([HAVE_CODESTACK], [1],
                [Define if the function stack tracing code is to be compiled in])
    ;;
  X-no)
      AC_MSG_RESULT([no])
    ;;
  *)
      AC_MSG_ERROR([Unrecognized value: $CODESTACK])
    ;;
esac

## Checkpoint the cache
AC_CACHE_SAVE


## ----------------------------------------------------------------------
## Restore user's CFLAGS.
CFLAGS="$saved_user_CFLAGS"
CPPFLAGS="$saved_user_CPPFLAGS"
LDFLAGS="$saved_user_LDFLAGS"

AC_CONFIG_FILES([Makefile
                 src/Makefile])

AC_OUTPUT
