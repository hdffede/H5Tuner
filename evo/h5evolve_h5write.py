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

import subprocess
import shutil
import os
import os.path
import sys
import time
import glob
import datetime
import signal
from shutil import move
import re

import pyevolve
from pyevolve import G1DList
from pyevolve import GSimpleGA
from pyevolve import Selectors
from pyevolve import Statistics
from pyevolve import DBAdapters
from pyevolve import GAllele
from pyevolve import Mutators
from pyevolve import Initializators
from pyevolve import Consts


from xml.dom.minidom import Document

NO_OF_PARAMS=5
STRING_LEN=6
NUM_ELITE=3
NUM_POP=15
NUM_GENS=40
GLOB_COUNT=0

pyevolve.logEnable()

class Alarm(Exception):
     pass

def alarm_handler(signum, frame):
     raise Alarm

#####################################################################################
#
# Tunable Parameters
#
#####################################################################################

###################
# Striping
###################

# The default value for stripe_count is 1. We are going to skip 1 and 4 because they
# are shown to be very bad. Choosing stripe_count to be -1 means stripe over all of
# available OSTs.
strp_fac = [4, 8, 16, 24, 32, 48, 64, 96, 128, -1];

# The default value for stripe_size is 1 MB. It has to be a multiple of page size(64KB).
# A good stiripe size for seq.I/O is between 1 MB and 4 MB. The minimu is 512 KB and the
# maximum is 4 GB.
strp_unt = [1048576, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 134217728];

#######################
# Collective Buffering
#######################

# The number of aggregators
cb_nds = [1, 2, 4, 8, 16, 24, 32, 48, 64, 96, 128, 256];

# Collective buffering buffer siz
# cb_buf_size = [4194304, 8388608, 16777216, 33554432, 67108864, 134217728];

#################
# HDF5
#################
# HDF5 Alignment
# NEW, NOT FOR IPDPS: alignment = [65536, 131072, 262144, 524288, 1048576, 2097152];
#alignment = [65535, 131070, 262140, 524280, 1048560, 2097120];
alignment = ["1, 1", "0, 4096", "0, 16384", "0, 65536", "0, 262144", "1024, 4096", "1024, 16384", "1024, 65536", "1024, 262144", "4096, 16384", "4096, 65536", "4096, 262144", "16384, 65536", "16384, 262144"]

# Data Sieving buffer size
# PRABHAT
#siv_buf_size = [65535, 131070, 262140, 524280, 1048560, 2097120];
siv_buf_size = [536870912]

#####################################################################
# Utility files used during the evolve iterations
#####################################################################
result_output = open('./result_output.txt', 'w')
config_feat_file = open('./config_feat.txt', 'w')
running_time_file = open('./running_time.txt', 'w')
perf_feat_filenames_file = open('./perf_feat_filenames.txt', 'w')

