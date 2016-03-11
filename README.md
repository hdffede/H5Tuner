# H5Tuner
The goal of the H5Tuner component is to develop an autonomous parallel I/O parameter injector for scientific applications with minimal user involvement, allowing parameters to be altered without requiring source code modifications and a recompilation of the application. 

The H5Tuner dynamic library is able to set the parameters of different levels of the I/O stack: HDF5, MPI-IO, and parallel file system (which vary based on the HPC system). H5Tuner assumes all the I/O optimization parameters for different levels of the stack are in a configuration file, which are being read first. 

When the HDF5 calls appear in the code during the execution of a benchmark or application, the H5Tuner library intercepts the HDF5 initialization function calls via dynamic linking. The library reroutes the intercepted HDF5 calls to a new library, where the parameters from the configuration are set and then the original HDF5 function is called using the dynamic library package functions. 

This approach has the added benefit of being completely transparent to the user; the function calls remain exactly the same and all alterations are made without change to the source code. We show an example where H5Tuner intercepts an H5FCreate() function call that creates an HDF5 file, applies various I/O parameters, and calls the original H5FCreate() function call. 

