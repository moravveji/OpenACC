
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
    real(sp) :: tstart, tend
    real(dp) :: sum !num, denum
    real(dp) :: fraction
    !$acc routine(fraction) seq

    if (gpu) call acc_init(acc_device_nvidia)
    
    call cpu_time(tstart)
    sum = 0d0
    !$acc parallel loop reduction(+:sum) if(gpu)
    do k = 0, n
       sum = sum + fraction(k)
    enddo
    !$acc end parallel loop
    pi = 4d0 * sum
    
    call cpu_time(tend)
    write(*,'(a, f8.6)', advance='yes') 'Time lapsed (sec) = ', tend - tstart
    write(*,'(a, es22.15e3)') 'pi_Gregory_Leibniz: pi = ', pi
    write(*,*)

  end function pi_Gregory_Leibniz
  
  ! =============================================

  real(dp) function fraction(k) result(f)
    !$acc routine seq
    integer, intent(in) :: k
    f =  (-1d0)**(mod(k,2)) / (2d0*k + 1d0) 
  end function fraction


  ! =============================================
  real(dp) function pi_area_rand(n) result(pi)
    integer, intent(in) :: n 

    !integer, parameter :: seed = 12345
    integer :: i, j, inside
    real(dp), value :: x, y
    real(sp) :: tstart, tend
    real(dp) :: random_number
    !$acc routine(random_number)

    if (gpu) call acc_init(acc_device_nvidia)
    
    call random_seed()

    call cpu_time(tstart)

    inside = 0
    !$acc parallel loop private(x,y) collapse(2) if(gpu)
    do i = 0, n
      ! $ acc loop 
      do j = 0, n
         !call random_number(x)
         !call random_number(y)
         x = dble(i) / dble(n)
         y = dble(j) / dble(n)
         if (dsqrt(x**2 + y**2) .le. 1d0) then 
           !$acc atomic update
             inside = inside + 1
           !$acc end atomic
         endif
      enddo
      ! $ acc end loop
    enddo
    !$acc end parallel loop

    pi = 4d0 * dble(inside) / dble(n**2)
    call cpu_time(tend)

    write(*,'(a, f8.6)') 'Elapsed time (sec) = ', tend - tstart    
    write(*, '(a, es22.15e3)') 'pi_area_rand: pi= ', pi
    write(*,*) 

  end function pi_area_rand

end module lib
