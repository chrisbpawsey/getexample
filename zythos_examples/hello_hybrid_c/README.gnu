#!/bin/bash --login
# This is the README file is an executable script.
# To run type: ./README.gnu
#
# Example OBjECTIVE: to demostrate hybrid_hello.c example
# on Zythos with GNU Compiler.This is a mixed-mode job
# which includes both MPI and OpenMP jobs.
# hybrid_hello.c code is taken from
# http://www.slac.stanford.edu/comp/unix/farm/mpi_and_openmp.html
# To run this code, we need to edit the partition, 
# load the necessary modules,
# specify the total number of nodes, cores per node and
# the number of OpenMP threads.
# This information is located under hello_hybrid_gnu.slurm
# You can edit the SLURM as: emacs hello_hybrid_gnu.slurm &

# SLURM directives
# 
# Here specify to SLURM that we want 4 nodes (--ntasks=4)
# We the modify the partition to --partition==zythos
# We then specify the number of cores for the NUMA region. (--cpus-per-task=6)
# To run this code correctly on Zeus, we need to remove --export=NONE
# If it is still included in the SLURM, the code does not compile.
# To compile with GNU compiler, we need to load 
# the gcc compiler as shown below:
# module load gcc
# Then, we load the necessary modules before module listing.
# module load intel
# module load mpt
# We also set the number of threads to 6 as shown below: 
# export OMP_NUM_THREADS=6
# Therefore, the mpirun command looks like:
# mpirun -np 4 omplace -nt $OMP_NUM_THREADS ./$EXECUTABLE >> ${OUTPUT}
 
# To compile the hybrid_hello.c code with GNU compiler
mpicc -fopenmp hybrid_hello.c -o hello_hybrid_gnu

# To submit the job to Zeus
sbatch hello_hybrid_gnu.slurm

echo "The sbatch command returns what jobid is for this job."
echo "To check the status of your job, use the slurm command:"
echo "squeue -u $USER"
echo "Your job is deleted from the scratch."
echo "It is now moved to your group."
echo "Your results are now located in ${MYGROUP}/hello_results_hybrid_zythos/"
echo "To change to your jobID directory, type:"
echo "cd ${MYGROUP}/hello_results_hybrid_zythos/jobID/"
echo "To view the results, use the cat command and type:"
echo "cat hello_hybrid_gnu.log"