# Allocatable Arrays

## Purpose
This simple example computes a rotated two-dimensional (2D) Gaussian curve following the formula (https://en.wikipedia.org/wiki/Gaussian_function), as an example of moving data between host and device. This example can be basically extended to any other application where some basic arrays need to be copied to the device for a data-exhaustive computations and the results be copied back to the host. 

## Contents
- `Makefile` to build the example
- `main.f90` which is the basic caller
- `vars.f90` which defines the variables, allocates the allocatable arrays, and takes care of host-to-device (`h2d()`) and device-to-host (`d2h()`) data transfer using the `!$acc enter data` and `!$acc exit data` clauses. 
- `kern.f90` which 

## formula
this is $x$ and this is 

$$x = y $$

## Tips
+ It is possible to allocate an array declared as `allocatable` on the device. This means, the call to `alloc()` and `h2d()` functions in the `main` program are interchangeable.
+ The `exit data` clause does not `delete` the arrays, but rather does a `copyout` operation to move the data out of device to the host. 

![image](gaussian2d.png)
