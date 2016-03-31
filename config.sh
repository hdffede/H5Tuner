Last login: Mon Mar 28 12:03:07 on ttys006
vireo:scratch fede$ cd ~
vireo:~ fede$ ls
AnaEnv		Downloads	H5Tuner		OneDriveHDF	SmartFolder
Applications	Dropbox		HDF5		Packages	TunerDemo
Codex		Google Drive	Library		Pictures	WinRDC
Desktop		H5Analyzer	Movies		Projects	dfym
Documents	H5Evolve	Music		Public		npm-debug.log
vireo:~ fede$ cd P
Packages/ Pictures/ Projects/ Public/
vireo:~ fede$ cd Packages/
vireo:Packages fede$ ls
Pyevolve-0.6rc1		Pyevolve-0.6rc1.tar.gz
vireo:Packages fede$ ls
Pyevolve-0.6rc1		Pyevolve-0.6rc1.tar.gz
vireo:Packages fede$ cd ..
vireo:~ fede$ ls
AnaEnv		Downloads	H5Tuner		OneDriveHDF	SmartFolder
Applications	Dropbox		HDF5		Packages	TunerDemo
Codex		Google Drive	Library		Pictures	WinRDC
Desktop		H5Analyzer	Movies		Projects	dfym
Documents	H5Evolve	Music		Public		npm-debug.log
vireo:~ fede$ cd TunerDemo/
vireo:TunerDemo fede$ ls
H5Part-1.6.6		hdf5-1.8.12.tar.gz	master.zip		zlib-1.2.8
H5Part-1.6.6.tar.gz	hdf5-1.8.16		mxml-2.9		zlib-1.2.8.tar.gz
H5Tuner-master		hdf5-1.8.16.tar.gz	mxml-2.9.tar.gz
hdf5-1.8.12		lib			opt
vireo:TunerDemo fede$ ls
H5Part-1.6.6		hdf5-1.8.12.tar.gz	master.zip		zlib-1.2.8
H5Part-1.6.6.tar.gz	hdf5-1.8.16		mxml-2.9		zlib-1.2.8.tar.gz
H5Tuner-master		hdf5-1.8.16.tar.gz	mxml-2.9.tar.gz
hdf5-1.8.12		lib			opt
vireo:TunerDemo fede$ mkdir TunerInstall
vireo:TunerDemo fede$ cd TunerInstall/
vireo:TunerInstall fede$ ls
vireo:TunerInstall fede$ pwd
/Users/fede/TunerDemo/TunerInstall
vireo:TunerInstall fede$ ls -l /Users/fede/TunerDemo/H5Part-1.6.6
total 3288
-rw-r--r--   1 fede  HDF\hdf   76502 Jul 25  2011 ABOUT-NLS
-rw-r--r--   1 fede  HDF\hdf     221 Sep 19  2011 AUTHORS
-rw-r--r--   1 fede  HDF\hdf    3811 Jul 25  2011 COPYING
-rw-r--r--   1 fede  HDF\hdf       0 Sep 19  2011 ChangeLog
-rw-r--r--   1 fede  HDF\hdf   11314 Jul 25  2011 INSTALL
-rw-r--r--   1 fede  HDF\hdf   20600 Feb 22 16:21 Makefile
-rw-r--r--   1 fede  HDF\hdf     157 Sep  3  2011 Makefile.am
-rw-r--r--   1 fede  HDF\hdf   20008 Nov  6  2011 Makefile.in
-rw-r--r--   1 fede  HDF\hdf   12070 Feb  5  2012 NEWS
-rw-r--r--   1 fede  HDF\hdf    1652 Sep 19  2011 README
-rw-r--r--   1 fede  HDF\hdf   31996 Nov  6  2011 aclocal.m4
-rwxr-xr-x   1 fede  HDF\hdf   46260 Sep  3  2011 config.guess
-rw-r--r--   1 fede  HDF\hdf    3023 Feb 22 09:31 config.h
-rw-r--r--   1 fede  HDF\hdf    2722 Nov  6  2011 config.h.in
-rw-r--r--   1 fede  HDF\hdf   37604 Feb 22 16:21 config.log
-rwxr-xr-x   1 fede  HDF\hdf   75419 Feb 22 16:21 config.status
-rwxr-xr-x   1 fede  HDF\hdf   33952 Sep  3  2011 config.sub
-rwxr-xr-x   1 fede  HDF\hdf  683776 Nov  6  2011 configure
-rw-r--r--   1 fede  HDF\hdf   10860 Nov  6  2011 configure.ac
-rw-r--r--   1 fede  HDF\hdf   15868 Jul 25  2011 depcomp
drwxr-xr-x   7 fede  HDF\hdf     238 Feb 22 16:21 doc
-rwxr-xr-x   1 fede  HDF\hdf    9233 Jul 25  2011 install-sh
-rwxr-xr-x   1 fede  HDF\hdf  278488 Feb 22 16:21 libtool
-rwxr-xr-x   1 fede  HDF\hdf  253189 Nov  3  2011 ltmain.sh
drwxr-xr-x   7 fede  HDF\hdf     238 Feb  5  2012 m4
-rw-r--r--   1 fede  HDF\hdf   10872 Jul 25  2011 missing
drwxr-xr-x  56 fede  HDF\hdf    1904 Feb 22 16:22 src
-rw-r--r--   1 fede  HDF\hdf      23 Feb 22 16:21 stamp-h1
drwxr-xr-x  19 fede  HDF\hdf     646 Feb 22 16:22 test
drwxr-xr-x  12 fede  HDF\hdf     408 Feb 22 16:21 tools
vireo:TunerInstall fede$ ls
vireo:TunerInstall fede$ vi config.sh
vireo:TunerInstall fede$ pwd
/Users/fede/TunerDemo/TunerInstall
vireo:TunerInstall fede$ ls -l config.sh
-rw-r--r--  1 fede  HDF\hdf  407 Mar 28 14:21 config.sh
vireo:TunerInstall fede$ chmod +x config.sh
vireo:TunerInstall fede$ ls
config.sh
vireo:TunerInstall fede$ ls -l
total 8
-rwxr-xr-x  1 fede  HDF\hdf  407 Mar 28 14:21 config.sh
vireo:TunerInstall fede$ ./config.sh
Installing Zlib
#####################################
--2016-03-28 14:22:21--  http://zlib.net/zlib-1.2.8.tar.gz
Resolving zlib.net... 69.73.132.10
Connecting to zlib.net|69.73.132.10|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 571091 (558K) [application/x-gzip]
Saving to: 'zlib-1.2.8.tar.gz'

zlib-1.2.8.tar.gz           100%[=========================================>] 557.71K  1.30MB/s    in 0.4s

2016-03-28 14:22:21 (1.30 MB/s) - 'zlib-1.2.8.tar.gz' saved [571091/571091]

