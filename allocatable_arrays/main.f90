

program main
  
  use io
  use vars
  use kern

  implicit none
 
  character(len=:), allocatable :: cmnd
  real, parameter :: xlo=-5, xhi=5, ylo=-5, yhi=5

  ! set the ACC device
!  call acc_init(acc_device_nvidia)
!  call acc_set_device_num(0, acc_device_nvidia)

  nx = 101
  ny = 101
  sx = 0.5432
  sy = 1.2345
  x0 = -2.3456
  y0 = 1.7654
  rho= 0.35

  ! copy the derived type from host to device
!  call h2d()

  ! Specify the Gaussian curve propertise
  call alloc()

  ! set x and y arrays to range between the lower to higher range, inclusively
  call set_xy(xlo=xlo, xhi=xhi, ylo=ylo, yhi=yhi)
  print*, allocated(x), x(0), x(101)

  ! launch the kernel
  call gen_gauss2d()

  ! write a coarse Gaussian to a file for plotting
  if (nx <= 200 .and. nx <= 200) then 
     call write_ascii(x, y, curve, 'gaussian2d.txt')
     cmnd = 'python plotter.py'
     call system('python plotter.py')
  endif

print*, minval(x), minval(y), minval(curve)
print*, maxval(x), maxval(y), maxval(curve)

  ! copy the useful results back to the host
!  call d2h()

end program main 
