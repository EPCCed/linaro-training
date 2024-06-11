# Linaro Training

This repository contains the material for EPCC's linaro training course 11/01/24.

Instructions to use forge specifically on Archer2 are available at [https://docs.archer2.ac.uk/data-tools/forge/](https://docs.archer2.ac.uk/data-tools/forge/). 
We will use the latest version of forge. 
On archer2 this can loaded with 

```bash
module use /work/y07/shared/archer2-lmod/utils/dev
module load forge/24.0
```
On Cirrus instead simply use 

```bash
module load forge/24.0
```


- `slides`: Contains the slides presented during the day
- `examples`: Contains the hands-on exercises

## Schedule ( approximate )

| Time | Topic |
------ | ---- |
09.30 - 10.15 |  DDT (debugging)
10.15 - 11:00 | Hands on (includes connecting, setting up etc... )
11.00 - 11.15 | Coffee/tea break 
11.15 - 12.00 |  MAP (profiling)
12.00 - 12.30 | Hands on 
12.30 - 13.30 | Lunch
13.30 - 14:15 | Debugging and profiling on GPU
14:15 - 14:40 | Hands on 
14:40 - 15:00 | Coffee/tea break; moving to separate meeting rooms (2.55, 2.56, 1.35) 
15:00 - 17:00 | Work on own code at separate meeting rooms (2.55, 2.56, 1.35)