x zlib-1.2.8/
x zlib-1.2.8/adler32.c
x zlib-1.2.8/amiga/
x zlib-1.2.8/amiga/Makefile.pup
x zlib-1.2.8/amiga/Makefile.sas
x zlib-1.2.8/as400/
x zlib-1.2.8/as400/bndsrc
x zlib-1.2.8/as400/compile.clp
x zlib-1.2.8/as400/readme.txt
x zlib-1.2.8/as400/zlib.inc
x zlib-1.2.8/ChangeLog
x zlib-1.2.8/CMakeLists.txt
x zlib-1.2.8/compress.c
x zlib-1.2.8/configure
x zlib-1.2.8/contrib/
x zlib-1.2.8/contrib/ada/
x zlib-1.2.8/contrib/ada/buffer_demo.adb
x zlib-1.2.8/contrib/ada/mtest.adb
x zlib-1.2.8/contrib/ada/read.adb
x zlib-1.2.8/contrib/ada/readme.txt
x zlib-1.2.8/contrib/ada/test.adb
x zlib-1.2.8/contrib/ada/zlib-streams.adb
x zlib-1.2.8/contrib/ada/zlib-streams.ads
x zlib-1.2.8/contrib/ada/zlib-thin.adb
x zlib-1.2.8/contrib/ada/zlib-thin.ads
x zlib-1.2.8/contrib/ada/zlib.adb
x zlib-1.2.8/contrib/ada/zlib.ads
x zlib-1.2.8/contrib/ada/zlib.gpr
x zlib-1.2.8/contrib/amd64/
x zlib-1.2.8/contrib/amd64/amd64-match.S
x zlib-1.2.8/contrib/asm686/
x zlib-1.2.8/contrib/asm686/match.S
x zlib-1.2.8/contrib/asm686/README.686
x zlib-1.2.8/contrib/blast/
x zlib-1.2.8/contrib/blast/blast.c
x zlib-1.2.8/contrib/blast/blast.h
x zlib-1.2.8/contrib/blast/Makefile
x zlib-1.2.8/contrib/blast/README
x zlib-1.2.8/contrib/blast/test.pk
x zlib-1.2.8/contrib/blast/test.txt
x zlib-1.2.8/contrib/delphi/
x zlib-1.2.8/contrib/delphi/readme.txt
x zlib-1.2.8/contrib/delphi/ZLib.pas
x zlib-1.2.8/contrib/delphi/ZLibConst.pas
x zlib-1.2.8/contrib/delphi/zlibd32.mak
x zlib-1.2.8/contrib/dotzlib/
x zlib-1.2.8/contrib/dotzlib/DotZLib/
x zlib-1.2.8/contrib/dotzlib/DotZLib/AssemblyInfo.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/ChecksumImpl.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/CircularBuffer.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/CodecBase.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/Deflater.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/DotZLib.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/DotZLib.csproj
x zlib-1.2.8/contrib/dotzlib/DotZLib/GZipStream.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/Inflater.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/UnitTests.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib.build
x zlib-1.2.8/contrib/dotzlib/DotZLib.chm
x zlib-1.2.8/contrib/dotzlib/DotZLib.sln
x zlib-1.2.8/contrib/dotzlib/LICENSE_1_0.txt
x zlib-1.2.8/contrib/dotzlib/readme.txt
x zlib-1.2.8/contrib/gcc_gvmat64/
x zlib-1.2.8/contrib/gcc_gvmat64/gvmat64.S
x zlib-1.2.8/contrib/infback9/
x zlib-1.2.8/contrib/infback9/infback9.c
x zlib-1.2.8/contrib/infback9/infback9.h
x zlib-1.2.8/contrib/infback9/inffix9.h
x zlib-1.2.8/contrib/infback9/inflate9.h
x zlib-1.2.8/contrib/infback9/inftree9.c
x zlib-1.2.8/contrib/infback9/inftree9.h
x zlib-1.2.8/contrib/infback9/README
x zlib-1.2.8/contrib/inflate86/
x zlib-1.2.8/contrib/inflate86/inffas86.c
x zlib-1.2.8/contrib/inflate86/inffast.S
x zlib-1.2.8/contrib/iostream/
x zlib-1.2.8/contrib/iostream/test.cpp
x zlib-1.2.8/contrib/iostream/zfstream.cpp
x zlib-1.2.8/contrib/iostream/zfstream.h
x zlib-1.2.8/contrib/iostream2/
x zlib-1.2.8/contrib/iostream2/zstream.h
x zlib-1.2.8/contrib/iostream2/zstream_test.cpp
x zlib-1.2.8/contrib/iostream3/
x zlib-1.2.8/contrib/iostream3/README
x zlib-1.2.8/contrib/iostream3/test.cc
x zlib-1.2.8/contrib/iostream3/TODO
x zlib-1.2.8/contrib/iostream3/zfstream.cc
x zlib-1.2.8/contrib/iostream3/zfstream.h
x zlib-1.2.8/contrib/masmx64/
x zlib-1.2.8/contrib/masmx64/bld_ml64.bat
x zlib-1.2.8/contrib/masmx64/gvmat64.asm
x zlib-1.2.8/contrib/masmx64/inffas8664.c
x zlib-1.2.8/contrib/masmx64/inffasx64.asm
x zlib-1.2.8/contrib/masmx64/readme.txt
x zlib-1.2.8/contrib/masmx86/
x zlib-1.2.8/contrib/masmx86/bld_ml32.bat
x zlib-1.2.8/contrib/masmx86/inffas32.asm
x zlib-1.2.8/contrib/masmx86/match686.asm
x zlib-1.2.8/contrib/masmx86/readme.txt
x zlib-1.2.8/contrib/minizip/
x zlib-1.2.8/contrib/minizip/configure.ac
x zlib-1.2.8/contrib/minizip/crypt.h
x zlib-1.2.8/contrib/minizip/ioapi.c
x zlib-1.2.8/contrib/minizip/ioapi.h
x zlib-1.2.8/contrib/minizip/iowin32.c
x zlib-1.2.8/contrib/minizip/iowin32.h
x zlib-1.2.8/contrib/minizip/make_vms.com
x zlib-1.2.8/contrib/minizip/Makefile
x zlib-1.2.8/contrib/minizip/Makefile.am
x zlib-1.2.8/contrib/minizip/miniunz.c
x zlib-1.2.8/contrib/minizip/miniunzip.1
x zlib-1.2.8/contrib/minizip/minizip.1
x zlib-1.2.8/contrib/minizip/minizip.c
x zlib-1.2.8/contrib/minizip/minizip.pc.in
x zlib-1.2.8/contrib/minizip/MiniZip64_Changes.txt
x zlib-1.2.8/contrib/minizip/MiniZip64_info.txt
x zlib-1.2.8/contrib/minizip/mztools.c
x zlib-1.2.8/contrib/minizip/mztools.h
x zlib-1.2.8/contrib/minizip/unzip.c
x zlib-1.2.8/contrib/minizip/unzip.h
x zlib-1.2.8/contrib/minizip/zip.c
x zlib-1.2.8/contrib/minizip/zip.h
x zlib-1.2.8/contrib/pascal/
x zlib-1.2.8/contrib/pascal/example.pas
x zlib-1.2.8/contrib/pascal/readme.txt
x zlib-1.2.8/contrib/pascal/zlibd32.mak
x zlib-1.2.8/contrib/pascal/zlibpas.pas
x zlib-1.2.8/contrib/puff/
x zlib-1.2.8/contrib/puff/Makefile
x zlib-1.2.8/contrib/puff/puff.c
x zlib-1.2.8/contrib/puff/puff.h
x zlib-1.2.8/contrib/puff/pufftest.c
x zlib-1.2.8/contrib/puff/README
x zlib-1.2.8/contrib/puff/zeros.raw
x zlib-1.2.8/contrib/README.contrib
x zlib-1.2.8/contrib/testzlib/
x zlib-1.2.8/contrib/testzlib/testzlib.c
x zlib-1.2.8/contrib/testzlib/testzlib.txt
x zlib-1.2.8/contrib/untgz/
x zlib-1.2.8/contrib/untgz/Makefile
x zlib-1.2.8/contrib/untgz/Makefile.msc
x zlib-1.2.8/contrib/untgz/untgz.c
x zlib-1.2.8/contrib/vstudio/
x zlib-1.2.8/contrib/vstudio/readme.txt
x zlib-1.2.8/contrib/vstudio/vc10/
x zlib-1.2.8/contrib/vstudio/vc10/miniunz.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/miniunz.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc10/minizip.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/minizip.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc10/testzlib.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/testzlib.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc10/testzlibdll.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/testzlibdll.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc10/zlib.rc
x zlib-1.2.8/contrib/vstudio/vc10/zlibstat.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/zlibstat.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc10/zlibvc.def
x zlib-1.2.8/contrib/vstudio/vc10/zlibvc.sln
x zlib-1.2.8/contrib/vstudio/vc10/zlibvc.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/zlibvc.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc11/
x zlib-1.2.8/contrib/vstudio/vc11/miniunz.vcxproj
x zlib-1.2.8/contrib/vstudio/vc11/minizip.vcxproj
x zlib-1.2.8/contrib/vstudio/vc11/testzlib.vcxproj
x zlib-1.2.8/contrib/vstudio/vc11/testzlibdll.vcxproj
x zlib-1.2.8/contrib/vstudio/vc11/zlib.rc
x zlib-1.2.8/contrib/vstudio/vc11/zlibstat.vcxproj
x zlib-1.2.8/contrib/vstudio/vc11/zlibvc.def
x zlib-1.2.8/contrib/vstudio/vc11/zlibvc.sln
x zlib-1.2.8/contrib/vstudio/vc11/zlibvc.vcxproj
x zlib-1.2.8/contrib/vstudio/vc9/
x zlib-1.2.8/contrib/vstudio/vc9/miniunz.vcproj
x zlib-1.2.8/contrib/vstudio/vc9/minizip.vcproj
x zlib-1.2.8/contrib/vstudio/vc9/testzlib.vcproj
x zlib-1.2.8/contrib/vstudio/vc9/testzlibdll.vcproj
x zlib-1.2.8/contrib/vstudio/vc9/zlib.rc
x zlib-1.2.8/contrib/vstudio/vc9/zlibstat.vcproj
x zlib-1.2.8/contrib/vstudio/vc9/zlibvc.def
x zlib-1.2.8/contrib/vstudio/vc9/zlibvc.sln
x zlib-1.2.8/contrib/vstudio/vc9/zlibvc.vcproj
x zlib-1.2.8/crc32.c
x zlib-1.2.8/crc32.h
x zlib-1.2.8/deflate.c
x zlib-1.2.8/deflate.h
x zlib-1.2.8/doc/
x zlib-1.2.8/doc/algorithm.txt
x zlib-1.2.8/doc/rfc1950.txt
x zlib-1.2.8/doc/rfc1951.txt
x zlib-1.2.8/doc/rfc1952.txt
x zlib-1.2.8/doc/txtvsbin.txt
x zlib-1.2.8/examples/
x zlib-1.2.8/examples/enough.c
x zlib-1.2.8/examples/fitblk.c
x zlib-1.2.8/examples/gun.c
x zlib-1.2.8/examples/gzappend.c
x zlib-1.2.8/examples/gzjoin.c
x zlib-1.2.8/examples/gzlog.c
x zlib-1.2.8/examples/gzlog.h
x zlib-1.2.8/examples/README.examples
x zlib-1.2.8/examples/zlib_how.html
x zlib-1.2.8/examples/zpipe.c
x zlib-1.2.8/examples/zran.c
x zlib-1.2.8/FAQ
x zlib-1.2.8/gzclose.c
x zlib-1.2.8/gzguts.h
x zlib-1.2.8/gzlib.c
x zlib-1.2.8/gzread.c
x zlib-1.2.8/gzwrite.c
x zlib-1.2.8/INDEX
x zlib-1.2.8/infback.c
x zlib-1.2.8/inffast.c
x zlib-1.2.8/inffast.h
x zlib-1.2.8/inffixed.h
x zlib-1.2.8/inflate.c
x zlib-1.2.8/inflate.h
x zlib-1.2.8/inftrees.c
x zlib-1.2.8/inftrees.h
x zlib-1.2.8/make_vms.com
x zlib-1.2.8/Makefile
x zlib-1.2.8/Makefile.in
x zlib-1.2.8/msdos/
x zlib-1.2.8/msdos/Makefile.bor
x zlib-1.2.8/msdos/Makefile.dj2
x zlib-1.2.8/msdos/Makefile.emx
x zlib-1.2.8/msdos/Makefile.msc
x zlib-1.2.8/msdos/Makefile.tc
x zlib-1.2.8/nintendods/
x zlib-1.2.8/nintendods/Makefile
x zlib-1.2.8/nintendods/README
x zlib-1.2.8/old/
x zlib-1.2.8/old/descrip.mms
x zlib-1.2.8/old/Makefile.emx
x zlib-1.2.8/old/Makefile.riscos
x zlib-1.2.8/old/os2/
x zlib-1.2.8/old/os2/Makefile.os2
x zlib-1.2.8/old/os2/zlib.def
x zlib-1.2.8/old/README
x zlib-1.2.8/old/visual-basic.txt
x zlib-1.2.8/qnx/
x zlib-1.2.8/qnx/package.qpg
x zlib-1.2.8/README
x zlib-1.2.8/test/
x zlib-1.2.8/test/example.c
x zlib-1.2.8/test/infcover.c
x zlib-1.2.8/test/minigzip.c
x zlib-1.2.8/treebuild.xml
x zlib-1.2.8/trees.c
x zlib-1.2.8/trees.h
x zlib-1.2.8/uncompr.c
x zlib-1.2.8/watcom/
x zlib-1.2.8/watcom/watcom_f.mak
x zlib-1.2.8/watcom/watcom_l.mak
x zlib-1.2.8/win32/
x zlib-1.2.8/win32/DLL_FAQ.txt
x zlib-1.2.8/win32/Makefile.bor
x zlib-1.2.8/win32/Makefile.gcc
x zlib-1.2.8/win32/Makefile.msc
x zlib-1.2.8/win32/README-WIN32.txt
x zlib-1.2.8/win32/VisualC.txt
x zlib-1.2.8/win32/zlib.def
x zlib-1.2.8/win32/zlib1.rc
x zlib-1.2.8/zconf.h
x zlib-1.2.8/zconf.h.cmakein
x zlib-1.2.8/zconf.h.in
x zlib-1.2.8/zlib.3
x zlib-1.2.8/zlib.3.pdf
x zlib-1.2.8/zlib.h
x zlib-1.2.8/zlib.map
x zlib-1.2.8/zlib.pc.cmakein
x zlib-1.2.8/zlib.pc.in
x zlib-1.2.8/zlib2ansi
x zlib-1.2.8/zutil.c
x zlib-1.2.8/zutil.h
Checking for gcc...
Checking for shared library support...
Building shared library libz.1.2.8.dylib with gcc.
Checking for off64_t... No.
Checking for fseeko... Yes.
Checking for strerror... Yes.
Checking for unistd.h... Yes.
Checking for stdarg.h... Yes.
Checking whether to use vs[n]printf() or s[n]printf()... using vs[n]printf().
Checking for vsnprintf() in stdio.h... Yes.
Checking for return value of vsnprintf()... Yes.
Checking for attribute(visibility) support... Yes.
gcc -O3  -DHAVE_HIDDEN -I. -c -o example.o test/example.c
gcc -O3  -DHAVE_HIDDEN   -c -o adler32.o adler32.c
gcc -O3  -DHAVE_HIDDEN   -c -o crc32.o crc32.c
gcc -O3  -DHAVE_HIDDEN   -c -o deflate.o deflate.c
gcc -O3  -DHAVE_HIDDEN   -c -o infback.o infback.c
gcc -O3  -DHAVE_HIDDEN   -c -o inffast.o inffast.c
gcc -O3  -DHAVE_HIDDEN   -c -o inflate.o inflate.c
inflate.c:1507:61: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
    if (strm == Z_NULL || strm->state == Z_NULL) return -1L << 16;
                                                        ~~~ ^
