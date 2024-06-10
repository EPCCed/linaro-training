# MiniMD

## Building

First retrieve the source code

```bash
git clone https://github.com/Mantevo/miniMD
```

Then move into the miniMD directory and build the reference implementation.
This code is parallelized using OpenMP and MPI

### Cirrus


```bash
module load openmpi/4.1.6
module load gcc
cd miniMD/ref
make -f Makefile.default
```

### Archer2

```bash
module load PrgEnv-gnu
cd miniMD/ref
DEBUG=yes make -f Makefile.default
```






## DDT -- Explore the code

1) Find the function which is computing the forces between the atoms.
2) Set a breakpoint , so you can easily stop at that function again.
3) Is the force loop vectorized ? You can check by looking at the assembly code and looking for vector instructions ( variants of `vadd`, `vmul` etc..)
4) Trace the value of the virial energy. Estimate within which range the variable is changing and how much.
4) Find the regions were memory is allocated. How much memory is being allocated . How does this change with the number of atoms ?

Tips:
    - If you observe funny behaviour in DDT, try to disable optimization. Optimizations can sometimes confuse the debugger.


## MAP ----- Performance profiling

Try to use `map` to profile the application using MPI+OpenMP decomposition. 
Some example scripts for Cirrus and Archer2 are present in the folder.

1) What are the bottlenecks ?
2) Where is the communication happening ?
3) Are the most time-consuming loops vectorized ? If not, why ?
3) Experiment with changing the number of MPI ranks and OpenMP tasks, while keeping the product of the number of MPI tasks and OpenMP threads constant. Do you see a difference in the profile ?