def eval_func(genome):
   Logdir = './Logs/'
    HOME = os.environ['PWD']
   # set SCRATCH variable prior to execution evolve or use current directory
   if os.getenv('SCRATCH', 0):
       SCRATCH = os.environ['SCRATCH']
   else:
       # SCRATCH not defined then use PWD
       SCRATCH = os.environ['PWD']
       os.environ['SCRATCH'] = SCRATCH


   this_strp_fac = genome[0];
   this_strp_unt = genome[1];
   this_cb_nds = genome[2];
   # this_cb_buf_size = genome[3]; Ruth(David's) Suggestion
   this_cb_buf_size = genome[1];
   #this_align = genome[4];
   this_align_str = genome[3];
   tmp = re.split(', ', this_align_str);
   this_align_thresh = int(tmp[0])
   this_align = int(tmp[1])

   #this_siv_buf_size = genome[5];
   this_siv_buf_size = genome[4];

   # check to see if result's in history; if it is, use that!
   #for line in open("result_output.txt"):
   #   if str(this_strp_fac) + ", " + str(this_strp_unt) + ", " + str(this_cb_nds) + str(this_cb_buf_size) + ", " + str(this_align) + ", " + str(this_siv_buf_size) in line:
   #      return float(line.split(", ")[6])

   print "Evaluate Parameters config (%d, %d, %d, %d, %d, %d): " % (this_strp_fac, this_strp_unt, this_cb_nds, this_align_thresh, this_align, this_siv_buf_size)
   #sys.stdout.flush()

   ####################################################################
   #
   # Create the minidom document for tunable parameters
   #
   ####################################################################
   doc = Document()

   # Create the <Parameters> base element
   params = doc.createElement("Parameters")
   doc.appendChild(params)

   high = doc.createElement("High_Level_IO_Library");
   params.appendChild(high)
   algn = doc.createElement("alignment");
   high.appendChild(algn);
   algn_txt_tmp = str(this_align_thresh) + ',' + str(this_align);
   algn_txt = doc.createTextNode(algn_txt_tmp);
   algn.appendChild(algn_txt);

   siv_buf = doc.createElement("sieve_buf_size");
   high.appendChild(siv_buf);
   siv_buf_txt = doc.createTextNode(str(this_siv_buf_size));
   siv_buf.appendChild(siv_buf_txt);

   mid = doc.createElement("Middleware_Layer");
   params.appendChild(mid);
   cb_n = doc.createElement("cb_nodes");
   mid.appendChild(cb_n);
   cb_n_txt = doc.createTextNode(str(this_cb_nds));
   cb_n.appendChild(cb_n_txt);

   cb_buf = doc.createElement("cb_buffer_size");
   mid.appendChild(cb_buf);
   cb_buf_txt = doc.createTextNode(str(this_cb_buf_size));
   cb_buf.appendChild(cb_buf_txt);

   low = doc.createElement("Parallel_File_System");
   params.appendChild(low);
   strp_fac_obj = doc.createElement("striping_factor");
   low.appendChild(strp_fac_obj);
   strp_fac_txt = doc.createTextNode(str(this_strp_fac));
   strp_fac_obj.appendChild(strp_fac_txt);

   strp_unt_obj = doc.createElement("striping_unit");
   low.appendChild(strp_unt_obj);
   strp_unt_txt = doc.createTextNode(str(this_strp_unt));
   strp_unt_obj.appendChild(strp_unt_txt);

   home_dir = os.environ['PWD'];
   file_path = home_dir + 'config.xml'
   config_file = open(file_path, 'w');
   config_file.write(doc.toprettyxml(indent="  "))
   config_file.close()

   ####################################################################
   #
   #  Application/Job Execution
   #
   ####################################################################

   print 'Starting Application Execution'
   #sys.stdout.flush()

   todays_date = datetime.datetime.now()
   print todays_date

   #####################################################
   # Clean up working space
   #####################################################
   if "sample_dataset.h5part" in os.listdir(SCRATCH):
      os.remove(SCRATCH + '/sample_dataset.h5part')
   if "vorpalio.h5" in os.listdir(SCRATCH):
      os.remove(SCRATCH + '/vorpalio.h5')
   if "prs.h5" in os.listdir(SCRATCH):
      os.remove(SCRATCH + '/prs.h5')

   signal.signal(signal.SIGALRM, alarm_handler)
   signal.alarm(59*60)  # 59 minutes

   #################################
   # SIZE OF THE OUTPUT FILE OF
   #################################
   VPIC_128 = 32000000
   VORPAL_128 = 34000000
   GCRM_128 = 30000000
   VPIC_512 = 120000000
   VORPAL_512 = 120000000
   GCRM_512 = 120000000
   VPIC_4096 = 1000000000

   try:
       valid = 0;
       start = 0.0;
       elapsed = 0.0;
       for i in range(5):
           start = time.time()

           # print 'start time: ', start
           # VPIC RUN
           #q = subprocess.Popen(['ibrun /work/01657/bbehza2/HDF/VPIC/vpicbench_uni/vpicio_uni /scratch/01657/bbehza2/sample_dataset.h5part', "-np", "512"], stdout=subprocess.PIPE, shell=True)

           # VORPAL RUN
           # q = subprocess.Popen(["ibrun $WORK/HDF/VORPALIO/vorpalio/vorpalio -b 100 100 60 -n 8 8 8 -t 20 -o '/scratch/01657/bbehza2'", "-np", "512"], stdout=subprocess.PIPE, shell=True)

           # GCRM RUN
           #q = subprocess.Popen(["ibrun $WORK/HDF/GCRM/gcrmio/gcrmio -r 11 -s 7 -prs -t 10 -o '/scratch/01657/bbehza2'", "-np", "128"], stdout=subprocess.PIPE, shell=True)
           #q = subprocess.Popen(["ibrun $WORK/HDF/GCRM/gcrmio/gcrmio -r 11 -s 7 -prs -t 40 -o '/scratch/01657/bbehza2'", "-np", "512"], stdout=subprocess.PIPE, shell=True)

           q = subprocess.Popen(["$SCRATCH/h5_write", "rm SDS.h5"], stdout=subprocess.PIPE, shell=True)
           out, err = q.communicate()
           print out

           elapsed = (time.time() - start)
           print 'elapsed time; ', elapsed

           ####################################################################
           # Monitor size of output
           ####################################################################

           #if "sample_dataset.h5part" in os.listdir(SCRATCH):
           #    if os.path.getsize(SCRATCH + '/sample_dataset.h5part') > VPIC_512:
           #        valid = 1;
           #        break;
           #if "vorpalio.h5" in os.listdir(SCRATCH):
           #    if os.path.getsize(SCRATCH + '/vorpalio.h5') > VORPAL_512:
           #        valid = 1;
           #        break;
           #if "prs.h5" in os.listdir(SCRATCH):
           #   if os.path.getsize(SCRATCH + '/prs.h5') > GCRM_512:
           #        valid = 1;
           #        break;

   except Alarm:
       print 'Taking too long, returning\n'
       return float(10000);

   ################################################################
   # Evolution settings results update
   ################################################################

   global NUM_POP, NUM_ELITE, GLOB_COUNT
   this_gen = GLOB_COUNT / NUM_POP
   GLOB_COUNT = GLOB_COUNT + 1
   print 'Glog_count ', GLOB_COUNT
   print 'this_gen', this_gen
   print 'num pop',NUM_POP,'num elite',NUM_ELITE

   str_result = str(this_gen) + ': ' + str(this_strp_fac) + ', ' + str(this_strp_unt) + ', ' + str(this_cb_nds) + ', ' + str(this_cb_buf_size) + ', ' + str(this_align_thresh) + ', ' + str(this_align) + ', ' + str(this_siv_buf_size) + ': ' + str(elapsed);

   str_param = str(this_strp_fac) + ', ' + str(this_strp_unt) + ', ' + str(this_cb_nds) + ', ' + str(this_cb_buf_size) + ', ' + str(this_align_thresh) + ', ' + str(this_align) + ', ' + str(this_siv_buf_size);

   config_feat_file.write(str_param);
   config_feat_file.write('\n');

   result_output.write(str_result);
   result_output.write('\n');
   running_time_file.write('[' + str(todays_date) + '] ' + str_result + '=' + str(valid) + '\n');

   sys.stdout.flush()
   result_output.flush()
   config_feat_file.flush()
   running_time_file.flush()
   perf_feat_filenames_file.flush()

   return float(elapsed);

