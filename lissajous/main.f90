
program main
  
  use vars
  use kern

  implicit none

  integer, parameter :: npoints = 1000
  real, parameter :: tstart = 0, tend = 10
  real, dimension(:), allocatable :: times

  ! allocate the knot with a fixed number of points
  call alloc(npoints)

  times = get_times(tstart, tend, npoints)
  print *, times(1), times(npoints)

end program main 

