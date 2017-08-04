
program compute_pi
  
  use precision
  use lib, only: pi_Gregory_Leibniz, &
                 pi_area_rand 

  implicit none

  integer :: none
  real(dp) :: pi_gl, pi_area
  integer, parameter :: N = 1000000, M = 20000

  none = check_precision()

  pi_gl = pi_Gregory_Leibniz(N)
  pi_area = pi_area_rand(M) 

end program compute_pi
