#!/bin/bash

# Slurm job options (job-name, compute nodes, job time)
#SBATCH --job-name=miniMD
#SBATCH --time=0:20:0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=16
#SBATCH --partition=standard
#SBATCH --qos=short
#SBATCH --exclusive
#SBATCH --account=z04



module load openmpi/4.1.6
module load gcc

export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

# name of the executable
EXE=miniMD

# name of the root package
PACKAGE_ROOT="../miniMD/ref"

# input file
ARGS=" --num_threads 16  -i in.lj.miniMD"

export PATH=${PACKAGE_ROOT}:$PATH

export OMP_NUM_THREADS=16

srun --distribution=block:block --hint=nomultithread $EXE $ARGS