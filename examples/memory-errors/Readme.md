# Debugging a sloppy code

This folder contains a simple copy summing two vector a and b. 
The code is parallelized with OpenMP and MPI . However the implementation is very poor, with several runtime errors in the code. Try to use DDT to find the errors and get a correct solution. Look out for possible deadlocks, memory corruptions and memory leaks. The code is written in C++.
## Running Forge

For instructions on how to get started with Forge see https://docs.archer2.ac.uk/data-tools/forge/#one-time-set-up-for-using-forge .
If using offline analysis , check `ddt --help` for a list of possible command options.

## Build 
The code is meant to be build with the GNU compiler.

### Cirrus

```bash
module load openmpi
cd memory-errors
CXX=mpicxx make
```

### Archer2

```bash
module load PrgEnv-gnu
cd memory-errors
CXX=CC make
```

### Running

Examples scripts are provided with the code. For instance, for a vanilla run just type 

```bash
sbatch submit.archer2.sh
```