1 warning generated.
gcc -O3  -DHAVE_HIDDEN   -c -o inftrees.o inftrees.c
gcc -O3  -DHAVE_HIDDEN   -c -o trees.o trees.c
gcc -O3  -DHAVE_HIDDEN   -c -o zutil.o zutil.c
gcc -O3  -DHAVE_HIDDEN   -c -o compress.o compress.c
gcc -O3  -DHAVE_HIDDEN   -c -o uncompr.o uncompr.c
gcc -O3  -DHAVE_HIDDEN   -c -o gzclose.o gzclose.c
gcc -O3  -DHAVE_HIDDEN   -c -o gzlib.o gzlib.c
gcc -O3  -DHAVE_HIDDEN   -c -o gzread.o gzread.c
gcc -O3  -DHAVE_HIDDEN   -c -o gzwrite.o gzwrite.c
libtool -o libz.a adler32.o crc32.o deflate.o infback.o inffast.o inflate.o inftrees.o trees.o zutil.o compress.o uncompr.o gzclose.o gzlib.o gzread.o gzwrite.o
gcc -O3  -DHAVE_HIDDEN -o example example.o -L. libz.a
gcc -O3  -DHAVE_HIDDEN -I. -c -o minigzip.o test/minigzip.c
gcc -O3  -DHAVE_HIDDEN -o minigzip minigzip.o -L. libz.a
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/adler32.o adler32.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/crc32.o crc32.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/deflate.o deflate.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/infback.o infback.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/inffast.o inffast.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/inflate.o inflate.c
inflate.c:1507:61: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
    if (strm == Z_NULL || strm->state == Z_NULL) return -1L << 16;
                                                        ~~~ ^
