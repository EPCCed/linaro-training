#!/bin/bash

# Slurm job options (job-name, compute nodes, job time)
#SBATCH --job-name=out_of_bound_test
#SBATCH --time=0:2:0
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=16
#SBATCH --account=z19
#SBATCH --partition=standard
#SBATCH --qos=short

export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

# Set the number of threads to 16 and specify placement
#   There are 16 OpenMP threads per MPI process
#   We want one thread per physical core
export OMP_NUM_THREADS=16

srun --hint=nomultithread --distribution=block:block ./test

