
/*
* Copyright by The HDF Group.
* All rights reserved.
*
* This file is part of h5tuner. The full h5tuner copyright notice,
* including terms governing use, modification, and redistribution, is
* contained in the file COPYING, which can be found at the root of the
* source code distribution tree.  If you do not have access to this file,
* you may request a copy from help@hdfgroup.org.
*/


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libgen.h>
#include <pwd.h>
#include "mpi.h"
#include "hdf5.h"
#include "autotuner.h"
#include "mxml.h"

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
			fprintf(stderr, "H5Tuner failed to map symbol: %s\n", #func); \
			exit(1); \
		} \
	}

/* MSC - Needs a test */
void set_gpfs_parameter(mxml_node_t *tree, char *parameter_name, char *filename, /* OUT */ char **new_filename)
{
	char *node_file_name;
	mxml_node_t *node;

	for(node = mxmlFindElement(tree, tree, parameter_name, NULL, NULL, MXML_DESCEND);
            node != NULL; node = mxmlFindElement(node, tree, parameter_name, NULL, NULL, MXML_DESCEND)) {
		node_file_name = mxmlElementGetAttr(node, "FileName");
#ifdef DEBUG
		/* printf("Node_file_name: %s\n", node_file_name); */
#endif
		// TODO: Change this strstr() function call with a use of basename!
		if((node_file_name == NULL) || (strstr(filename, node_file_name) != NULL))  {
			if(strcmp(parameter_name, "IBM_lockless_io") == 0) {
			    if(strcmp(node->child->value.text.string, "true") == 0) {
				/* to prefix the filename with "bglockless:". */

                char *new_filename = NULL;
                new_filename = (char *) malloc(sizeof(char) * (strlen(filename) + size of "bglockless:"));

				strcpy(new_filename, "bglockless:");
				strcat(new_filename, filename);
#ifdef DEBUG
				/* printf("Changing the filename from %s to %s\n", filename, new_filename); */
#endif
				strcpy(filename, new_filename);
			    }
			}
		}
		else {
			continue;
		}
	}
}

/* MSC add MPI error codes */
void set_mpi_parameter(mxml_node_t *tree, char *parameter_name, const char *filename, MPI_Info *orig_info)
{
    const char *node_file_name;
    mxml_node_t *node;
    int mpi_code;
    int error = 0;


    for(node = mxmlFindElement(tree, tree, parameter_name, NULL, NULL,MXML_DESCEND);
            node != NULL; node = mxmlFindElement(node, tree, parameter_name, NULL, NULL,MXML_DESCEND)) {
        node_file_name = mxmlElementGetAttr(node, "FileName");

#ifdef DEBUG
        /* printf("Node_file_name: %s\n", node_file_name); */
#endif
        if(node_file_name == NULL)  {
#ifdef DEBUG
            /* printf("H5Tuner: Execution wide setting %s: %s\n", parameter_name, node->child->value.text.string); */
#endif
            mpi_code = MPI_Info_set(*orig_info, parameter_name, node->child->value.text.string);
            if(mpi_code != MPI_SUCCESS)
                return ++error;
        }
        /* MSC - CHECK usage of strstr().. need to switch to strcmp() probably */
        else {
            if( strstr(filename, node_file_name) != NULL )  {
#ifdef DEBUG
                /* printf("H5Tuner: %s setting %s: %s\n\n\n",node_file_name, parameter_name, node->child->value.text.string); */
#endif
                mpi_code = MPI_Info_set(*orig_info, parameter_name, node->child->value.text.string);
                if(mpi_code != MPI_SUCCESS)
                    return ++error;
            }
             /* continue; */
        }
    }
}

(tree, "chunk", "D1", space_id);

set_hdf5_fcreate_parameter(file_name, ...)
set_hdf5_dcreate_parameter(file_name, dataset_name, ...);

