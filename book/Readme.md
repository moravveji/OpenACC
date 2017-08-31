# Parallel Programming with OpenACC Book Fortran Codes

## Purpose
This directory provides the Fortran 90 equivalent of the C++ codes given in the **Parallel Programming with OpenACC** book by Rob Farber, Elsevier, 2017 (https://www.elsevier.com/books/parallel-programming-with-openacc/farber/978-0-12-410397-9).

## Device and Environment Requirements
For the development and testing, I have used a Kepler K40c (and sometimes K20Xm depending on the availability) NVIDIA GPU on a Westmere compute node. To compile and test each of the examples, the following environment variables and compilers are used

```bash
source switch_to_2015a
module load foss
module load K40c/2015a
#module load K20Xm/2015a
module load git/2.13.4-GCC-4.9.2
module load PGI/17.4

export ACC_DEVICE_TYPE=nvidia
#export PGI_ACC_NOTIFY=1
#export PGI_ACC_TIME=1
```
