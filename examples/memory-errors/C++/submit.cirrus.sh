#!/bin/bash

# Slurm job options (job-name, compute nodes, job time)
#SBATCH --job-name=memory_errors_test
#SBATCH --time=0:5:0
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=18
#SBATCH --account=z04
#SBATCH --partition=standard
#SBATCH --qos=short
#SBATCH --exclusive

export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

# Set the number of threads to 16 and specify placement
#   There are 16 OpenMP threads per MPI process
#   We want one thread per physical core
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK


srun --hint=nomultithread --distribution=block:block ./test 