1 warning generated.
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/inftrees.o inftrees.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/trees.o trees.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/zutil.o zutil.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/compress.o compress.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/uncompr.o uncompr.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/gzclose.o gzclose.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/gzlib.o gzlib.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/gzread.o gzread.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/gzwrite.o gzwrite.c
gcc -dynamiclib -install_name /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib/libz.1.dylib -compatibility_version 1 -current_version 1.2.8 -O3  -fPIC -DHAVE_HIDDEN -o libz.1.2.8.dylib adler32.lo crc32.lo deflate.lo infback.lo inffast.lo inflate.lo inftrees.lo trees.lo zutil.lo compress.lo uncompr.lo gzclose.lo gzlib.lo gzread.lo gzwrite.lo  -lc
rm -f libz.dylib libz.1.dylib
ln -s libz.1.2.8.dylib libz.dylib
ln -s libz.1.2.8.dylib libz.1.dylib
gcc -O3  -DHAVE_HIDDEN -o examplesh example.o -L. libz.1.2.8.dylib
gcc -O3  -DHAVE_HIDDEN -o minigzipsh minigzip.o -L. libz.1.2.8.dylib
cp libz.a /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib
chmod 644 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib/libz.a
cp libz.1.2.8.dylib /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib
chmod 755 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib/libz.1.2.8.dylib
cp zlib.3 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/share/man/man3
chmod 644 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/share/man/man3/zlib.3
cp zlib.pc /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib/pkgconfig
chmod 644 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib/pkgconfig/zlib.pc
cp zlib.h zconf.h /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/include
chmod 644 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/include/zlib.h /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/include/zconf.h
vireo:TunerInstall fede$ ls -l
total 1128
drwxr-xr-x    3 fede  HDF\hdf     102 Mar 28 14:22 AT
-rwxr-xr-x    1 fede  HDF\hdf     407 Mar 28 14:21 config.sh
drwxr-xr-x  100 fede  HDF\hdf    3400 Mar 28 14:22 zlib-1.2.8
-rw-r--r--    1 fede  HDF\hdf  571091 Apr 28  2013 zlib-1.2.8.tar.gz
vireo:TunerInstall fede$ ls -l AT/
total 0
drwxr-xr-x  3 fede  HDF\hdf  102 Mar 28 14:22 opt
vireo:TunerInstall fede$ ls -l AT/opt/
total 0
drwxr-xr-x  5 fede  HDF\hdf  170 Mar 28 14:22 zlib-1.2.8
vireo:TunerInstall fede$ ls
AT			config.sh		zlib-1.2.8		zlib-1.2.8.tar.gz
vireo:TunerInstall fede$ -l
-bash: -l: command not found
vireo:TunerInstall fede$ ls -l
total 1128
drwxr-xr-x    3 fede  HDF\hdf     102 Mar 28 14:22 AT
-rwxr-xr-x    1 fede  HDF\hdf     407 Mar 28 14:21 config.sh
drwxr-xr-x  100 fede  HDF\hdf    3400 Mar 28 14:22 zlib-1.2.8
-rw-r--r--    1 fede  HDF\hdf  571091 Apr 28  2013 zlib-1.2.8.tar.gz
vireo:TunerInstall fede$ ./config.sh
Installing Zlib
#####################################
--2016-03-28 14:26:29--  http://zlib.net/zlib-1.2.8.tar.gz
Resolving zlib.net... 69.73.132.10
Connecting to zlib.net|69.73.132.10|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 571091 (558K) [application/x-gzip]
Saving to: 'zlib-1.2.8.tar.gz.1'

zlib-1.2.8.tar.gz.1         100%[=========================================>] 557.71K  1.39MB/s    in 0.4s

2016-03-28 14:26:30 (1.39 MB/s) - 'zlib-1.2.8.tar.gz.1' saved [571091/571091]

