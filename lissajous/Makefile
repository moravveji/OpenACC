
FC       = pgfortran
FCFLAGS  = -c 
PGIFLAGS = #-acc -ta=tesla:cuda8.0,cc35,llvm
ACCFLAGS = #-Minfo=all,accel 

OBJS     = vars.o io.o kern.o main.o
EXE      = lissajous.exe

all: compile run

compile: $(EXE)

$(EXE): $(OBJS)
	$(FC) $(PGIFLAGS) -o $(EXE) $(OBJS) $(ACCFLAGS)

%.o: %.f90
	$(FC) $(FCFLAGS) $(PGIFLAGS) $(ACCFLAGS) -o $@ $<

run:
	@echo 
	./${EXE}
	@echo

clean:
	rm -f *.mod *.o *~ ${EXE} data/*
