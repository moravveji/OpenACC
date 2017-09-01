

program main

  use io
  use vars
  use kern

  implicit none
 
  integer :: ierr, k
  character :: cmnd
  type(gaussian2d) :: g

  ! Specify the Gaussian curve propertise
  g% nx = 100
  g% ny = 100
  g% sx = 0.1234
  g% sy = 0.0876
  g% x0 = 0.2345
  g% y0 = 0.6789
  allocate(g%x(g%nx), g%y(g%ny), g%curve(g%nx, g%ny), stat=ierr)
  if (ierr /= 0) stop 'Failed to allocate derived type allocatable arrays'
  ! let x and y arrays vary uniformly between 0 and 1
  g% x(1 : g% nx) = (/ (k/real(g% nx), k = 0, g% nx-1) /)
  g% y(1 : g% ny) = (/ (k/real(g% ny), k = 0, g% ny-1) /)

  ! copy the derived type from host to device
  call h2d(g)

  ! launch the kernel
  call gen_gauss2d(g)

  ! copy the useful results back to the host
  call d2h(g)

  ! write a coarse Gaussian to a file for plotting
  if (g% nx <= 100 .and. g% nx <= 100) then 
     call write_ascii(g%x, g%y, g%curve, 'gaussian2d.txt')
     cmnd = 'python plotter.py'
     call system('python plotter.py')
!     call execute_command_line(cmnd)
  endif

end program main 
