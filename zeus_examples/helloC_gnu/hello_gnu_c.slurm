#!/bin/bash --login
#SBATCH --job-name=GE-helloC_gnu
#SBATCH --partition=workq
#SBATCH --nodes=1
#SBATCH --time=00:05:00

# Default loaded compiler module is gcc module.
# To compile with the GNU compiler, load the gcc module in case.
module load gcc

# leave in, it lists the environment loaded by the modules
module list

#  Note: SLURM_JOBID is a unique number for every job.
#  These are generic variables
EXECUTABLE=helloworld_gnu
SCRATCH=$MYSCRATCH/run_helloC_gnu/$SLURM_JOBID
RESULTS=$MYGROUP/helloworld_gnu_results/$SLURM_JOBID

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
OUTPUT=helloC_gnu.log

#############################################
#   Copy input files to $SCRATCH
#   then change directory to $SCRATCH

cp $EXECUTABLE $SCRATCH

cd $SCRATCH

./$EXECUTABLE >> ${OUTPUT}

if [ $? -ne 0 ]; then
    cd
    OUTPUT2=magnus_results.log
    echo "$EXECUTABLE with jobID $SLURM_JOBID Failed" >> ${OUTPUT2}
else
    cd
    OUTPUT2=magnus_results.log
    echo "$EXECUTABLE with jobID $SLURM_JOBID Succeeded" >> ${OUTPUT2}
fi

cd $SCRATCH

#############################################
#    $OUTPUT file to the unique results dir
# note this can be a copy or move  
mv  $OUTPUT ${RESULTS}

cd $HOME

###########################
# Clean up $SCRATCH 

rm -r $SCRATCH

echo helloC_gnu job finished at  `date`



