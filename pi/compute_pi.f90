
program compute_pi
  
  use precision
  use lib, only: pi_Gregory_Leibniz, &
                 pi_area_rand 

  implicit none

  integer :: none
  integer, parameter :: N = 1000000, M = 100000

  none = check_precision()

  write(*, '(a, 1x,es22.15e3)') 'pi_gregory_leibniz =', pi_Gregory_Leibniz(N)
  write(*, '(a, 1x, es22.15e3)') 'pi_area_rand = ', pi_area_rand(M)

end program compute_pi
