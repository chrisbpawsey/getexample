#!/bin/bash -l
#SBATCH --job-name=GE-task_placement_gnu
#SBATCH --partition=workq
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --export=NONE

# to compile on GNU environment, swap from Cray to GNU
module swap PrgEnv-cray PrgEnv-gnu

# leave in, it lists the environment loaded by the modules
module list

#  Note: SLURM_JOBID is a unique number for every job.
#  These are generic variables
EXECUTABLE=task_placement_gnu
SCRATCH=$MYSCRATCH/run_task_placement_gnu/$SLURM_JOBID
RESULTS=$MYGROUP/task_placement_gnu_results/$SLURM_JOBID

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
OUTPUT=task_placement_gnu.log

#############################################
#   Copy input files to $SCRATCH
#   then change directory to $SCRATCH

cp $EXECUTABLE $SCRATCH

cd $SCRATCH

aprun -n 48 -N 48 -j 2 ./$EXECUTABLE >> ${OUTPUT}

#############################################
#    $OUTPUT file to the unique results dir
# note this can be a copy or move  
mv  $OUTPUT ${RESULTS}

cd $HOME

###########################
# Clean up $SCRATCH 

rm -r $SCRATCH

echo task_placement_gnu job finished at  `date`

# To swap from GNU environment to the default program environment:
module swap PrgEnv-gnu PrgEnv-cray

