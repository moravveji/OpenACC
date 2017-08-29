
FC       = pgfortran
FCFLAGS  = -c
ACCFLAGS = -acc -ta=tesla:cuda8.0,cc35
PGIFLAGS = -Minfo=accel

OBJS     = vars.o kern.o main.o
EXE      = drv_types.exe

all: $(EXE) run

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
