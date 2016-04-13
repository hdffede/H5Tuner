#!/bin/sh
# --force option rebuilds the configure script regardless of its timestamp in relation to that of the file configure.ac
# --install copies some missing files to the directory, including the text files COPYING and INSTALL
# -I config and -I m4 so that the tools find the files in subdirectories instead of in the project root.
autoreconf --force --install -I config -I m4