x zlib-1.2.8/
x zlib-1.2.8/adler32.c
x zlib-1.2.8/amiga/
x zlib-1.2.8/amiga/Makefile.pup
x zlib-1.2.8/amiga/Makefile.sas
x zlib-1.2.8/as400/
x zlib-1.2.8/as400/bndsrc
x zlib-1.2.8/as400/compile.clp
x zlib-1.2.8/as400/readme.txt
x zlib-1.2.8/as400/zlib.inc
x zlib-1.2.8/ChangeLog
x zlib-1.2.8/CMakeLists.txt
x zlib-1.2.8/compress.c
x zlib-1.2.8/configure
x zlib-1.2.8/contrib/
x zlib-1.2.8/contrib/ada/
x zlib-1.2.8/contrib/ada/buffer_demo.adb
x zlib-1.2.8/contrib/ada/mtest.adb
x zlib-1.2.8/contrib/ada/read.adb
x zlib-1.2.8/contrib/ada/readme.txt
x zlib-1.2.8/contrib/ada/test.adb
x zlib-1.2.8/contrib/ada/zlib-streams.adb
x zlib-1.2.8/contrib/ada/zlib-streams.ads
x zlib-1.2.8/contrib/ada/zlib-thin.adb
x zlib-1.2.8/contrib/ada/zlib-thin.ads
x zlib-1.2.8/contrib/ada/zlib.adb
x zlib-1.2.8/contrib/ada/zlib.ads
x zlib-1.2.8/contrib/ada/zlib.gpr
x zlib-1.2.8/contrib/amd64/
x zlib-1.2.8/contrib/amd64/amd64-match.S
x zlib-1.2.8/contrib/asm686/
x zlib-1.2.8/contrib/asm686/match.S
x zlib-1.2.8/contrib/asm686/README.686
x zlib-1.2.8/contrib/blast/
x zlib-1.2.8/contrib/blast/blast.c
x zlib-1.2.8/contrib/blast/blast.h
x zlib-1.2.8/contrib/blast/Makefile
x zlib-1.2.8/contrib/blast/README
x zlib-1.2.8/contrib/blast/test.pk
x zlib-1.2.8/contrib/blast/test.txt
x zlib-1.2.8/contrib/delphi/
x zlib-1.2.8/contrib/delphi/readme.txt
x zlib-1.2.8/contrib/delphi/ZLib.pas
x zlib-1.2.8/contrib/delphi/ZLibConst.pas
x zlib-1.2.8/contrib/delphi/zlibd32.mak
x zlib-1.2.8/contrib/dotzlib/
x zlib-1.2.8/contrib/dotzlib/DotZLib/
x zlib-1.2.8/contrib/dotzlib/DotZLib/AssemblyInfo.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/ChecksumImpl.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/CircularBuffer.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/CodecBase.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/Deflater.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/DotZLib.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/DotZLib.csproj
x zlib-1.2.8/contrib/dotzlib/DotZLib/GZipStream.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/Inflater.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib/UnitTests.cs
x zlib-1.2.8/contrib/dotzlib/DotZLib.build
x zlib-1.2.8/contrib/dotzlib/DotZLib.chm
x zlib-1.2.8/contrib/dotzlib/DotZLib.sln
x zlib-1.2.8/contrib/dotzlib/LICENSE_1_0.txt
x zlib-1.2.8/contrib/dotzlib/readme.txt
x zlib-1.2.8/contrib/gcc_gvmat64/
x zlib-1.2.8/contrib/gcc_gvmat64/gvmat64.S
x zlib-1.2.8/contrib/infback9/
x zlib-1.2.8/contrib/infback9/infback9.c
x zlib-1.2.8/contrib/infback9/infback9.h
x zlib-1.2.8/contrib/infback9/inffix9.h
x zlib-1.2.8/contrib/infback9/inflate9.h
x zlib-1.2.8/contrib/infback9/inftree9.c
x zlib-1.2.8/contrib/infback9/inftree9.h
x zlib-1.2.8/contrib/infback9/README
x zlib-1.2.8/contrib/inflate86/
x zlib-1.2.8/contrib/inflate86/inffas86.c
x zlib-1.2.8/contrib/inflate86/inffast.S
x zlib-1.2.8/contrib/iostream/
x zlib-1.2.8/contrib/iostream/test.cpp
x zlib-1.2.8/contrib/iostream/zfstream.cpp
x zlib-1.2.8/contrib/iostream/zfstream.h
x zlib-1.2.8/contrib/iostream2/
x zlib-1.2.8/contrib/iostream2/zstream.h
x zlib-1.2.8/contrib/iostream2/zstream_test.cpp
x zlib-1.2.8/contrib/iostream3/
x zlib-1.2.8/contrib/iostream3/README
x zlib-1.2.8/contrib/iostream3/test.cc
x zlib-1.2.8/contrib/iostream3/TODO
x zlib-1.2.8/contrib/iostream3/zfstream.cc
x zlib-1.2.8/contrib/iostream3/zfstream.h
x zlib-1.2.8/contrib/masmx64/
x zlib-1.2.8/contrib/masmx64/bld_ml64.bat
x zlib-1.2.8/contrib/masmx64/gvmat64.asm
x zlib-1.2.8/contrib/masmx64/inffas8664.c
x zlib-1.2.8/contrib/masmx64/inffasx64.asm
x zlib-1.2.8/contrib/masmx64/readme.txt
x zlib-1.2.8/contrib/masmx86/
x zlib-1.2.8/contrib/masmx86/bld_ml32.bat
x zlib-1.2.8/contrib/masmx86/inffas32.asm
x zlib-1.2.8/contrib/masmx86/match686.asm
x zlib-1.2.8/contrib/masmx86/readme.txt
x zlib-1.2.8/contrib/minizip/
x zlib-1.2.8/contrib/minizip/configure.ac
x zlib-1.2.8/contrib/minizip/crypt.h
x zlib-1.2.8/contrib/minizip/ioapi.c
x zlib-1.2.8/contrib/minizip/ioapi.h
x zlib-1.2.8/contrib/minizip/iowin32.c
x zlib-1.2.8/contrib/minizip/iowin32.h
x zlib-1.2.8/contrib/minizip/make_vms.com
x zlib-1.2.8/contrib/minizip/Makefile
x zlib-1.2.8/contrib/minizip/Makefile.am
x zlib-1.2.8/contrib/minizip/miniunz.c
x zlib-1.2.8/contrib/minizip/miniunzip.1
x zlib-1.2.8/contrib/minizip/minizip.1
x zlib-1.2.8/contrib/minizip/minizip.c
x zlib-1.2.8/contrib/minizip/minizip.pc.in
x zlib-1.2.8/contrib/minizip/MiniZip64_Changes.txt
x zlib-1.2.8/contrib/minizip/MiniZip64_info.txt
x zlib-1.2.8/contrib/minizip/mztools.c
x zlib-1.2.8/contrib/minizip/mztools.h
x zlib-1.2.8/contrib/minizip/unzip.c
x zlib-1.2.8/contrib/minizip/unzip.h
x zlib-1.2.8/contrib/minizip/zip.c
x zlib-1.2.8/contrib/minizip/zip.h
x zlib-1.2.8/contrib/pascal/
x zlib-1.2.8/contrib/pascal/example.pas
x zlib-1.2.8/contrib/pascal/readme.txt
x zlib-1.2.8/contrib/pascal/zlibd32.mak
x zlib-1.2.8/contrib/pascal/zlibpas.pas
x zlib-1.2.8/contrib/puff/
x zlib-1.2.8/contrib/puff/Makefile
x zlib-1.2.8/contrib/puff/puff.c
x zlib-1.2.8/contrib/puff/puff.h
x zlib-1.2.8/contrib/puff/pufftest.c
x zlib-1.2.8/contrib/puff/README
x zlib-1.2.8/contrib/puff/zeros.raw
x zlib-1.2.8/contrib/README.contrib
x zlib-1.2.8/contrib/testzlib/
x zlib-1.2.8/contrib/testzlib/testzlib.c
x zlib-1.2.8/contrib/testzlib/testzlib.txt
x zlib-1.2.8/contrib/untgz/
x zlib-1.2.8/contrib/untgz/Makefile
x zlib-1.2.8/contrib/untgz/Makefile.msc
x zlib-1.2.8/contrib/untgz/untgz.c
x zlib-1.2.8/contrib/vstudio/
x zlib-1.2.8/contrib/vstudio/readme.txt
x zlib-1.2.8/contrib/vstudio/vc10/
x zlib-1.2.8/contrib/vstudio/vc10/miniunz.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/miniunz.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc10/minizip.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/minizip.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc10/testzlib.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/testzlib.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc10/testzlibdll.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/testzlibdll.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc10/zlib.rc
x zlib-1.2.8/contrib/vstudio/vc10/zlibstat.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/zlibstat.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc10/zlibvc.def
x zlib-1.2.8/contrib/vstudio/vc10/zlibvc.sln
x zlib-1.2.8/contrib/vstudio/vc10/zlibvc.vcxproj
x zlib-1.2.8/contrib/vstudio/vc10/zlibvc.vcxproj.filters
x zlib-1.2.8/contrib/vstudio/vc11/
x zlib-1.2.8/contrib/vstudio/vc11/miniunz.vcxproj
x zlib-1.2.8/contrib/vstudio/vc11/minizip.vcxproj
x zlib-1.2.8/contrib/vstudio/vc11/testzlib.vcxproj
x zlib-1.2.8/contrib/vstudio/vc11/testzlibdll.vcxproj
x zlib-1.2.8/contrib/vstudio/vc11/zlib.rc
x zlib-1.2.8/contrib/vstudio/vc11/zlibstat.vcxproj
x zlib-1.2.8/contrib/vstudio/vc11/zlibvc.def
x zlib-1.2.8/contrib/vstudio/vc11/zlibvc.sln
x zlib-1.2.8/contrib/vstudio/vc11/zlibvc.vcxproj
x zlib-1.2.8/contrib/vstudio/vc9/
x zlib-1.2.8/contrib/vstudio/vc9/miniunz.vcproj
x zlib-1.2.8/contrib/vstudio/vc9/minizip.vcproj
x zlib-1.2.8/contrib/vstudio/vc9/testzlib.vcproj
x zlib-1.2.8/contrib/vstudio/vc9/testzlibdll.vcproj
x zlib-1.2.8/contrib/vstudio/vc9/zlib.rc
x zlib-1.2.8/contrib/vstudio/vc9/zlibstat.vcproj
x zlib-1.2.8/contrib/vstudio/vc9/zlibvc.def
x zlib-1.2.8/contrib/vstudio/vc9/zlibvc.sln
x zlib-1.2.8/contrib/vstudio/vc9/zlibvc.vcproj
x zlib-1.2.8/crc32.c
x zlib-1.2.8/crc32.h
x zlib-1.2.8/deflate.c
x zlib-1.2.8/deflate.h
x zlib-1.2.8/doc/
x zlib-1.2.8/doc/algorithm.txt
x zlib-1.2.8/doc/rfc1950.txt
x zlib-1.2.8/doc/rfc1951.txt
x zlib-1.2.8/doc/rfc1952.txt
x zlib-1.2.8/doc/txtvsbin.txt
x zlib-1.2.8/examples/
x zlib-1.2.8/examples/enough.c
x zlib-1.2.8/examples/fitblk.c
x zlib-1.2.8/examples/gun.c
x zlib-1.2.8/examples/gzappend.c
x zlib-1.2.8/examples/gzjoin.c
x zlib-1.2.8/examples/gzlog.c
x zlib-1.2.8/examples/gzlog.h
x zlib-1.2.8/examples/README.examples
x zlib-1.2.8/examples/zlib_how.html
x zlib-1.2.8/examples/zpipe.c
x zlib-1.2.8/examples/zran.c
x zlib-1.2.8/FAQ
x zlib-1.2.8/gzclose.c
x zlib-1.2.8/gzguts.h
x zlib-1.2.8/gzlib.c
x zlib-1.2.8/gzread.c
x zlib-1.2.8/gzwrite.c
x zlib-1.2.8/INDEX
x zlib-1.2.8/infback.c
x zlib-1.2.8/inffast.c
x zlib-1.2.8/inffast.h
x zlib-1.2.8/inffixed.h
x zlib-1.2.8/inflate.c
x zlib-1.2.8/inflate.h
x zlib-1.2.8/inftrees.c
x zlib-1.2.8/inftrees.h
x zlib-1.2.8/make_vms.com
x zlib-1.2.8/Makefile
x zlib-1.2.8/Makefile.in
x zlib-1.2.8/msdos/
x zlib-1.2.8/msdos/Makefile.bor
x zlib-1.2.8/msdos/Makefile.dj2
x zlib-1.2.8/msdos/Makefile.emx
x zlib-1.2.8/msdos/Makefile.msc
x zlib-1.2.8/msdos/Makefile.tc
x zlib-1.2.8/nintendods/
x zlib-1.2.8/nintendods/Makefile
x zlib-1.2.8/nintendods/README
x zlib-1.2.8/old/
x zlib-1.2.8/old/descrip.mms
x zlib-1.2.8/old/Makefile.emx
x zlib-1.2.8/old/Makefile.riscos
x zlib-1.2.8/old/os2/
x zlib-1.2.8/old/os2/Makefile.os2
x zlib-1.2.8/old/os2/zlib.def
x zlib-1.2.8/old/README
x zlib-1.2.8/old/visual-basic.txt
x zlib-1.2.8/qnx/
x zlib-1.2.8/qnx/package.qpg
x zlib-1.2.8/README
x zlib-1.2.8/test/
x zlib-1.2.8/test/example.c
x zlib-1.2.8/test/infcover.c
x zlib-1.2.8/test/minigzip.c
x zlib-1.2.8/treebuild.xml
x zlib-1.2.8/trees.c
x zlib-1.2.8/trees.h
x zlib-1.2.8/uncompr.c
x zlib-1.2.8/watcom/
x zlib-1.2.8/watcom/watcom_f.mak
x zlib-1.2.8/watcom/watcom_l.mak
x zlib-1.2.8/win32/
x zlib-1.2.8/win32/DLL_FAQ.txt
x zlib-1.2.8/win32/Makefile.bor
x zlib-1.2.8/win32/Makefile.gcc
x zlib-1.2.8/win32/Makefile.msc
x zlib-1.2.8/win32/README-WIN32.txt
x zlib-1.2.8/win32/VisualC.txt
x zlib-1.2.8/win32/zlib.def
x zlib-1.2.8/win32/zlib1.rc
x zlib-1.2.8/zconf.h
x zlib-1.2.8/zconf.h.cmakein
x zlib-1.2.8/zconf.h.in
x zlib-1.2.8/zlib.3
x zlib-1.2.8/zlib.3.pdf
x zlib-1.2.8/zlib.h
x zlib-1.2.8/zlib.map
x zlib-1.2.8/zlib.pc.cmakein
x zlib-1.2.8/zlib.pc.in
x zlib-1.2.8/zlib2ansi
x zlib-1.2.8/zutil.c
x zlib-1.2.8/zutil.h
Checking for gcc...
Checking for shared library support...
Building shared library libz.1.2.8.dylib with gcc.
Checking for off64_t... No.
Checking for fseeko... Yes.
Checking for strerror... Yes.
Checking for unistd.h... Yes.
Checking for stdarg.h... Yes.
Checking whether to use vs[n]printf() or s[n]printf()... using vs[n]printf().
Checking for vsnprintf() in stdio.h... Yes.
Checking for return value of vsnprintf()... Yes.
Checking for attribute(visibility) support... Yes.
gcc -O3  -DHAVE_HIDDEN -I. -c -o example.o test/example.c
gcc -O3  -DHAVE_HIDDEN   -c -o adler32.o adler32.c
gcc -O3  -DHAVE_HIDDEN   -c -o crc32.o crc32.c
gcc -O3  -DHAVE_HIDDEN   -c -o deflate.o deflate.c
gcc -O3  -DHAVE_HIDDEN   -c -o infback.o infback.c
gcc -O3  -DHAVE_HIDDEN   -c -o inffast.o inffast.c
gcc -O3  -DHAVE_HIDDEN   -c -o inflate.o inflate.c
inflate.c:1507:61: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
    if (strm == Z_NULL || strm->state == Z_NULL) return -1L << 16;
                                                        ~~~ ^
