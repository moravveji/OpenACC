
# compile by specifying the Fortran compiler name, e.g.
# $> make gnu
# or 
# $> make pgi 

GNUFLAGS = -c
PGIFLAGS = -c -g -fast -acc -ta=nvidia 
LIBS     = -Minfo=all,accel,ccff -Mpreprocess -Mcuda -Mcudalib=curand

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
    FCFLAGS=$(GNUFLAGS)
endif

ifeq ($(MAKECMDGOALS),pgi)
  FC_PGI:
    FC = pgfortran
    FCFLAGS = $(PGIFLAGS)
endif

WHICH_FC = $(bash which $(FC))
DIR_FC   = $(bash basename $(WHICH_FC))
DIR_LIBS = $(bash echo $(DIR_FC))/../lib

compile: $(exe)

precision.o: precision.f90
	$(FC) $(FCFLAGS) precision.f90

lib.o: lib.f90
	$(FC) $(FCFLAGS) lib.f90

compute_pi.o: compute_pi.f90
	$(FC) $(FCFLAGS) compute_pi.f90

$(exe): $(OBJECTS)
	$(FC) -acc -o $(exe) $(OBJECTS) $(LIBS)

clean:
	rm -rf $(exe) *.o *.mod *.gpu
