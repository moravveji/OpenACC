

program main

  use vars
  use kern

  implicit none

  ! copy the derived type from host to device
  call h2d(g)

  ! launch the kernel
  call gen_gauss2d(g)

  ! copy the useful results back to the host
  call d2h(g)

end program main 