1 warning generated.
gcc -O3  -DHAVE_HIDDEN   -c -o inftrees.o inftrees.c
gcc -O3  -DHAVE_HIDDEN   -c -o trees.o trees.c
gcc -O3  -DHAVE_HIDDEN   -c -o zutil.o zutil.c
gcc -O3  -DHAVE_HIDDEN   -c -o compress.o compress.c
gcc -O3  -DHAVE_HIDDEN   -c -o uncompr.o uncompr.c
gcc -O3  -DHAVE_HIDDEN   -c -o gzclose.o gzclose.c
gcc -O3  -DHAVE_HIDDEN   -c -o gzlib.o gzlib.c
gcc -O3  -DHAVE_HIDDEN   -c -o gzread.o gzread.c
gcc -O3  -DHAVE_HIDDEN   -c -o gzwrite.o gzwrite.c
libtool -o libz.a adler32.o crc32.o deflate.o infback.o inffast.o inflate.o inftrees.o trees.o zutil.o compress.o uncompr.o gzclose.o gzlib.o gzread.o gzwrite.o
gcc -O3  -DHAVE_HIDDEN -o example example.o -L. libz.a
gcc -O3  -DHAVE_HIDDEN -I. -c -o minigzip.o test/minigzip.c
gcc -O3  -DHAVE_HIDDEN -o minigzip minigzip.o -L. libz.a
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/adler32.o adler32.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/crc32.o crc32.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/deflate.o deflate.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/infback.o infback.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/inffast.o inffast.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/inflate.o inflate.c
inflate.c:1507:61: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
    if (strm == Z_NULL || strm->state == Z_NULL) return -1L << 16;
                                                        ~~~ ^
