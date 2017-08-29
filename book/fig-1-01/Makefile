FC = pgfortran
FCFLAGS  = -c 
PGIFLAGS = -acc -ta=tesla:cuda8.0,cc35
ACCFLAGS = -Minfo=accel # -Mcuda -Mprof=ccff

CPU = run-cpu.exe
GPU = run-gpu.exe

all: $(CPU) $(GPU) run

run: 
	@echo
	@echo "Running on CPU: " $(ACC_DEVICE_TYPE); ./$(CPU)
	@echo
	@echo "Running on GPU: " $(ACC_DEVICE_TYPE); ./$(GPU) 
	@echo

$(CPU): src-cpu.o
	$(FC) -o $(CPU) src-cpu.o

$(GPU): src-gpu.o
	$(FC) $(PGIFLAGS) -o $(GPU) src.f90 $(ACCFLAGS) 

src-gpu.o: src.f90
	$(FC) $(FCFLAGS) src.f90 -o src-gpu.o

src-cpu.o: src.f90
	$(FC) $(FCFLAGS) src.f90 -o src-cpu.o

clean:
	rm -f *~ *.o *.mod *.exe