/* MSC - This is not tested with chunk and will no get in to chunk setting with H5Dcreate() */
hid_t set_hdf5_parameter(mxml_node_t *tree, char *parameter_name, const char *filename, hid_t fapl_id)
{
	const char *node_file_name;
	mxml_node_t *node;



	hid_t dcpl_id=-1;

	for(node = mxmlFindElement(tree, tree, parameter_name, NULL, NULL,MXML_DESCEND);
            node != NULL; node = mxmlFindElement(node, tree, parameter_name, NULL, NULL,MXML_DESCEND)) {
		node_file_name = mxmlElementGetAttr(node, "FileName");
#ifdef DEBUG
		  /* printf("Node_file_name: %s\n", node_file_name); */
#endif
        /* MSC - strstr() wrong usage here */
		if((node_file_name == NULL) || (strstr(filename, node_file_name) != NULL))  {
#ifdef DEBUG
			/* printf("H5Tuner: setting %s: %s\n", parameter_name, node->child->value.text.string); */
#endif
			if(strcmp(parameter_name, "sieve_buf_size") == 0) {
                herr_t ierr = H5Pset_sieve_buf_size(fapl_id, atoi(node->child->value.text.string));

			}
			else if(strcmp(parameter_name, "alignment") == 0) {
				char *threshold = strtok(node->child->value.text.string, ",");
				char *alignment = strtok(NULL, ",");
#ifdef DEBUG
				/* printf("H5Tuner: setting Threshold=%s; Alignment=%s\n", threshold, alignment); */
#endif

				herr_t ierr = H5Pset_alignment(fapl_id, stroull(threshold,(char **)NULL,10), stroull(alignment,(char **)NULL,10));
			}
			else if(strcmp(parameter_name, "chunk") == 0) {
				const char* variable_name = mxmlElementGetAttr(node, "VariableName");
#ifdef DEBUG
			     /* printf("H5Tuner: VariableName: %s\n", variable_name); */
#endif

				if(variable_name == NULL || (variable_name != NULL && strcmp(variable_name, filename) == 0)) {

				    int ndims = H5Sget_simple_extent_ndims(fapl_id);
				    hsize_t *dims = (hsize_t *) malloc(sizeof(hsize_t) * ndims);
				    H5Sget_simple_extent_dims(fapl_id, dims, NULL);

#ifdef DEBUG
    /* printf("dims[0] = %d, ndims = %d\n", dims[0], ndims);
    printf("dims[1] = %d, ndims = %d\n", dims[1], ndims);
    printf("dims[2] = %d, ndims = %d\n", dims[2], ndims); */
#endif

				    hsize_t *chunk_arr = (hsize_t *) malloc(sizeof(hsize_t) * ndims);
				    int i;

				    chunk_arr[0] = stroull(strtok(node->child->value.text.string, ","),(char **)NULL,10);
				    if(chunk_arr[0] > dims[0])
					    return 0;
#ifdef DEBUG
    /* printf("H5Tuner: Setting chunk[0] for %s -> %d\n", filename, chunk_arr[0]); */
#endif
				    for(i = 1; i < ndims; i++) {
                                        /* MSC - same is above */
					    chunk_arr[i] = stroull(strtok(NULL, ","),(char **)NULL,10);
				    	if(chunk_arr[i] > dims[i])
					      return 0;
				    	#ifdef DEBUG
				    	  /* printf("H5Tuner: Setting chunk[%d] for %s -> %d\n", i, filename, chunk_arr[i]); */
				    	#endif
				    }

				    /* hid_t tmp = H5Pcreate(H5P_DATASET_CREATE); */
				    dcpl_id = H5Pcreate(H5P_DATASET_CREATE);
				    H5Pset_chunk(dcpl_id, ndims, chunk_arr);

				    return dcpl_id;
				}
			}
		}
		else {
			continue;
		}
	}
	return dcpl_id;
}