1 warning generated.
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/inftrees.o inftrees.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/trees.o trees.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/zutil.o zutil.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/compress.o compress.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/uncompr.o uncompr.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/gzclose.o gzclose.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/gzlib.o gzlib.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/gzread.o gzread.c
gcc -O3  -fPIC -DHAVE_HIDDEN -DPIC -c -o objs/gzwrite.o gzwrite.c
gcc -dynamiclib -install_name /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib/libz.1.dylib -compatibility_version 1 -current_version 1.2.8 -O3  -fPIC -DHAVE_HIDDEN -o libz.1.2.8.dylib adler32.lo crc32.lo deflate.lo infback.lo inffast.lo inflate.lo inftrees.lo trees.lo zutil.lo compress.lo uncompr.lo gzclose.lo gzlib.lo gzread.lo gzwrite.lo  -lc
rm -f libz.dylib libz.1.dylib
ln -s libz.1.2.8.dylib libz.dylib
ln -s libz.1.2.8.dylib libz.1.dylib
gcc -O3  -DHAVE_HIDDEN -o examplesh example.o -L. libz.1.2.8.dylib
gcc -O3  -DHAVE_HIDDEN -o minigzipsh minigzip.o -L. libz.1.2.8.dylib
cp libz.a /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib
chmod 644 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib/libz.a
cp libz.1.2.8.dylib /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib
chmod 755 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib/libz.1.2.8.dylib
cp zlib.3 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/share/man/man3
chmod 644 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/share/man/man3/zlib.3
cp zlib.pc /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib/pkgconfig
chmod 644 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/lib/pkgconfig/zlib.pc
cp zlib.h zconf.h /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/include
chmod 644 /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/include/zlib.h /Users/fede/TunerDemo/TunerInstall/AT/opt/zlib-1.2.8/include/zconf.h
vireo:TunerInstall fede$ ls -l AT/opt/
total 0
drwxr-xr-x  5 fede  HDF\hdf  170 Mar 28 14:22 zlib-1.2.8
vireo:TunerInstall fede$ ls -l AT/opt/zlib-1.2.8/
total 0
drwxr-xr-x  4 fede  HDF\hdf  136 Mar 28 14:22 include
drwxr-xr-x  7 fede  HDF\hdf  238 Mar 28 14:26 lib
drwxr-xr-x  3 fede  HDF\hdf  102 Mar 28 14:22 share
vireo:TunerInstall fede$ vi config.sh
vireo:TunerInstall fede$ vi config.sh

#!/bin/bash

# Destination path
#MPIROOT=$1
#[ $# -eq 0 ] && { echo "Using ${MPIROOT} with $0 AT_DESTINATION_DIR_PATH"; exit 1; }

# checking for mpich2 if no mpich2 notify and exit
# otherwise set MPICC path to   command -v mpicc >/dev/null 2>&1 || { echo >&2 "Could not find mpicc. Please set the mpich being used. Aborting.";}

# using mpich available on the system
MPICC=$(command -v mpicc)
echo "--"
echo "using mpicc:  ${MPICC} ";
echo "--"

exit 1;

# Assume AT_DESTDIR as path to AT directory
AT_PREFIX=${PWD}

