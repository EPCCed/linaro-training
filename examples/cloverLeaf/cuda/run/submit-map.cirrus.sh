#!/bin/bash

#SBATCH --job-name=cloverLead_cuda
#SBATCH --time=0:20:0
#SBATCH --nodes=1
#SBATCH --partition=gpu
#SBATCH --qos=short
#SBATCH --exclusive
#SBATCH --gres=gpu:1

module load nvidia/nvhpc-nompi/24.5
module load openmpi/4.1.6-cuda-12.4-nvfortran
module load forge/24.0

# name of the executable
EXE=clover_leaf

# name of the root package
PACKAGE_ROOT="../CloverLeaf_CUDA"

# input file
ARGS=""

export PATH=${PACKAGE_ROOT}:$PATH

export OMP_NUM_THREADS=1

map --cuda-kernel-analysis --cuda-transfer-analysis  -n 1 --profile --mpi=slurm --mpiargs="--hint=nomultithread --distribution=block:block" $EXE $ARGS