FORWARD_DECL(H5Fcreate, hid_t, (const char *filename, unsigned flags, hid_t fcpl_id, hid_t fapl_id));
FORWARD_DECL(H5Dwrite, herr_t, (hid_t dataset_id, hid_t mem_type_id, hid_t mem_space_id, hid_t file_space_id, hid_t xfer_plist_id, const void * buf));
FORWARD_DECL(H5Dcreate1, hid_t, (hid_t loc_id, const char *name, hid_t type_id, hid_t space_id, hid_t dcpl_id));
FORWARD_DECL(H5Dcreate2, hid_t, (hid_t loc_id, const char *name, hid_t dtype_id, hid_t space_id, hid_t lcpl_id, hid_t dcpl_id, hid_t dapl_id));

hid_t DECL(H5Fcreate)(const char *filename, unsigned flags, hid_t fcpl_id, hid_t fapl_id)
{
	hid_t ret_value = -1;
    herr_t ret = -1;
	FILE *fp;
	mxml_node_t *tree;

	MAP_OR_FAIL(H5Fcreate);


	char file_path[1024];
	strcpy(file_path, "config.xml");
    /* char *config_file = getenv("AT_CONFIG_FILE"); */
    /* char *file_path = config_file ; */
  #ifdef DEBUG
	  /* printf("\nH5Tuner: Loading parameters file: %s\n", file_path); */
  #endif

	fp = fopen(file_path, "r");
	tree = mxmlLoadFile(NULL, fp, MXML_TEXT_CALLBACK);

	MPI_Comm orig_comm;
	MPI_Info orig_info;

	hid_t driver = H5Pget_driver(fapl_id);

	if(driver == H5FD_MPIO) {
    #ifdef DEBUG
		  /* printf("Driver is H5FD_MPIO\n"); */
		#endif
		ret = H5Pget_fapl_mpio(fapl_id, &orig_comm, &orig_info);
	}
	else {
		fprintf(stderr, "H5Tuner Library supports mpio drivers only(). Returning...\n");
		return ret_value;
	}

	if(ret < 0) {
		fprintf(stderr, "Error in calling H5Pget_fapl(). Returning...\n");
#ifdef DEBUG
	  	/* printf("H5Tuner: calling H5Fcreate.\n"); */
#endif

		ret_value = __fake_H5Fcreate(filename, flags, fcpl_id, fapl_id);
		return ret_value;
	}

	if(orig_info == MPI_INFO_NULL) {
#ifdef DEBUG
		  /* printf("H5Tuner: found no MPI_Info object and is creating a new one.\n"); */
#endif
		mpi_code = MPI_Info_create(&orig_info);
        if(mpi_code != MPI_SUCCESS)
            return ++error;
	}
	else {

#ifdef DEBUG
		  /* printf("H5Tuner: MPI_Info object is not null. Continuing.\n"); */
#endif
	}

#ifdef DEBUG
	  int nkeys = -1;
	  mpi_code = MPI_Info_get_nkeys(orig_info, &nkeys);
      if(mpi_code != MPI_SUCCESS)
          return ++error;
	  /* printf("H5Tuner: MPI_Info object has %d keys\n", nkeys); */
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
	  mpi_code = MPI_Info_get_nkeys(orig_info, &nkeys);
      if(mpi_code != MPI_SUCCESS)
          return ++error;
	/* printf("H5Tuner: completed parameters setting \n");
    printf("H5Tuner created MPI_Info object has %d keys!\n", nkeys); */
#endif

	if(driver == H5FD_MPIO) {
		ret = H5Pset_fapl_mpio(fapl_id, orig_comm, orig_info);
	}
	else {
		fprintf(stderr, "H5Tuner Library supports mpio drivers only(). Returning...\n");
		return ret_value;
	}

	if(ret < 0) {
		fprintf(stderr, "Error in calling H5Pset_fapl_mpio(). Returning...\n");
		return ret_value;
	}

	fclose(fp);

#ifdef DEBUG
	  /* printf("\nH5Tuner: calling H5Fcreate.\n"); */
#endif
	ret_value = __fake_H5Fcreate(filename, flags, fcpl_id, fapl_id);

	return ret_value;
}

