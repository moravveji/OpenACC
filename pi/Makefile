
# gfortran or pgfortran
FC = pgfortran 

GCCFLAGS = -c
PGIFLAGS = -c -fast -Mvect -Minfo=all,ccff -ta=tesla:keep,analysis,CUDA8.0

ifeq ($(FC), 'gfortran')
  FCFLAGS=$(GCCFLAGS)
else 
#  FCFLAGS = -c 
#  FCFLAGS = -c -fast -Mvect -Minfo=all,ccff
  FCFLAGS=$(PGIFLAGS)
endif  

exe = run.exe

OBJECTS = precision.o lib.o compute_pi.o


all: $(exe)

precision.o: precision.f90
	$(FC) $(FCFLAGS) precision.f90

lib.o: lib.f90
	$(FC) $(FCFLAGS) lib.f90

compute_pi.o: compute_pi.f90
	$(FC) $(FCFLAGS) compute_pi.f90

$(exe): $(OBJECTS)
	$(FC) -o $(exe) $(OBJECTS)
clean:
	rm -rf $(exe) *.o *.mod
