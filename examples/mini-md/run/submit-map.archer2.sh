#!/bin/bash

# Slurm job options (job-name, compute nodes, job time)
#SBATCH --job-name=miniMD
#SBATCH --time=0:05:0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=16
#SBATCH --partition=standard
#SBATCH --qos=short
#SBATCH --exclusive

module use /work/y07/shared/archer2-lmod/utils/dev
module load forge/24.0


module load PrgEnv-gnu

export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

# name of the executable
EXE=miniMD

# name of the root package
PACKAGE_ROOT="../miniMD/ref"

# input file
ARGS=" --num_threads 16  -i in.lj.miniMD"

export PATH=${PACKAGE_ROOT}:$PATH
export OMP_NUM_THREADS=16

map -n 8 --openmp-threads=$OMP_NUM_THREADS --profile --mpi=slurm --mpiargs="--hint=nomultithread --distribution=block:block" $EXE $ARGS