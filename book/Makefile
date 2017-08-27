FC = pgfortran
FCFLAGS = -c
ACCFLAGS = -acc -fast -ta=multicore,tesla -Minfo=all,accel

EXE = run-1-01.exe

all: $(EXE) run

run: ./$(EXE) # << $(shell (echo 1 2))

$(EXE): fig-1-01.o
	$(FC) fig-1-01.o $(ACCFLAGS) -o $(EXE)

fig-1-01.o: fig-1-01.f90
	$(FC) $(FCFLAGS) fig-1-01.f90

clean:
	rm -f *.o *.mod $(EXE) 