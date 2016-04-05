#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libgen.h>
#include <pwd.h>
#include "mpi.h"
#include "hdf5.h"
#include "autotuner.h"
#include "mxml.h"

/*
typedef int hid_t;
typedef int herr_t;
*/

#define __USE_GNU
#include <dlfcn.h>
#include <stdlib.h>

#define FORWARD_DECL(name, ret, args) \
    ret (*__fake_ ## name)args = NULL;

#define DECL(__name) __name

#define MAP_OR_FAIL(func) \
	if(!(__fake_ ## func)) \
	{ \
		__fake_ ## func = dlsym(RTLD_NEXT, #func); \
		if(!(__fake_ ## func)) { \
			fprintf(stderr, "LibAutoTuner failed to map symbol: %s\n", #func); \
			exit(1); \
		} \
	}

void set_gpfs_parameter(mxml_node_t *tree, char *parameter_name, char *filename)
{
	char *node_file_name;
	mxml_node_t *node;


	for(node = mxmlFindElement(tree, tree, parameter_name, NULL, NULL,MXML_DESCEND); node != NULL; node = mxmlFindElement(node, tree, parameter_name, NULL, NULL,MXML_DESCEND)) {
		node_file_name = mxmlElementGetAttr(node, "FileName");
		#ifdef DEBUG
		//printf("Node_file_name: %s\n", node_file_name);
		#endif
		// TODO: Change this strstr() function call with a use of basename!
		if((node_file_name == NULL) || (strstr(filename, node_file_name) != NULL))  {
			if(strcmp(parameter_name, "IBM_lockless_io") == 0) {
			    if(strcmp(node->child->value.text.string, "true") == 0) {
				// I have to prefix the filename with "bglockless:".
				char* new_filename = (char *) malloc(sizeof(char) * 1024);
				strcpy(new_filename, "bglockless:");
				strcat(new_filename, filename);
				//printf("Changing the filename from %s to %s\n", filename, new_filename);
				strcpy(filename, new_filename);
			    }
			}
		}
		else {
			continue;
		}
	}
}

void set_mpi_parameter(mxml_node_t *tree, char *parameter_name, const char *filename, MPI_Info *orig_info)
{
	const char *node_file_name;
	mxml_node_t *node;

	for(node = mxmlFindElement(tree, tree, parameter_name, NULL, NULL,MXML_DESCEND); node != NULL; node = mxmlFindElement(node, tree, parameter_name, NULL, NULL,MXML_DESCEND)) {
		node_file_name = mxmlElementGetAttr(node, "FileName");
		#ifdef DEBUG
		printf("Node_file_name: %s\n", node_file_name);
		#endif
		// TODO: Change this strstr() function call with a use of basename!
		if((node_file_name == NULL) || (strstr(filename, node_file_name) != NULL))  {
			#ifdef DEBUG
			printf("Setting %s: %s\n", parameter_name, node->child->value.text.string);
			#endif
			MPI_Info_set(*orig_info, parameter_name, node->child->value.text.string);
		}
		else {
			continue;
		}
	}
}

hid_t set_hdf5_parameter(mxml_node_t *tree, char *parameter_name, const char *filename, hid_t fapl_id)
{
	const char *node_file_name;
	mxml_node_t *node;
	hid_t hasChunk=-1;

	for(node = mxmlFindElement(tree, tree, parameter_name, NULL, NULL,MXML_DESCEND); node != NULL; node = mxmlFindElement(node, tree, parameter_name, NULL, NULL,MXML_DESCEND)) {
		node_file_name = mxmlElementGetAttr(node, "FileName");
		#ifdef DEBUG
		printf("Node_file_name: %s\n", node_file_name);
		#endif
		// TODO: Change this strstr() function call with a use of basename!
		if((node_file_name == NULL) || (strstr(filename, node_file_name) != NULL))  {
				#ifdef DEBUG
				printf("Setting %s: %s\n", parameter_name, node->child->value.text.string);
				#endif
			if(strcmp(parameter_name, "sieve_buf_size") == 0) {
				int ierr = H5Pset_sieve_buf_size(fapl_id, atoi(node->child->value.text.string));
			}
			else if(strcmp(parameter_name, "alignment") == 0) {
				char *threshold = strtok(node->child->value.text.string, ",");
				char *alignment = strtok(NULL, ",");
				#ifdef DEBUG
				printf("Threshold=%s; Alignment=%s\n", threshold, alignment);
				#endif

				int ierr = H5Pset_alignment(fapl_id, atoi(threshold), atoi(alignment));
			}
			else if(strcmp(parameter_name, "chunk") == 0) {
				const char* variable_name = mxmlElementGetAttr(node, "VariableName");
				#ifdef DEBUG
				printf("VariableName: %s\n", variable_name);
				#endif

				if(variable_name == NULL || (variable_name != NULL && strcmp(variable_name, filename) == 0)) {

				    int ndims = H5Sget_simple_extent_ndims(fapl_id);
				    hsize_t *dims = (hsize_t *) malloc(sizeof(hsize_t) * ndims);
				    H5Sget_simple_extent_dims(fapl_id, dims, NULL);

				    #ifdef DEBUG
				    printf("dims[0] = %d, ndims = %d\n", dims[0], ndims);
				    printf("dims[1] = %d, ndims = %d\n", dims[1], ndims);
				    printf("dims[2] = %d, ndims = %d\n", dims[2], ndims);
				    #endif

				    hsize_t *chunk_arr = (hsize_t *) malloc(sizeof(hsize_t) * ndims);
				    int i;
				    chunk_arr[0] = atoi(strtok(node->child->value.text.string, ","));
				    if(chunk_arr[0] > dims[0])
					    return 0;
				    #ifdef DEBUG
				    printf("I should set chunk[0] for %s -> %d\n", filename, chunk_arr[0]);
				    #endif
				    for(i = 1; i < ndims; i++) {
					chunk_arr[i] = atoi(strtok(NULL, ","));
				    	if(chunk_arr[i] > dims[i])
					    return 0;
				    	#ifdef DEBUG
				    	printf("I should set chunk[%d] for %s -> %d\n", i, filename, chunk_arr[i]);
				    	#endif
				    }

				    //#ifdef DEBUG
				    //#endif

				    //hid_t tmp = H5Pcreate(H5P_DATASET_CREATE);
				    hasChunk = H5Pcreate(H5P_DATASET_CREATE);
				    H5Pset_chunk(hasChunk, ndims, chunk_arr);

				    return hasChunk;
				}
			}
		}
		else {
			continue;
		}
	}
	return hasChunk;
}

FORWARD_DECL(H5Fcreate, hid_t, (const char *filename, unsigned flags, hid_t fcpl_id, hid_t fapl_id));
FORWARD_DECL(H5Dwrite, herr_t, (hid_t dataset_id, hid_t mem_type_id, hid_t mem_space_id, hid_t file_space_id, hid_t xfer_plist_id, const void * buf));
FORWARD_DECL(H5Dcreate1, hid_t, (hid_t loc_id, const char *name, hid_t type_id, hid_t space_id, hid_t dcpl_id));
FORWARD_DECL(H5Dcreate2, hid_t, (hid_t loc_id, const char *name, hid_t dtype_id, hid_t space_id, hid_t lcpl_id, hid_t dcpl_id, hid_t dapl_id));

hid_t DECL(H5Fcreate)(const char *filename, unsigned flags, hid_t fcpl_id, hid_t fapl_id)
{
	herr_t ret;
	FILE *fp;
	mxml_node_t *tree;

	printf("Loading conf file: \n\n\n");

	MAP_OR_FAIL(H5Fcreate);

	char file_path[1024];
	strcpy(file_path, "config.xml");
  // char *config_file = getenv("AT_CONFIG_FILE");
  //TODO: use default values if config not specified
  // char *file_path = config_file ;
        #ifdef DEBUG
	       printf("Loading conf file: %s\n", file_path);
        #endif

	fp = fopen(file_path, "r");
	tree = mxmlLoadFile(NULL, fp, MXML_TEXT_CALLBACK);

	MPI_Comm orig_comm;
	MPI_Info orig_info;

	hid_t driver = H5Pget_driver(fapl_id);

	if(driver == H5FD_MPIO) {
    #ifdef DEBUG
		  printf("Driver is H5FD_MPIO\n");
		#endif
		ret = H5Pget_fapl_mpio(fapl_id, &orig_comm, &orig_info);
	}
  #ifdef H5_MPIPOSIX
  /*
  when defined MPIPOSIX then the Posix Driver will be supported
  for hdf5-1.8.9 to 1.8.12 versions
  */
  else if(driver == H5FD_MPIPOSIX) {
    #ifdef DEBUG
		  printf("Driver is H5FD_MPIPOSIX\n");
    #endif
		ret = H5Pget_fapl_mpiposix(fapl_id, &orig_comm, &orig_info);
	}
  #endif
  // end of MPIPOSIX ifdef
	else {
		fprintf(stderr, "AT Library supports mpio and mpiposix (hdf5-1.8.9-12) drivers only(). Returning...\n");
		return ret;
	}

	if(ret < 0) {
		fprintf(stderr, "Error in calling H5Pget_fapl(). Returning...\n");
		#ifdef DEBUG
		printf("LibAutoTuner: I'm calling H5Fcreate\n");
		#endif

		ret = __fake_H5Fcreate(filename, flags, fcpl_id, fapl_id);
		return ret;
	}

	if(orig_info == MPI_INFO_NULL) {
		#ifdef DEBUG
		printf("orig_info is null! creating a new one!\n");
		#endif
		MPI_Info_create(&orig_info);
	}
	else {
		#ifdef DEBUG
		printf("orig_info is not null! let me continue!\n");
		#endif
	}

	#ifdef DEBUG
	int nkeys = -1;
	MPI_Info_get_nkeys(orig_info, &nkeys);
	printf("orig_info has %d keys\n", nkeys);
	#endif

	set_gpfs_parameter(tree, "IBM_lockless_io", filename);
	set_mpi_parameter(tree, "IBM_largeblock_io", filename, &orig_info);

	set_mpi_parameter(tree, "striping_factor", filename, &orig_info);
	set_mpi_parameter(tree, "striping_unit", filename, &orig_info);

	set_mpi_parameter(tree, "cb_buffer_size", filename, &orig_info);
	set_mpi_parameter(tree, "cb_nodes", filename, &orig_info);
	set_mpi_parameter(tree, "bgl_nodes_pset", filename, &orig_info);

	set_hdf5_parameter(tree, "sieve_buf_size", filename, fapl_id);
	set_hdf5_parameter(tree, "alignment", filename, fapl_id);

	#ifdef DEBUG
	MPI_Info_get_nkeys(orig_info, &nkeys);
	printf("new orig_info has %d keys!\n", nkeys);
	#endif

	if(driver == H5FD_MPIO) {
		ret = H5Pset_fapl_mpio(fapl_id, orig_comm, orig_info);
	}
  #ifdef H5_MPIPOSIX
  /*
  when defined MPIPOSIX then the Posix Driver will be supported
  for hdf5-1.8.9 to 1.8.12 versions
  */
	else if(driver == H5FD_MPIPOSIX) {
		ret = H5Pset_fapl_mpiposix(fapl_id, orig_comm, orig_info);
	}
  #endif
  // end of MPIPOSIX ifdef
	else {
		fprintf(stderr, "AT Library supports mpio and mpiposix (hdf5-1.8.9-12) drivers only(). Returning...\n");
		return ret;
	}

	if(ret < 0) {
		fprintf(stderr, "Error in calling H5Pset_fapl_mpio(). Returning...\n");
		return ret;
	}

	fclose(fp);

	#ifdef DEBUG
	printf("LibAutoTuner: I'm calling H5Fcreate!\n");
	#endif
	ret = __fake_H5Fcreate(filename, flags, fcpl_id, fapl_id);

	return ret;
}

herr_t DECL(H5Dwrite)(hid_t dataset_id, hid_t mem_type_id, hid_t mem_space_id, hid_t file_space_id, hid_t xfer_plist_id, const void * buf) {
	herr_t ret;

	MAP_OR_FAIL(H5Dwrite);

	#ifdef DEBUG
	printf("dataset_id: %d\n", dataset_id);
	printf("mem_type_id: %d\n", mem_type_id);
	printf("mem_space_id: %d\n", mem_space_id);
	printf("file_space_id: %d\n", file_space_id);
	printf("xfer_plist_id: %d\n", xfer_plist_id);
	#endif

	#ifdef DEBUG
	printf("LibAutoTuner: I'm calling H5Dwrite!\n");
	#endif
	ret = __fake_H5Dwrite(dataset_id, mem_type_id, mem_space_id, file_space_id, xfer_plist_id, buf);

	#if 0
	int rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	if(rank == 0) {
		H5D_mpio_actual_io_mode_t actual_io_mode;
		herr_t ret2 = H5Pget_mpio_actual_io_mode(xfer_plist_id, &actual_io_mode);
		if(actual_io_mode == H5D_MPIO_NO_COLLECTIVE)
		   printf("mpio_actual_io_mode(): H5D_MPIO_NO_COLLECTIVE\n");
		else if(actual_io_mode == H5D_MPIO_CHUNK_INDEPENDENT)
		   printf("mpio_actual_io_mode(): H5D_MPIO_CHUNK_INDEPENDENT\n");
		else if(actual_io_mode == H5D_MPIO_CHUNK_COLLECTIVE)
		   printf("mpio_actual_io_mode(): H5D_MPIO_CHUNK_COLLECTIVE\n");
		else if(actual_io_mode == H5D_MPIO_CHUNK_MIXED)
		   printf("mpio_actual_io_mode(): H5D_MPIO_CHUNK_MIXED\n");
		else if(actual_io_mode == H5D_MPIO_CONTIGUOUS_COLLECTIVE)
		   printf("mpio_actual_io_mode(): H5D_MPIO_CONTIGUOUS_COLLECTIVE\n");

		H5D_mpio_actual_chunk_opt_mode_t actual_chunk_opt_mode;
		ret2 = H5Pget_mpio_actual_chunk_opt_mode(xfer_plist_id, &actual_chunk_opt_mode);
		if(actual_chunk_opt_mode == H5D_MPIO_NO_CHUNK_OPTIMIZATION)
		   printf("mpio_actual_chunk_opt_mode(): H5D_MPIO_NO_CHUNK_OPTIMIZATION\n");
		else if(actual_chunk_opt_mode == H5D_MPIO_MULTI_CHUNK)
		   printf("mpio_actual_chunk_opt_mode(): H5D_MPIO_MULTI_CHUNK\n");
		else if(actual_chunk_opt_mode == H5D_MPIO_MULTI_CHUNK_NO_OPT)
		   printf("mpio_actual_chunk_opt_mode(): H5D_MPIO_MULTI_CHUNK_NO_OPT\n");
		else if(actual_chunk_opt_mode == H5D_MPIO_LINK_CHUNK)
		   printf("mpio_actual_chunk_opt_mode(): H5D_MPIO_LINK_CHUNK\n");
	}
	#endif

	return ret;
}

hid_t DECL(H5Dcreate1)(hid_t loc_id, const char *name, hid_t type_id, hid_t space_id, hid_t dcpl_id) {
    herr_t ret;
    FILE *fp;
    mxml_node_t *tree;

    MAP_OR_FAIL(H5Dcreate1);

    char file_path[1024];
    strcpy(file_path, "config.xml");

    //strcat(file_path, "/.auto_tuner.conf");
    #ifdef DEBUG
    printf("Loading conf file for H5Dcreate1: %s\n", file_path);
    #endif

    fp = fopen(file_path, "r");
    tree = mxmlLoadFile(NULL, fp, MXML_TEXT_CALLBACK);

    hid_t chunked_pid = set_hdf5_parameter(tree, "chunk", name, space_id);

    if (chunked_pid == -1) {
		ret = __fake_H5Dcreate1(loc_id, name, type_id, space_id, dcpl_id);
	}
	else if(dcpl_id == 0) {
		ret = __fake_H5Dcreate1(loc_id, name, type_id, space_id, chunked_pid);
    }
    else {
		printf("Can not set chunked property list since dcpl_id is not 0!\n");
		ret = __fake_H5Dcreate1(loc_id, name, type_id, space_id, dcpl_id);
    }

    return ret;
}

hid_t DECL(H5Dcreate2)(hid_t loc_id, const char *name, hid_t dtype_id, hid_t space_id, hid_t lcpl_id, hid_t dcpl_id, hid_t dapl_id) {
    herr_t ret;
    FILE *fp;
    mxml_node_t *tree;

    MAP_OR_FAIL(H5Dcreate2);

    char file_path[1024];
    strcpy(file_path, "config.xml");

    #ifdef DEBUG
    printf("Loading conf file for H5Dcreate2: %s\n", file_path);
    #endif

    fp = fopen(file_path, "r");
    tree = mxmlLoadFile(NULL, fp, MXML_TEXT_CALLBACK);

    hid_t chunked_pid = set_hdf5_parameter(tree, "chunk", name, space_id);
    //printf("dcpl_id %d, chunked_pid %d \n",dcpl_id,chunked_pid);
    // TODO: What if dcpl_id is not zero!
    if (chunked_pid == -1) {
	ret = __fake_H5Dcreate2(loc_id, name, dtype_id, space_id, lcpl_id, dcpl_id, dapl_id);
    }
    else if(dcpl_id == 0) {
	ret = __fake_H5Dcreate2(loc_id, name, dtype_id, space_id, lcpl_id, dcpl_id, dapl_id);
    }
    else {
       ret = __fake_H5Dcreate2(loc_id, name, dtype_id, space_id, lcpl_id, chunked_pid, dapl_id);
    }


    return ret;

}
