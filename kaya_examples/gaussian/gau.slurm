#!/usr/bin/tcsh 
#SBATCH --job-name=GE-gaussian
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks=34
# max ntasks = 34
# note ntasks has to match %proc in your gaussian input file
#SBATCH --time=01:00:00   
#SBATCH --export=NONE

# To compile with the GNU environment, swap from Cray to GNU
module load pgi/16.10 gaussian/g16

# leave in, it lists the environment loaded by the modules
module list

#  Note: SLURM_JOBID is a unique number for every job.
#  These are generic variables

set INPUT = test0194
set SCRATCH = /tmp/$USER/run_gaussian/$SLURM_JOBID
setenv GAUSS_SCRDIR "$SCRATCH"
set RESULTS = $HOME/gaussian_results

###############################################
# Creates a unique directory in the SCRATCH directory for this job to run in.
if ( ! -d $SCRATCH ) then 
    mkdir -p $SCRATCH 
endif 
echo SCRATCH is $SCRATCH
echo GAUSS_SCRDIR is "${SCRATCH}"
###############################################
# Creates a unique directory in your GROUP directory for the results of this job
if ( ! -d $RESULTS ) then 
    mkdir -p $RESULTS 
endif 
echo the results directory is $RESULTS

################################################
# declare the name of the output file or log file
set OUTPUT = gau_${INPUT}.log

#############################################
#   Copy input files to $SCRATCH
#   then change directory to $SCRATCH

cp ${INPUT}.com $SCRATCH

cd $SCRATCH
 
ls -al
cd $SLURM_SUBMIT_DIR

g16 < ${INPUT}.com  > ${OUTPUT}

#############################################
#    $OUTPUT file to the unique results dir
# note this can be a copy or move  
mv  ${SCRATCH} ${RESULTS}

cd $HOME

###########################
# Clean up $SCRATCH 

rm -r $SCRATCH

echo gaussian job finished at  `date`


