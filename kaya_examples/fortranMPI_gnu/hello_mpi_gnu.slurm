#!/bin/bash -l
#SBATCH --job-name=GE-fortranMPI_gnu
#SBATCH --partition=POPHEALTH
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --export=NONE

# To swap from Cray Environment to GNU
module load gcc opempi

# leave in, it lists the environment loaded by the modules
module list

#  Note: SLURM_JOBID is a unique number for every job.
#  These are generic variables
EXECUTABLE=hello_mpi_gnu
SCRATCH=/scratch/$USER/run_fortranMPI_gnu/$SLURM_JOBID
RESULTS=$HOME/mpifortran_gnu_results/$SLURM_JOBID

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
OUTPUT=fortranMPI_gnu.log

#############################################
#   Copy input files to $SCRATCH
#   then change directory to $SCRATCH

cp $EXECUTABLE $SCRATCH

cd $SCRATCH

srun -n 8 ./$EXECUTABLE >> ${OUTPUT}

#############################################
#    $OUTPUT file to the unique results dir
# note this can be a copy or move  
mv  $OUTPUT ${RESULTS}

cd $HOME

###########################
# Clean up $SCRATCH 

rm -r $SCRATCH

echo fortranMPI_gnu job finished at  `date`

