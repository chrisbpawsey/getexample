#!/bin/bash --login
# This is the README file is an executable script.
# To run type: ./README.gnu
#
# Example OBJECTIVE: to demonstrate hello_mpi.c example on Magnus
# with GNU Environment.
# hello_mpi.c code is taken from
# https://www.dartmouth.edu/~rc/classes/intro_mpi/hello_world_ex.html
# hello_mpi.c is an MPI code that runs on 2 nodes 
# with 24 MPI tasks on each node.
# To run this code, we need to specify the total number of MPI tasks
# and the number of MPI tasks per node.
# We also need to change the compiler from Cray to GNU
# to be able to run this code with GNU Environment.
# This information is located under hello_mpi_gnu.slurm
# You can edit the SLURM as: emacs hello_mpi_gnu.slurm &

# SLURM directives
# 
# Here we specify to SLURM we want 2 nodes (--nodes=2)
# To compile hello_mpi.c with GNU, we change the compiler
# from Cray to GNU as shown below:
# module swap PrgEnv-gnu
# To launch a job, we specify to aprun 48 MPI tasks (-n 48)
# with 24 tasks per node (-N 24)
# Therefore, the aprun command looks like:
# aprun -n 48 -N 24 ./$EXECUTABLE >> ${OUTPUT}

# To compile the hello_mpi.c code with GNU
cc -O2 hello_mpi.c -o hello_mpi_gnu

# To submit the job to Magnus
sbatch hello_mpi_gnu.slurm

echo "The sbatch command returns what jobid is for this job."
echo "To check the status of your job, use the slurm command:"
echo "squeue -u $USER"
echo "Your job is deleted from the scratch."
echo "It is now moved to your group."
echo "Your results are now located in ${MYGROUP}/hello_mpi_c_results/"
echo "To change to your jobID directory, type:"
echo "cd ${MYGROUP}/hello_mpi_c_results/jobID/"
echo "To view the results, use the cat command and type:"
echo "cat hello_mpi_gnu.log"