#!/bin/bash

# Slurm job options (job-name, compute nodes, job time)
#SBATCH --job-name=manybody
#SBATCH --time=0:20:0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

# Replace [budget code] below with your budget code (e.g. t01)
#SBATCH --account=z19
#SBATCH --partition=standard
#SBATCH --qos=short

module load PrgEnv-gnu
module use /work/y07/shared/archer2-lmod/utils/dev
module load forge/24.0

export OMP_NUM_THREADS=12
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

# Launch the parallel job
#   Using 512 MPI processes and 128 MPI processes per node
#   srun picks up the distribution from the sbatch options

map --openmp-threads=12 --profile --no-mpi   ./md
