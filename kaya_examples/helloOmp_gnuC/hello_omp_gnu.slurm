#!/bin/bash --login
#SBATCH --job-name=GE-helloOmp_gnuC
#SBATCH --partition=POPHEALTH
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --export=NONE

# to compile with GNU, swap from Cray environment to GNU
module swap gcc

# leave in, it lists the environment loaded by the modules
module list

#  Note: SLURM_JOBID is a unique number for every job.
#  These are generic variables
EXECUTABLE=hello_omp_gnu
SCRATCH=/home/$USER/run_helloOmp_gnuC/$SLURM_JOBID
RESULTS=$HOME/helloomp_c_gnu_results/$SLURM_JOBID

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
OUTPUT=helloOmp_gnuC.log

#############################################
#   Copy input files to $SCRATCH
#   then change directory to $SCRATCH

cp $EXECUTABLE $SCRATCH

cd $SCRATCH

export OMP_NUM_THREADS=24
./$EXECUTABLE >> ${OUTPUT}

#############################################
#    $OUTPUT file to the unique results dir
# note this can be a copy or move  
mv  $OUTPUT ${RESULTS}

cd $HOME

###########################
# Clean up $SCRATCH 

rm -r $SCRATCH

echo helloOmp_gnuC job finished at  `date`


# To swap from GNU environment to the default program environment:
module swap PrgEnv-gnu PrgEnv-cray
