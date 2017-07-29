
module lib

  use precision

  implicit none

  private
  public :: pi_Gregory_Leibniz

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
  real(dp) function pi_Gregory_Leibniz(n) result(sum)
    integer, intent(in) :: n
    
    integer :: k
    ! double precision :: num, denum
    real(dp) :: num, denum

    sum = 0d0
    do k = 0, n
       num   = (-1d0)**k
       denum = 2d0 * k + 1d0
       sum   = sum + num / denum
    enddo
    sum = 4d0 * sum

  end function pi_Gregory_Leibniz
  
  ! =============================================

end module lib