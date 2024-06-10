#!/bin/bash

# Slurm job options (job-name, compute nodes, job time)
#SBATCH --job-name=out_of_bound_test
#SBATCH --time=0:5:0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --account=z19
#SBATCH --partition=standard
#SBATCH --qos=short

export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

# Set the number of threads to 16 and specify placement
#   There are 16 OpenMP threads per MPI process
#   We want one thread per physical core
export OMP_NUM_THREADS=1
module use /work/y07/shared/archer2-lmod/utils/dev
module load forge/24

ddt --mem-debug -o memory_errors.html --offline --break-at=out-of-bound.cpp:73 srun --hint=nomultithread --distribution=block:block ./test
