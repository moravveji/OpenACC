
program main
  
  use vars
  use kern

  implicit none

  integer, parameter :: nx =3, ny=5, nz=7, npoints = 1000
  real, parameter :: phix=0.1234, phiy=0.4567, phiz=0.7890
  real, parameter :: tstart = 0, tend = 10

  ! define the curve with a fixed number of points
  call def_curve(nx, ny, nz, npoints, &
                 phix, phiy, phiz, tstart, tend)

  ! Now, create one Lissajous curve
  call make_lissajous()

  print *, this%knot(10:12)%nz

end program main 

