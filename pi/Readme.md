# Approximating pi

The pi can be computed from the inifinite series below, when the `N` goes to infinity. But, in practice, we have to choose a considerably large value of `N`.
![equation](<img src="http://www.sciweavers.org/tex2img.php?eq=%5Cpi%20%3D%204%20%5Csum_%7Bk%3D0%7D%5E%7BN%7D%20%5Cfrac%7B%28-1%29%5Ek%7D%7B2k%2B1%7D.&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="\pi = 4 \sum_{k=0}^{N} \frac{(-1)^k}{2k+1}." width="140" height="53" />)

## Result Highlights
I tried using the GNU Forgran compiler `gfortran 5.4.0`, and the PGI Fortran compiler `pgfortran 17.4-0` to compile the program, and compare their performance on a single core. For `N=1 000 000` iterations, the `gfortran` outperforms the `pgfortran` by roughly 70%. Explicitly speaking, the results of `time`ing the executable are the following
+ gfortran:  0.097 sec
+ pgfortran: 0.170 sec

