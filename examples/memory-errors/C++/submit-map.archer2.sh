#!/bin/bash

# Slurm job options (job-name, compute nodes, job time)
#SBATCH --job-name=lammps_test
#SBATCH --time=0:20:0
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=16

# Replace [budget code] below with your budget code (e.g. t01)
#SBATCH --account=z19
#SBATCH --partition=standard
#SBATCH --qos=short

module use /work/y07/shared/archer2-lmod/utils/dev
module load forge/24.0

export OMP_NUM_THREADS=16
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

map -n 8 --openmp-threads=16 --profile --mpi=slurm --mpiargs="--hint=nomultithread --distribution=block:block" ./test
