#!/bin/bash --login
# This is the README file is an executable script.
# To run type: ./README.gnu
#
# Example OBjECTIVE: to demostrate hello_cuda.cu example
# on Zythos with GNU compiler. 
# This example is taken from:
# https://www.pdc.kth.se/resources/computers/historical-computers/zorn/how-to/how-to-compile-and-run-a-simple-cuda-hello-world
# hello_cuda.cu is a CUDA code requiring a single GPU node.
# To run this code, we need to change the partition, 
# specify the number of nodes, cores and the GPU constraint.
# and load the necessary modules.
# This information is located under hello_cuda_gnu.slurm
# You can edit the SLURM as: emacs hello_cuda_gnu.slurm &

# SLURM directives
# 
# Here we change the partition to --partition==zythos
# Then, we specify to SLURM we want 1 node (--ntasks=1)
# with 6 cores (--cpus-per-task=6)
# We also specify to SLURM a single GPU node (--gres=gpu:1)
# To run this code correctly, we need to remove --export=NONE
# If it is included in the SLURM, the code does not run properly.
# We also need to load the necessary modules 
# before module listing as shown below:
# module load cuda

# To compile the hello_cuda.cu code with GNU compiler
nvcc hello_cuda.cu -o hello_cuda_gnu

# To submit the job to Zeus
sbatch hello_cuda_gnu.slurm

echo "The sbatch command returns what jobid is for this job."
echo "To check the status of your job, use the slurm command:"
echo "squeue -u $USER"
echo "Your job is deleted from the scratch."
echo "It is now moved to your group."
echo "Your results are now located in ${MYGROUP}/hello_gpu_results_zythos/"
echo "To change to your jobID directory, type:"
echo "cd ${MYGROUP}/hello_gpu_results_zythos/jobID/"
echo "To view the results, use the cat command and type:"
echo "cat hello_cuda_gnu.log"