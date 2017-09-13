
# OpenACC Experiments

## About
This repository is intended to host several examples of accelerating code using OpenACC with NVIDIA GPUs. The examples are very simplistic, and are provided only as a proof-of-concept for various features. Therefore, the examples serve as basic guidelines on how to properly benefit from such OpenACC features. The table below provides the list of available examples (subdirectories) with the targeted intention. The order more and less reflects going from simple/easy material to intermediate-level concepts.

Example | Use Case | Purpose
-- | --- | ---
[Allocatable Arrays](https://github.com/moravveji/OpenACC/tree/master/allocatable_arrays) | 2D Gaussian Curve | Host/Device data transfer for allocatable arrays 
[Derived Types](https://github.com/moravveji/OpenACC/tree/master/derived_types) | 2D Gaussian Curve | Host/Device data transfer for allocatable arrays within derived types
[Lissajous](https://github.com/moravveji/OpenACC/tree/master/lissajous) | Lissajous 3D Knots | Asynchronous device task management
[pi](https://github.com/moravveji/OpenACC/tree/master/pi) | Different Ways to Compute pi | Basic Practice
[OpenACC Book](https://github.com/moravveji/OpenACC/tree/master/book) | | Fortran version of examples in [OpenACC Book](https://www.elsevier.com/books/parallel-programming-with-openacc/farber/978-0-12-410397-9)

## Requirements
+ Fortran 90
+ PGI compiler
+ Accelerator (GPU or Xeon Phi)
