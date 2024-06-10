#!/bin/bash

# Slurm job options (job-name, compute nodes, job time)
#SBATCH --job-name=miniMD
#SBATCH --time=0:20:0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=36
#SBATCH --cpus-per-task=1
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
ARGS="-i ../miniMD/ref/in.lj.miniMD"

module load forge/24.0

module load openmpi/4.1.6
module load gcc

export PATH=${PACKAGE_ROOT}:$PATH
export FORGE_SAMPLER_INTERVAL=1
export FORGE_SAMPLER_INTERVAL_PER_THREAD=1

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

ARGS=" --num_threads $OMP_NUM_THREADS  -i in.lj.miniMD"

map -n 2 --openmp-threads=$OMP_NUM_THREADS --profile --mpi=slurm --mpiargs="--hint=nomultithread --distribution=block:block" $EXE $ARGS