def ConvergenceCriteria(ga_engine):
   best = ga_engine.bestIndividual()
   # Best Score of 128 cores is about 50 seconds
   return best.score <= 40
   # Best Score of 4096 cores is about 600 seconds
   #return best.score <= 600


def run_main():
   print "Starting main()!"
   #sys.stdout.flush()
   global NUM_GENS, NUM_POP, NUM_ELITE, GLOB_COUNT, NO_OF_PARAMS
   setOfAlleles = GAllele.GAlleles()
   sf = GAllele.GAlleleList(strp_fac)
   su = GAllele.GAlleleList(strp_unt)
   cn = GAllele.GAlleleList(cb_nds)
   # cs = GAllele.GAlleleList(cb_buf_size)
   al = GAllele.GAlleleList(alignment)
   sb = GAllele.GAlleleList(siv_buf_size)
   setOfAlleles.add(sf)
   setOfAlleles.add(su)
   setOfAlleles.add(cn)
   # setOfAlleles.add(cs)
   setOfAlleles.add(al)
   setOfAlleles.add(sb)

   genome = G1DList.G1DList(NO_OF_PARAMS)
   genome.setParams(allele=setOfAlleles)

   genome.evaluator.set(eval_func)
   genome.mutator.set(Mutators.G1DListMutatorAllele)
   genome.initializator.set(Initializators.G1DListInitializatorAllele)

   ga = GSimpleGA.GSimpleGA(genome)
   ga.selector.set(Selectors.GRouletteWheel)
   ga.setMutationRate(0.15);
   ga.setGenerations(NUM_GENS)
   #ga.terminationCriteria.set(ConvergenceCriteria)
   ga.setPopulationSize(NUM_POP)
   ga.setMinimax(Consts.minimaxType["minimize"])
   ga.setElitism(True)
   ga.setElitismReplacement(NUM_ELITE)
   print 'ga.evolve'
   ga.evolve(freq_stats=1)
   print 'closing result'
   result_output.close()
   print 'Best solution'
   print ga.bestIndividual()

if __name__ == "__main__":
   run_main();
