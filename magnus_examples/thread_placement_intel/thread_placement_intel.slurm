#!/bin/bash --login
#SBATCH --job-name=GE-thread_placement_intel
#SBATCH --partition=workq
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --export=NONE

# To compile on the Intel environment, swap from Cray to Intel
module swap PrgEnv-cray PrgEnv-intel

# leave in, it lists the environment loaded by the modules
module list

#  Note: SLURM_JOBID is a unique number for every job.
#  These are generic variables
EXECUTABLE=thread_placement_intel
SCRATCH=$MYSCRATCH/run_thread_placement_intel/$SLURM_JOBID
RESULTS=$MYGROUP/thread_placement_intel_results/$SLURM_JOBID

###############################################
# Creates a unique directory in the SCRATCH directory for this job to run in.
if [ ! -d $SCRATCH ]; then 
    mkdir -p $SCRATCH 
fi 
echo SCRATCH is $SCRATCH

###############################################
# Creates a unique directory in your GROUP directory for the results of this job
if [ ! -d $RESULTS ]; then 
    mkdir -p $RESULTS 
fi
echo the results directory is $RESULTS

################################################
# declare the name of the output file or log file
OUTPUT=thread_placement_intel.log

#############################################
#   Copy input files to $SCRATCH
#   then change directory to $SCRATCH

cp $EXECUTABLE $SCRATCH

cd $SCRATCH

export OMP_NUM_THREADS=2
export KMP=AFFINITY=disabled

aprun -n 24 -N 24 -d 2 -j 2 ./$EXECUTABLE >> ${OUTPUT}

#############################################
#    $OUTPUT file to the unique results dir
# note this can be a copy or move  
mv  $OUTPUT ${RESULTS}

cd $HOME

###########################
# Clean up $SCRATCH 

rm -r $SCRATCH

echo thread_placement_intel job finished at  `date`

# To swap from Intel environment to the default program environment:
module swap PrgEnv-intel PrgEnv-cray
