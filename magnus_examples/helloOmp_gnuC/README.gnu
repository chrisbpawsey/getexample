#!/bin/bash
# This is the README file that is an executable script to demonstrate
# omp_hello.c example on Magnus.
# This file runs on gnu
# omp_hello.c is taken from https://computing.llnl.gov/tutorials/openMP/exercise.html
# To run this code, specify the total number of processes per node
# and the number of processes per node.
# This runs 1 process with 24 OMP threads
# This information is located under hello_omp_gnu_c.slurm
# You can edit the SLURM as: emacs hello_omp_gnu_c.slurm

# SLURM directives
# 
# Here we specify to SLURM we want 2 tasks (--ntasks=2)
# Replace the account name with your account name (--account=interns2016)
# To launch a job, we specify to srun we want 24 cpus-per-task (cpus-per-task= 24)

# To compile the omp_hello.c code

cc -O2 -h omp omp_hello.c -o hello_omp_gnu

# To submit the job to Magnus

sbatch hello_omp_gnu_c.slurm

# To view when the job starts

squeue -u $USER

echo "Your jobID is returned with the sbatch command."
echo "Your job is deleted from the scratch."
echo "It is now moved to your group."
echo "Your results are now located in /${MYGROUP}/hello_omp_gnu_results/"
echo "To change to your jobID directory, type:"
echo "cd /${MYGROUP}/hello_omp_gnu_results/jobID/"
echo "To view the results, use the cat command and type:"
echo "cat hello_omp_gnu.log"