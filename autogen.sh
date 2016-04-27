#!/bin/sh

#
# Copyright by The HDF Group.
# All rights reserved.
#
# This file is part of h5tuner. The full h5tuner copyright notice,
#  including terms governing use, modification, and redistribution, is 
# contained in the file COPYING, which can be found at the root of the 
# source code distribution tree.  If you do not have access to this file, 
# you may request a copy from help@hdfgroup.org.
#

# A script to reconfigure autotools for h5tuner.  This script is a 
# modification of the autogen.sh script found in HDF5, and differs 
# mainly in that it runs autoreconf instead of running aclocal,
# autoheader, automake and autoconf in order.  This may or may not change.
#
# IMPORTANT OS X NOTE
#
# If you are using OS X, you will probably not have the autotools
# installed, even if you have the Xcode command-line tools.
#
# The easiest way to fix this is to install everything via Homebrew:
#
#   http://brew.sh/
#
# After you install the base packages, install autoconf, automake,
# and libtool.
#
#   brew install autoconf
#   brew install automake
#   brew install libtool
#
# This only takes a few minutes. Note that libtool and libtoolize will
# be glibtool and glibtoolize so as not to conflict with Apple's non-gnu
# tools. This autogen.sh script handles this for you.
#
# END IMPORTANT OS X NOTE
#
# If you want to use a particular version of the autotools, the paths
# to each tool can be overridden using the following environment
# variables:
#
#   H5TUNER_ACLOCAL
#   H5TUNER_AUTOHEADER
#   H5TUNER_AUTOMAKE
#   H5TUNER_AUTOCONF
#   H5TUNER_LIBTOOL
#   H5TUNER_M4
#
# Note that aclocal will attempt to include libtool's share/aclocal
# directory.
#
# This script takes two potential options:
#
#
# -p
#
# When this is selected, the autotools versions are set to the paths
# and versions used by The HDF Group to produce the released versions
# of the library.
#
# NOTE: This is probably temporary. Once we update our dev machines
# to have recent versions of the autotools this option will probably
# be removed.
#
# -v
#
# This emits some extra information, mainly tool versions.

echo
echo "*****************************"
echo "* h5tuner autogen.sh script *"
echo "*****************************"
echo

# Default is not production
production=false

# Default is not verbose output
verbose=false

optspec=":hpv-"
while getopts "$optspec" optchar; do
    case "${optchar}" in
    h)
        echo "usage: $0 [OPTIONS]"
        echo
        echo "      -h      Print this help message."
        echo
        echo "      -p      Used by THG to use hard-codes autotools"
        echo "              paths on THG machines. Not for non-HDF-Group"
        echo "              users!"
        echo
        echo "      -v      Show more verbose output."
        echo
        echo "  NOTE: Each tool can be set via an environment variable."
        echo "        These are documented inside this autogen.sh script."
        echo
        exit 0
        ;;
    p)
        echo "Setting THG production mode..."
        echo
        production=true
        ;;
    v)
        echo "Setting verbosity: high"
        echo
        verbose=true
        ;;
    *)
        if [ "$OPTERR" != 1 ] || case $optspec in :*) ;; *) false; esac; then
            echo "ERROR: non-option argument: '-${OPTARG}'" >&2
            echo "Quitting"
            exit 1
        fi
        ;;
    esac
done

if [ "$production" = true ] ; then

    # Production mode
    #
    # Hard-code canonical HDF Group tool locations.

    # If paths to tools are not specified, assume they are
    # located in /usr/hdf/bin/AUTOTOOLS and set paths accordingly.
    if test -z ${H5TUNER_AUTOCONF}; then
        H5TUNER_AUTOCONF=/usr/hdf/bin/AUTOTOOLS/autoconf
    fi
    if test -z ${H5TUNER_AUTOMAKE}; then
        H5TUNER_AUTOMAKE=/usr/hdf/bin/AUTOTOOLS/automake
    fi
    if test -z ${H5TUNER_AUTOHEADER}; then
        H5TUNER_AUTOHEADER=/usr/hdf/bin/AUTOTOOLS/autoheader
    fi
    if test -z ${H5TUNER_ACLOCAL}; then
        H5TUNER_ACLOCAL=/usr/hdf/bin/AUTOTOOLS/aclocal
    fi
    if test -z ${H5TUNER_LIBTOOL}; then
        H5TUNER_LIBTOOL=/usr/hdf/bin/AUTOTOOLS/libtool
    fi
    if test -z ${H5TUNER_M4}; then
        H5TUNER_M4=/usr/hdf/bin/AUTOTOOLS/m4
    fi

else

    # Not in production mode
    #
    # If paths to autotools are not specified, use whatever the system
    # has installed as the default. We use 'which <tool>' to
    # show exactly what's being used.
    if test -z ${H5TUNER_AUTOCONF}; then
        H5TUNER_AUTOCONF=$(which autoconf)
    fi
    if test -z ${H5TUNER_AUTOMAKE}; then
        H5TUNER_AUTOMAKE=$(which automake)
    fi
    if test -z ${H5TUNER_AUTOHEADER}; then
        H5TUNER_AUTOHEADER=$(which autoheader)
    fi
    if test -z ${H5TUNER_ACLOCAL}; then
        H5TUNER_ACLOCAL=$(which aclocal)
    fi
    if test -z ${H5TUNER_LIBTOOL}; then
        case "`uname`" in
        Darwin*)
            # libtool on OS-X is non-gnu
            H5TUNER_LIBTOOL=$(which glibtool)
            ;;
        *)
            H5TUNER_LIBTOOL=$(which libtool)
            ;;
        esac
    fi
    if test -z ${H5TUNER_M4}; then
        H5TUNER_M4=$(which m4)
    fi

fi # production


# Make sure that these versions of the autotools are in the path
AUTOCONF_DIR=`dirname ${H5TUNER_AUTOCONF}`
LIBTOOL_DIR=`dirname ${H5TUNER_LIBTOOL}`
M4_DIR=`dirname ${H5TUNER_M4}`
PATH=${AUTOCONF_DIR}:${LIBTOOL_DIR}:${M4_DIR}:$PATH

# Make libtoolize match the specified libtool
case "`uname`" in
Darwin*)
    # On OS X, libtoolize could be named glibtoolize or
    # libtoolize. Try the former first, then fall back
    # to the latter if it's not found.
    H5TUNER_LIBTOOLIZE="${LIBTOOL_DIR}/glibtoolize"
    if [ ! -f $H5TUNER_LIBTOOLIZE ] ; then
        H5TUNER_LIBTOOLIZE="${LIBTOOL_DIR}/libtoolize"
    fi
    ;;
*)
    H5TUNER_LIBTOOLIZE="${LIBTOOL_DIR}/libtoolize"
    ;;
esac

# Some versions of libtoolize will suggest that we add ACLOCAL_AMFLAGS
# = '-I m4'. This is already done in commence.am, which is included
# in Makefile.am. You can ignore this suggestion.

# LIBTOOLIZE
libtoolize_cmd="${H5TUNER_LIBTOOLIZE} --copy --force"
echo ${libtoolize_cmd}
if [ "$verbose" = true ] ; then
    ${H5TUNER_LIBTOOLIZE} --version
fi
${libtoolize_cmd} || exit 1
echo
echo "NOTE: You can ignore the warning about adding -I m4."
echo "      We already do this in an included file."
echo

# --force option rebuilds the configure script regardless of its timestamp in relation to that of the file configure.ac
# --install copies some missing files to the directory, including the text files COPYING and INSTALL

autoreconf --force --install -I config -I m4
