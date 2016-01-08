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
		printf("Node_file_name: %s\n", node_file_name);
		#endif
		// TODO: Change this strstr() function call with a use of basename!
		if((node_file_name == NULL) || (strstr(filename, node_file_name) != NULL))  {
			if(strcmp(parameter_name, "IBM_lockless_io") == 0) {
			    if(strcmp(node->child->value.text.string, "true") == 0) {
				// I have to prefix the filename with "bglockless:".
				char* new_filename = (char *) malloc(sizeof(char) * 1024);
				strcpy(new_filename, "bglockless:");
				strcat(new_filename, filename);
				printf("Changing the filename from %s to %s\n", filename, new_filename);
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
				    #endif

				    hsize_t *chunk_arr = (hsize_t *) malloc(sizeof(hsize_t) * ndims);
				    int i, user_chunk;
				    for(i = 0; i < ndims; i++) {
					user_chunk = atoi(node->child->value.text.string);
					if(user_chunk > dims[i])
					    return 0;
					chunk_arr[i] = user_chunk;
				    }

				    printf("I should set chunking for %s to (%s*%d)\n", filename, node->child->value.text.string, ndims);
				    hid_t tmp = H5Pcreate(H5P_DATASET_CREATE);
				    H5Pset_chunk(tmp, ndims, chunk_arr);

				    return tmp;
				}
			}
		}
		else {
			continue;
		}
	}
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

	MAP_OR_FAIL(H5Fcreate);

	char *file_path = getenv("HOME"); strcat(file_path, "/.auto_tuner.conf");
	//char file_path[1024];
	//strcpy(file_path, "/intrepid-fs0/users/hluu/scratch/.auto_tuner.conf");
        #ifdef DEBUG
	printf("Loading conf file: %s\n", file_path);
        #endif

	fp = fopen(file_path, "r");
	tree = mxmlLoadFile(NULL, fp, MXML_TEXT_CALLBACK);

	MPI_Comm orig_comm;
	MPI_Info orig_info;

	ret = H5Pget_fapl_mpio(fapl_id, &orig_comm, &orig_info);
	if(ret < 0) {
		fprintf(stderr, "Error in calling H5Pget_fapl_mpio(). Returning...\n");
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
		#endif /* DEBUG */
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

	set_hdf5_parameter(tree, "sieve_buf_size", filename, fapl_id);
	set_hdf5_parameter(tree, "alignment", filename, fapl_id);

	#ifdef DEBUG
	MPI_Info_get_nkeys(orig_info, &nkeys);
	printf("new orig_info has %d keys!\n", nkeys);
	#endif

	ret = H5Pset_fapl_mpio(fapl_id, orig_comm, orig_info);
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
	/*printf("dataset_id: %d\n", dataset_id);
	printf("mem_type_id: %d\n", mem_type_id);
	printf("mem_space_id: %d\n", mem_space_id);
	printf("file_space_id: %d\n", file_space_id);
	printf("xfer_plist_id: %d\n", xfer_plist_id);*/
	#endif

	#ifdef DEBUG
	printf("LibAutoTuner: I'm calling H5Dwrite!\n");
	#endif
	ret = __fake_H5Dwrite(dataset_id, mem_type_id, mem_space_id, file_space_id, xfer_plist_id, buf);

	return ret;
}

hid_t DECL(H5Dcreate1)(hid_t loc_id, const char *name, hid_t type_id, hid_t space_id, hid_t dcpl_id) {
    herr_t ret;
    FILE *fp;
    mxml_node_t *tree;

    MAP_OR_FAIL(H5Dcreate1);

    char *file_path = getenv("HOME");
    //strcat(file_path, "/.auto_tuner.conf");
    #ifdef DEBUG
    printf("Loading conf file for H5Dcreate1: %s\n", file_path);
    #endif

    fp = fopen(file_path, "r");
    tree = mxmlLoadFile(NULL, fp, MXML_TEXT_CALLBACK);

    hid_t chunked_pid = set_hdf5_parameter(tree, "chunk", name, space_id);

    if(dcpl_id == 0) {
	ret = __fake_H5Dcreate1(loc_id, name, type_id, space_id, chunked_pid);
	//ret = __fake_H5Dcreate1(loc_id, name, type_id, space_id, dcpl_id);
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

    char *file_path = getenv("HOME");
    strcat(file_path, "/.auto_tuner.conf");
    //#ifdef DEBUG
    printf("Loading conf file for H5Dcreate2: %s\n", file_path);
    //#endif

    fp = fopen(file_path, "r");
    tree = mxmlLoadFile(NULL, fp, MXML_TEXT_CALLBACK);

    #ifdef DEBUG
    printf("LibAutoTuner: I'm calling H5Dcreate2!\n");
    #endif

    set_hdf5_parameter(tree, "chunk", name, dcpl_id);

    ret = __fake_H5Dcreate2(loc_id, name, dtype_id, space_id, lcpl_id, dcpl_id, dapl_id);

    return ret;
}

