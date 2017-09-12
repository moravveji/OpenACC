

program main
  
  use io
  use vars
  use kern
  use openacc

  implicit none
 
  character(len=:), allocatable :: cmnd
  real, parameter :: xlo=-5, xhi=5, ylo=-5, yhi=5
  type(gaussian2d) :: g

  ! set the ACC device
  call acc_init(acc_device_nvidia)
  call acc_set_device_num(0, acc_device_nvidia)

  ! Specify the Gaussian curve propertise
  call alloc(a=g, &
             nx=101, ny=101, &
             sx=2.1234, sy=1.4567, &
             rho=0.2345, &
             x0=-0.3456, y0=0.7890)

  ! copy the derived type from host to device
  call h2d(g)

  ! set x and y arrays to range between the lower to higher range, inclusively
  call set_xy(a=g, xlo=xlo, xhi=xhi, ylo=ylo, yhi=yhi)

  ! launch the kernel
  call gen_gauss2d(g)

  ! copy the useful results back to the host
  call d2h(g)

  ! write a coarse Gaussian to a file for plotting
  if (g% nx <= 200 .and. g% nx <= 200) then 
     call write_ascii(g%x, g%y, g%curve, 'gaussian2d.txt')
     cmnd = 'python plotter.py'
     call system('python plotter.py')
  endif

print*, minval(g%x), minval(g%y), minval(g%curve)
print*, maxval(g%x), maxval(g%y), maxval(g%curve)

end program main 
