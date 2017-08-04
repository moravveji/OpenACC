
module lib

  use precision
  use openacc

  implicit none

  private
  public :: pi_Gregory_Leibniz, &
            pi_area_rand
  
  logical, parameter :: gpu = .true.

  contains

  ! =============================================
  integer function factorial(n)
    integer, intent(in) :: n
    integer :: k

    factorial = 1
    do k = 1, n
       factorial = factorial * k
    enddo

  end function factorial

  ! =============================================
  real(dp) function numerator(n)
    integer, intent(in) :: n
    numerator = 1.0d0
  end function numerator

  ! =============================================
  real(dp) function denumerator(n)
    integer, intent(in) :: n
    denumerator = 1.0d0
  end function denumerator

  ! =============================================
  real(dp) function pi_Gregory_Leibniz(n) result(pi)
    integer, intent(in) :: n
    
    integer, value :: k
    real(dp) :: sum !num, denum
    real(dp) :: fraction
    !$acc routine(fraction) seq

    call acc_init(acc_device_nvidia)
    
    sum = 0d0
    !$acc parallel loop reduction(+:sum) 
    do k = 0, n
       sum = sum + fraction(k)
    enddo
    !$acc end parallel loop
    pi = 4d0 * sum

  end function pi_Gregory_Leibniz
  
  ! =============================================

    real(dp) function fraction(k) result(f)
      !$acc routine seq
      integer, intent(in) :: k
      f = (-1d0)**(mod(k,2)) / (2d0*k + 1d0) 
    end function fraction


  ! =============================================
  real(dp) function pi_area_rand(n) result(pi)
    integer, intent(in) :: n 

    !integer, parameter :: seed = 12345
    integer :: i, j, inside
    real(dp) :: x, y
    
    call random_seed()

    inside = 0
    do i=1, n
      do j = 1, n
         call random_number(x)
         call random_number(y)
         if (dsqrt(x**2 + y**2) .le. 1d0) inside = inside + 1
      enddo
    enddo
    
    pi = 4d0 * dble(inside) / dble(n**2)

  end function pi_area_rand

end module lib
