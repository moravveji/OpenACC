
FC       = pgfortran
FCFLAGS  = -c
ACCFLAGS = -acc -ta=tesla:cuda8.0,cc35
PGIFLAGS = -Minfo=accel

OBJS     = io.o vars.o kern.o main.o
EXE      = drv_types.exe

all: compile run

compile: $(EXE)

$(EXE): $(OBJS)
	$(FC) $(PGIFLAGS) -o $(EXE) $(OBJS) $(ACCFLAGS)

%.o: %.f90
	$(FC) $(FCFLAGS) -o $@ $<

run:
	@echo 
	./drv_types.exe
	@echo

clean:
	rm -f *.mod *.o *~ *.exe
