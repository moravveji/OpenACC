
program main
  
  use vars
  use kern

  implicit none

  integer, parameter :: nx=3, ny=5, nz=7, npoints = 1000
  real, parameter :: phix=0.1234, phiy=0.4567, phiz=0.7890
  type(curve), target, save :: this

  integer :: i_curve
  integer, parameter :: num_curves = 1
  type(curve), dimension(num_curves) :: curves

  do i_curve = 1, num_curves

    ! define the curve with a fixed number of points
    call def_curve(this, nx, ny, nz, npoints, &
                   phix, phiy, phiz)

    ! Now, create one Lissajous curve
    call make_lissajous(this)

    ! store the curve as an element of curves
    curves(i_curve) = this

  enddo

  print *, curves(1)% knot(1)% nz == nz
!  print *, this%times(1), this%times(npoints)

end program main 

