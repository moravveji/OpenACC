
# compile by specifying the Fortran compiler name, e.g.
# $> make FC=gfortran
# or 
# $> make FC=pgfortran

GCCFLAGS = -c
PGIFLAGS = -c -fast -acc -Mvect -Minfo=all,ccff -ta=tesla #:keep,analysis #,CUDA8.0

OBJECTS  = precision.o lib.o compute_pi.o
exe      = run.exe

all: 
	@echo 
	@echo "Error: type either   make gnu   or   make pgi"
	@echo

gnu: FC_GNU compile
pgi: FC_PGI compile

ifeq ($(MAKECMDGOALS),gnu)
  FC_GNU:
    FC = gfortran
    FCFLAGS=$(GCCFLAGS)
endif

ifeq ($(MAKECMDGOALS),pgi)
  FC_PGI:
    FC = pgfortran
    FCFLAGS = $(PGIFLAGS)
endif

compile: $(exe)

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
