/* 
* Copyright by The HDF Group.
* All rights reserved.
*
* This file is part of h5tuner. The full h5tuner copyright notice,
*  including terms governing use, modification, and redistribution, is
* contained in the file COPYING, which can be found at the root of the
* source code distribution tree.  If you do not have access to this file,
* you may request a copy from help@hdfgroup.org.
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <pwd.h>
#include "mpi.h"
#include "hdf5.h"
#include "autotuner.h"
#include "mxml.h"

/*
typedef int hid_t;
typedef int herr_t;
*/

#define FORWARD_DECL(name, ret, args) \
	extern ret __real_ ## name args;

#define DECL(__name) __wrap_ ## __name

FORWARD_DECL(H5Fcreate, hid_t, (const char *filename, unsigned flags, hid_t fcpl_id, hid_t fapl_id));
FORWARD_DECL(H5Fopen, hid_t, (const char *filename, unsigned flags, hid_t fapl_id));

hid_t DECL(H5Fcreate)(const char *filename, unsigned flags, hid_t fcpl_id, hid_t fapl_id)
{
	herr_t ret = -1;
	FILE *fp;
	mxml_node_t *tree;

	char file_path[1024];
	strcpy(file_path, "config.xml");

	#ifdef DEBUG
		printf("Loading config file: %s\n", file_path);
	#endif

	fp = fopen(file_path, "r");
        if(fp != NULL) {
                #ifdef DEBUG
			printf("Opening config file: %s\n", file_path);
		#endif
		tree = mxmlLoadFile(NULL, fp, MXML_TEXT_CALLBACK);
	}
	else {
		fprintf(stderr, "Error in opening config file %s. Returning...\n", file_path);
		return ret;
		//TODO check that ret is meaningful to the return function or simply exit
	}

	MPI_Comm orig_comm;
	MPI_Info orig_info;

	ret = H5Pget_fapl_mpio(fapl_id, &orig_comm, &orig_info);
	if(ret < 0) {
		fprintf(stderr, "Error in calling H5Pget_fapl_mpio(). Returning...\n");
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
	printf("orig_info has %d keys!\n", nkeys);
	#endif

	mxml_node_t *node;
	node = mxmlFindElement(tree, tree, "striping_factor", NULL, NULL,MXML_DESCEND);
	if(node != NULL) {
		#ifdef DEBUG
                if(node->child != NULL) {
			printf("striping_factor: %s\n", node->child->value.text.string);
                }
		else {
			printf("NULL striping_factor: \n");
		}
		#endif
                if(node->child != NULL) {
			MPI_Info_set(orig_info, "striping_factor", node->child->value.text.string);
			#ifdef DEBUG
				printf("MPI_Info_set striping_factor: %s\n", node->child->value.text.string);
			#endif
		}
		else {
			printf("Could not set MPI_Info because of NULL striping_factor: \n");
		}
	}

	node = mxmlFindElement(tree, tree, "striping_unit", NULL, NULL,MXML_DESCEND);
	if(node != NULL) {
		#ifdef DEBUG
		if(node->child != NULL) {
			printf("striping_unit: %s\n", node->child->value.text.string);
                }
                else {
                        printf("NULL striping_unit: \n");
                }
		#endif
                if(node->child != NULL) {
			MPI_Info_set(orig_info, "striping_unit", node->child->value.text.string);
                        #ifdef DEBUG
                                printf("MPI_Info_set striping_unit: %s\n", node->child->value.text.string);
                        #endif
                }
                else {
                        printf("Could not set MPI_Info because of NULL striping_uni: \n");
                }
        }


	#ifdef DEBUG
	MPI_Info_get_nkeys(orig_info, &nkeys);
	printf("new orig_info has %d keys!\n", nkeys);
	#endif

	ret = H5Pset_fapl_mpio(fapl_id, orig_comm, orig_info);
	if(ret < 0) {
		fprintf(stderr, "Error in calling H5Pset_fapl_mpio(). Returning...\n");
		return ret;
	}

	#ifdef DEBUG
		printf("calling H5Fcreate with filename %s \n", filename);
	#endif
	ret = __real_H5Fcreate(filename, flags, fcpl_id, fapl_id);
	#ifdef DEBUG
		printf("called H5Fcreate with filename %s \n", filename);
		if (fclose(fp) != 0) {
			printf("Closed config file \n");
			strcpy( file_path, "");
			printf("reset path of config file \n");
		}
	#endif

	return ret;
}

hid_t DECL(H5Fopen)(const char *filename, unsigned flags, hid_t fapl_id)
{
	int ret;

	printf("Calling H5Fopen!\n");
	ret = __real_H5Fopen(filename, flags, fapl_id);

	return ret;

}