if [ ! -d $AT_PREFIX/opt ]
then
        echo "--"
        echo "Creating ${AT_PREFIX}/opt and installing AT"
        echo "--"

        mkdir -p $AT_PREFIX/opt
fi


HDF5_V="hdf5-1.8.12"
ZLIB_V="zlib-1.2.8"
MXMLLIB_V="mxml-2.9"

HDF5DIR="${HDF5_V}"
ZLIBDIR="${ZLIB_V}"
MXMLLIBDIR="${MXMLLIB_V}"

if [ ! -d $MXMLLIBDIR ]
then
        echo "--";
        echo "Creating ${MXMLLIBDIR} and Building Mini-XML"
        echo "--";

        wget http://www.msweet.org/files/project3/$MXMLLIB_V.tar.gz
        tar xvzf $MXMLLIB_V.tar.gz
        cd $MXMLLIBDIR
            ./configure --prefix=${AT_PREFIX}/opt/${MXMLLIB_V} --enable-shared
            make && make install
        cd ..
        # Remove download file
        rm -f "${MXMLLIB_V}.tar.gz"
else
        echo "A directory " $MXMLLIBDIR " already exists.";
fi

if [ ! -d $ZLIBDIR ]
then
        echo "--";
        echo "Creating ${ZLIBDIR} and Building Zlib"
        echo "--";

        wget http://zlib.net/${ZLIB_V}.tar.gz
        tar xvzf ${ZLIB_V}.tar.gz
        cd ${ZLIBDIR}
            ./configure --prefix=${AT_PREFIX}/opt/${ZLIB_V}
             make && make install
"config.sh" 100L, 2579C written
  [Restored Mar 29, 2016, 2:16:54 PM]
Last login: Tue Mar 29 14:16:53 on ttys007
vireo:TunerInstall fede$ pwd
/Users/fede/TunerDemo/TunerInstall
vireo:TunerInstall fede$ ls -l
total 8
-rwxr-xr-x    1 fede  HDF\hdf  2579 Mar 29 12:07 config.sh
drwxr-xr-x   61 fede  HDF\hdf  2074 Mar 29 08:12 mxml-2.9
drwxr-xr-x    4 fede  HDF\hdf   136 Mar 29 08:12 opt
drwxr-xr-x  100 fede  HDF\hdf  3400 Mar 29 08:02 zlib-1.2.8
vireo:TunerInstall fede$ vi config.sh
vireo:TunerInstall fede$ vi config.sh
vireo:TunerInstall fede$ cp config.sh config1.sh
vireo:TunerInstall fede$ vi config.sh
vireo:TunerInstall fede$ vi config.sh
vireo:TunerInstall fede$ vi config.sh

#!/bin/bash

MPICC=$(command -v mpicc)
if [ ! -z $MPICC ]; then
     # using mpich available on the system
     echo "--"
     echo "using mpicc:  ${MPICC} ";
     echo "--"

# else is at bottom of the script

# Assume AT_DESTDIR as path to AT directory
AT_PREFIX=${PWD}

if [ ! -d $AT_PREFIX/opt ]
then
        echo "--"
        echo "Creating ${AT_PREFIX}/opt and building AT"
        echo "--"

        mkdir -p $AT_PREFIX/opt
fi

HDF5_V="hdf5-1.8.12"
ZLIB_V="zlib-1.2.8"
MXML_V="mxml-2.9"
NCDF4_V="v4.4.0"

HDF5DIR="${HDF5_V}"
ZLIBDIR="${ZLIB_V}"
MXMLDIR="${MXML_V}"
NCDF4DIR="netcdf-c-4.4.0"

if [ ! -d $MXMLDIR ]
then
        echo "--";
        echo "Creating ${MXMLDIR} and Building Mini-XML"
        echo "--";

        wget http://www.msweet.org/files/project3/$MXML_V.tar.gz
        tar xvzf $MXML_V.tar.gz
        cd $MXMLDIR
            ./configure --prefix=${AT_PREFIX}/opt/${MXML_V} --enable-shared
            make && make install
        cd ..
        # Remove download file
        rm -f "${MXML_V}.tar.gz"
else
        echo "A directory " $MXMLDIR " already exists.";
fi

if [ ! -d $ZLIBDIR ]
then
        echo "--";
        echo "Creating ${ZLIBDIR} and Building Zlib"
        echo "--";

        wget http://zlib.net/${ZLIB_V}.tar.gz
        tar xvzf ${ZLIB_V}.tar.gz
        cd ${ZLIBDIR}
            ./configure --prefix=${AT_PREFIX}/opt/${ZLIB_V}
             make && make install
        cd ..
        # Remove download file
        rm -f "${ZLIB_V}.tar.gz"
else
        echo "--";
        echo "A directory " $ZLIBDIR " already exists.";
        echo "--";
fi


if [ ! -d $HDF5DIR ]
then
        echo "--";
        echo "Creating ${HDF5DIR} and Building HDF5"
        echo "--";

        wget http://www.hdfgroup.org/ftp/HDF5/releases/${HDF5_V}/src/${HDF5_V}.tar.gz
        tar xvzf ${HDF5_V}.tar.gz

        cd ${HDF5DIR}
            if [ -z "$MPIROOT" ]; then
                CC=mpicc \
                ./configure --prefix=${AT_PREFIX}/opt/${HDF5_V}/ --enable-parallel  --enable-shared \
                --with-zlib=${AT_PREFIX}/opt/${ZLIB_V}
            else
                export PATH=/opt/mpich2/bin:$PATH
                export LD_LIBRARY_PATH=/opt/mpich2/lib:$LD_LIBRARY_PATH

            fi
            make && make install
        cd ..
        # Remove downloaded file
        rm -f "${HDF5_V}.tar.gz"
else
        echo "--";
        echo "A directory " $HDF5DIR " already exists.";
        echo "--";
fi

# Build NetCDF4 if AT_NCDF4 is defined
AT_NCDF4="BUILD"

if [ ! -d $NCDF4DIR ] && [ -z $AT_NCDF ]
then
        echo "--";
        echo "Creating ${NCDF4DIR} and Building NetCD4"
        echo "--";

        wget https://github.com/Unidata/netcdf-c/archive/${NCDF4_V}.tar.gz
        tar xvzf ${NCDF4_V}.tar.gz

        cd ${NCDF4DIR}
            export LD_LIBRARY_PATH="${AT_PREFIX}/opt/${HDF5_V}/lib":"$LD_LIBRARY_PATH"
            CC=mpicc \
            CPPFLAGS=-I${AT_PREFIX}/opt/${HDF5_V}/include \
            LDFLAGS=-L${AT_PREFIX}/opt/${HDF5_V}/lib \
            ./configure --enable-parallel-tests --disable-shared \
            --prefix=${AT_PREFIX}/opt/${NCDF4DIR}
            make && make install
        cd ..
        # Remove downloaded file
        rm -f "${NCDF4_V}.tar.gz"
else
        echo "--";
        echo "A directory " $NCDF4DIR " already exists.";
        echo "--";
fi

# checking for mpich -- continuing from the top of the script
else
   # no mpich notify and exit
   echo "Could not find mpicc. Please specify the mpich being used. Aborting.";
fi
