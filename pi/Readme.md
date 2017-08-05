# Approximating pi

The pi can be computed from the inifinite series below, when the `N` goes to infinity. But, in practice, we have to choose a considerably large value of `N`.

[!equation](<img src="http://www.sciweavers.org/tex2img.php?eq=%5Cpi%20%3D%204%20%5Csum_%7Bk%3D0%7D%5E%7BN%7D%20%5Cfrac%7B%28-1%29%5Ek%7D%7B2k%2B1%7D.&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="\pi = 4 \sum_{k=0}^{N} \frac{(-1)^k}{2k+1}." width="140" height="53" />)

[img]http://www.sciweavers.org/tex2img.php?eq=%5Cpi%20%3D%204%20%5Csum_%7Bk%3D0%7D%5E%7BN%7D%20%5Cfrac%7B%28-1%29%5Ek%7D%7B2k%2B1%7D.&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0[/img]

## Building
To build the executable, you must use the `make` utility. The plan is to compare the performance of the same block of code by changing between the GNU and PGI compilers, and whether or offloading the workload on the GPU. It is also possible to play around with the parallel directives (`kernels` versus `parallel loop`). The performance will be tabulated below.

For the build procedure and execution, you may follow these simple steps
```bash
git clone git@github.com:moravveji/OpenACC.git
cd pi
make pgi
./run.exe
```

## Result Highlights
I tried using the GNU Forgran compiler `gfortran 5.4.0`, and the PGI Fortran compiler `pgfortran 17.4-0` to compile the program, and compare their performance on a single core. For `N=1 000 000` iterations, the `gfortran` outperforms the `pgfortran` by roughly 70%. In this experiment, no specific optimization flag are directed to the compiler (i.e. we just use `-c` to compile as bare-bone). Explicitly speaking, the results of `time`ing the executable are the following

Machine | OS | Compiler | N cores | time (sec)
--- | --- | --- | --- | ---
Home Desktop | Ubuntu 16.04 | gfortran 5.0.4 | 1 CPU | 0.10
Home Desktop | Ubuntu 16.04 | pgfortran 17.4-0 | 1 CPU | 0.17
HPC Cluster  | Red Hat Enterprise 6.5 | gfortran 6.3.0 | 1 CPU |  0.05
HPC Cluster  | Red Hat Enterprise 6.5 | pgfortran 14.1-0 | 1 CPU | 0.05