# Fortran Derived Types

## Purpose
This small project tries to exploit using Fortran 90 derived types, with allocatable arrays. The purpose is to manage the data transfer between the host and device through using the `!$acc enter data` and `!$acc exit data` clauses. The derived types contains necessary information for a 2-dimensional Gaussian curve (hence various namings).

## Content
+ `vars.f90` module where the derived type and the data movement subroutines are defined
+ `kern.f90` module which contains the kernel for filling up the 2D Gaussian curve
+ `main.f90` program file which `use`s the other two modules, moves the data around, and launches the kernel.
