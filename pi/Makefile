all: exec

lib.o: lib.f90
	gfortran -c lib.f90

compute_pi.o: compute_pi.f90
	gfortran -c compute_pi.f90

exec: lib.o compute_pi.o
	gfortran - o lib.o compute_pi.o

clean:
	rm exec *.o *.mod
	