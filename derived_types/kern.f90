
module kern
  
  use vars

  implicit none

  contains

  subroutine gen_gauss2d(a)
    type(gaussian2d) :: a
    integer :: i, j
    integer :: nx, ny
    real :: sx, sy, x0, y0
    real :: norm, expx, expy
    real, parameter :: pi = 4.0 * atan(1.0)

    nx = a%nx
    ny = a%ny
    sx = a%sx
    sy = a%sy
    x0 = a%x0
    y0 = a%y0
    norm = 1.0 / (2.0 * pi * sqrt(sx*sy))

    !$acc parallel loop collapse(2) present(a) copyin(a%x, a%y) private(expx, expy) 
    do i = 1, nx
       do j = 1, ny
          expx  = exp(-(a% x(i)-x0)**2/(2.0*sx**2))
          expy  = exp(-(a% y(j)-y0)**2/(2.0*sy**2))
          a%curve(i,j) = norm * expx * expy
       enddo
    enddo

  end subroutine gen_gauss2d

end module kern
