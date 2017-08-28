FC = pgfortran
FCFLAGS  = -c -ta=tesla #,multicore
ACCFLAGS = -Minfo=all,accel,ccff -Mcuda

EXE = run-1-01.exe

all: $(EXE) run

run: ./$(EXE) # << $(shell (echo 1 2))

$(EXE): fig-1-01.o
	$(FC) -acc -o $(EXE) fig-1-01.o $(ACCFLAGS) 

fig-1-01.o: fig-1-01.f90
	$(FC) $(FCFLAGS) fig-1-01.f90

clean:
	rm -f *.o *.mod $(EXE) 
