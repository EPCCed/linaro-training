# Clover Leaf ( CUDA )

## Build
Load the environment 

```bash
module load nvidia/nvhpc-nompi/24.5
module load openmpi/4.1.6-cuda-12.4-nvfortran
export LIBRARY_PATH=/work/y07/shared/cirrus-software/nvidia/hpcsdk-24.5/Linux_x86_64/24.5/cuda/12.4/targets/x86_64-linux/lib/:$LIBRARY_PATH
```

Get the code and build
```bash
git clone https://github.com/UK-MAC/CloverLeaf_CUDA
cd CloverLeaf_CUDA
cp ../Makefile .
DEBUGOPT=1 make NV_ARCH=VOLTA -j 8
```

## Run
An example submission script is present in the run folder for cirrus.

```bash
sbatch submit.sh
```

You can run an interactive session on a gpu node with
```bash
srun --time=00:05:00 --partition=gpu --qos=short --account=z04 --gres gpu:1 --pty /usr/bin/bash -
-login
```


## Analyze the performance

-   What  is the fraction of time spent in computing ?
- When are memory transfers done and where ? Is this affecting the performance of the code ?
- Which kernels take more time ? 
- How does the profile change as you change the grid size ? Are you limited by computation or memory bandwidth ?