herr_t DECL(H5Dwrite)(hid_t dataset_id, hid_t mem_type_id, hid_t mem_space_id, hid_t file_space_id, hid_t xfer_plist_id, const void * buf) {
	herr_t ret = -1;

	MAP_OR_FAIL(H5Dwrite);

#ifdef DEBUG
	/* printf("dataset_id: %d\n", dataset_id);
	  printf("mem_type_id: %d\n", mem_type_id);
	  printf("mem_space_id: %d\n", mem_space_id);
  	  printf("file_space_id: %d\n", file_space_id);
  	  printf("xfer_plist_id: %d\n", xfer_plist_id); */
#endif

#ifdef DEBUG
	  /* printf("\nH5Tuner: calling H5Dwrite.\n"); */
#endif
	ret = __fake_H5Dwrite(dataset_id, mem_type_id, mem_space_id, file_space_id, xfer_plist_id, buf);

	return ret;
}

hid_t DECL(H5Dcreate1)(hid_t loc_id, const char *name, hid_t type_id, hid_t space_id, hid_t dcpl_id) {
    herr_t ret = -1;
    hid_t ret_value = -1;
    FILE *fp;
    mxml_node_t *tree;

    MAP_OR_FAIL(H5Dcreate1);

    char file_path[1024];
    strcpy(file_path, "config.xml");

#ifdef DEBUG
      /* printf("\nH5Tuner: Loading parameters file for H5Dcreate1: %s\n", file_path); */
#endif

    fp = fopen(file_path, "r");
    tree = mxmlLoadFile(NULL, fp, MXML_TEXT_CALLBACK);

    hid_t chunked_pid = set_hdf5_parameter(tree, "chunk", name, space_id);

#ifdef DEBUG
  	  /* printf("\nH5Tuner: calling H5Dcreate1.\n"); */
  #endif

    if (chunked_pid == -1) {
		    ret_value = __fake_H5Dcreate1(loc_id, name, type_id, space_id, dcpl_id);
	  }
	  else if(dcpl_id == 0) {
		    ret_value = __fake_H5Dcreate1(loc_id, name, type_id, space_id, chunked_pid);
    }
    else {
		    printf("H5Tuner: Cannot set chunked property list since dcpl_id is not 0!\n");
		    ret_value = __fake_H5Dcreate1(loc_id, name, type_id, space_id, dcpl_id);
    }

    return ret_value;
}

hid_t DECL(H5Dcreate2)(hid_t loc_id, const char *name, hid_t dtype_id, hid_t space_id, hid_t lcpl_id, hid_t dcpl_id, hid_t dapl_id) {
    herr_t ret = -1;
    hid_t ret_value = -1;
    FILE *fp;
    mxml_node_t *tree;

    MAP_OR_FAIL(H5Dcreate2);

    char file_path[1024];
    strcpy(file_path, "config.xml");

#ifdef DEBUG
      /* printf("\nH5Tuner: Loading parameters file for H5Dcreate2: %s\n", file_path); */
#endif

    fp = fopen(file_path, "r");
    tree = mxmlLoadFile(NULL, fp, MXML_TEXT_CALLBACK);

    hid_t chunked_pid = set_hdf5_parameter(tree, "chunk", name, space_id);

#ifdef DEBUG
  	  /* printf("\nH5Tuner: calling H5Dcreate2.\n"); */
 #endif

    if (chunked_pid == -1) {
	     ret_value = __fake_H5Dcreate2(loc_id, name, dtype_id, space_id, lcpl_id, dcpl_id, dapl_id);
    }
    else if(dcpl_id == 0) {
	     ret_value = __fake_H5Dcreate2(loc_id, name, dtype_id, space_id, lcpl_id, dcpl_id, dapl_id);
    }
    else {
      printf("H5Tuner: Cannot set chunked property list since dcpl_id is not 0.\n");
       ret_value = __fake_H5Dcreate2(loc_id, name, dtype_id, space_id, lcpl_id, chunked_pid, dapl_id);
    }

    return ret_value;

}
