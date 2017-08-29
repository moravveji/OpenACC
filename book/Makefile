FC = pgfortran
FCFLAGS  = -c 
PGIFLAGS = -ta=tesla,multicore
ACCFLAGS = -Mcuda #-Minfo=all,accel -Mprof=ccff

CPU = run-1-01-cpu.exe
GPU = run-1-01-gpu.exe

all: $(CPU) $(GPU) run

run: 
	@echo
	@echo "Running on CPU ..."; ./$(CPU)
	@echo
	@echo "Running on GPU ..."; ./$(GPU) 
	@echo


$(CPU): fig-1-01-cpu.o
	$(FC) -o $(CPU) fig-1-01-cpu.o

$(GPU): fig-1-01-gpu.o
	$(FC) -acc -o $(GPU) fig-1-01-gpu.o $(ACCFLAGS) 

fig-1-01-gpu.o: fig-1-01.f90
	$(FC) $(FCFLAGS) $(PGIFLAGS) fig-1-01.f90 -o fig-1-01-gpu.o

fig-1-01-cpu.o: fig-1-01.f90
	$(FC) $(FCFLAGS) fig-1-01.f90 -o fig-1-01-cpu.o

clean:
	rm -f *~ *.o *.mod *.exe
