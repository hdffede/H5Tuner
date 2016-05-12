## Makefile.am -- Process this file with automake to produce Makefile.in

# AT_DIR=/path/to/H5Tuner (set with an enviroment variable)
# #
# # MXMLROOT is set with the correpondent environment variable
# # for instance MXMLROOT=${AT_DIR}/opt/mxml-2.9

# Setting CC to /<path>/h5pcc may or may not cover HDF5ROOT and MPIROOT
# If CC is not set, will there be files in config to set a default compiler?

RUNEXEC=$(RUNPARALLEL)

# tells Autoconf to look for additional Autoconf macros in the m4 subdirectory
ACLOCAL_AMFLAGS=-I m4

SUBDIRS = src test examples lib

DIST_SUBDIRS = src test examples lib

# directive tells Automake to place the file autogen.sh in the distribution archive - file is shipped to our users
EXTRA_DIST = autogen.sh

MAINTAINERCLEANFILES = config.h config.log config.status

# Define rules for lib, progs, check, and tests.
# These simply involve recursing into subdirectories.
test _test: check

lib progs check-p check-s:
				for d in $(SUBDIRS); do																\
					if test $$d != .; then																				\
					 (cd $$d && $(MAKE) $(AM_MAKEFLAGS) $@) || exit 1;						\
					fi;																													 \
				done

# Make all, tests, and (un)install
tests:
				for d in $(SUBDIRS); do												\
					if test $$d != .; then																				\
					 (cd $$d && $(MAKE) $(AM_MAKEFLAGS) $@) || exit 1;						\
					fi;																													 \
					done

# Check-clean also recurses into examples directory
check-clean:
				for d in $(SUBDIRS) examples; do							 \
					if test $$d != .; then																				\
					 (cd $$d && $(MAKE) $(AM_MAKEFLAGS) $@) || exit 1;						\
					fi;																													 \
				done
				$(RM) -rf prefix-tmp destdir-tmp

# Some C++ compilers/linkers will create a directory named ii_files in
# the root directory, which should be cleaned.
mostlyclean-local:
				if test -d ii_files; then																			 \
					$(RM) -rf ii_files;																					 \
				fi

# 'make install' will now install examples, the same as 'make install-all'.
# 'make-install-all' will be redundant but will still work.
install: install-recursive install-examples
uninstall: uninstall-recursive uninstall-examples

# 'make install-all' also installs examples
install-all:
				@$(MAKE) $(AM_MAKEFLAGS) install
uninstall-all:
				@$(MAKE) $(AM_MAKEFLAGS) uninstall

# `make check-install' or `make installcheck' checks that examples can
#	be successfully built
installcheck-local:
				if test -n "${DESTDIR}"; then																	\
					(cd ${DESTDIR}$(bindir) && pwd && ./h5redeploy -force);		 \
				fi
				@(cd examples && $(MAKE) $(AM_MAKEFLAGS) $@) || exit 1;
