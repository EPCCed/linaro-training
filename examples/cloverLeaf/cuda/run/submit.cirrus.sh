#!/bin/bash

#SBATCH --job-name=cloverLead_cuda
#SBATCH --time=0:20:0
#SBATCH --nodes=1
#SBATCH --partition=gpu
#SBATCH --qos=short
#SBATCH --exclusive
#SBATCH --account=z04
#SBATCH --gres=gpu:1

module load nvidia/nvhpc-nompi/24.5
module load openmpi/4.1.6-cuda-11.8-nvfortran


# name of the executable
EXE=clover_leaf

# name of the root package
PACKAGE_ROOT="../CloverLeaf_CUDA"

# input file
ARGS=""

export PATH=${PACKAGE_ROOT}:$PATH


export OMP_NUM_THREADS=1

srun --ntasks=1 --distribution=block:block --hint=nomultithread $EXE $ARGS
