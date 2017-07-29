
program compute_pi
  
  use precision
  use lib, only: pi_Gregory_Leibniz 

  implicit none

  integer :: none
  integer, parameter :: N = 1000000

  none = check_precision()

  write(*, '(a4, 1x,es22.15e3)') 'pi =', pi_Gregory_Leibniz(N)

end program compute_pi