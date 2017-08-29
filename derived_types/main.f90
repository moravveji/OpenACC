

program main

  use vars
  use kern

  implicit none
 
  integer :: ierr
  type(gaussian2d) :: g

  ! Specify the Gaussian curve propertise
  g% nx = 1000
  g% ny = 1000
  g% sx = 1.2345
  g% sy = 0.8765
  allocate(g%x(g%nx), g%y(g%ny), g%curve(g%nx, g%ny), stat=ierr)
  if (ierr /= 0) stop 'Failed to allocate derived type allocatable arrays'

  ! copy the derived type from host to device
  call h2d(g)

  ! launch the kernel
  call gen_gauss2d(g)

  ! copy the useful results back to the host
  call d2h(g)

  print*, g%curve(1,1)

end program main 
