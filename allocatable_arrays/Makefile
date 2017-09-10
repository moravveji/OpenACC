
FC       = pgfortran
FCFLAGS  = -c 
PGIFLAGS = -acc -ta=tesla:cuda8.0,cc35,llvm
ACCFLAGS = -Minfo=all,accel 

OBJS     = io.o vars.o kern.o main.o
EXE      = drv_types.exe

all: compile run

compile: $(EXE)

$(EXE): $(OBJS)
	$(FC) $(PGIFLAGS) -o $(EXE) $(OBJS) $(ACCFLAGS)

%.o: %.f90
	$(FC) $(FCFLAGS) $(PGIFLAGS) $(ACCFLAGS) -o $@ $<

run:
	@echo 
	./drv_types.exe
	@echo

clean:
	rm -f *.mod *.o *~ *.exe
