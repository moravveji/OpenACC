
module kern
  
  use vars

  implicit none

  contains

  subroutine set_xy(a, xlo, xhi, ylo, yhi)
    type(gaussian2d), intent(inout) :: a
    real, intent(in) :: xlo, xhi, ylo, yhi

    integer :: k
    real :: wx, wy, dx, dy

    if (.not. allocated(a%x) .or. .not. allocated(a%y)) then
       stop 'Error: kern: set_xy: a%x and/or a%y is not allocated'
    endif

    ! let x and y arrays vary uniformly between lo and hi 
    !$acc data present(a)
    wx = xhi - xlo
    wy = yhi - ylo
    dx = wx / (a% nx - 1)
    dy = wy / (a% ny - 1)

    a% x(1 : a% nx) = (/ (xlo + (k-1) * dx, k = 1, a% nx) /)
    a% y(1 : a% ny) = (/ (ylo + (k-1) * dy, k = 1, a% ny) /)
    !$acc end data

  end subroutine set_xy

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine gen_gauss2d(a)
    type(gaussian2d) :: a
    integer :: i, j
    integer :: nx, ny
    real :: rho, sx, sy, x0, y0
    real :: norm, expx, expy, argx, argy, argxy, arg
    real, dimension(:), allocatable :: x, y
    real, parameter :: pi = 4.0 * atan(1.0)

    nx = a%nx
    ny = a%ny
    sx = a%sx
    sy = a%sy
    x0 = a%x0
    y0 = a%y0
    rho= a%rho
    norm = 2.0 * pi * sx * sy * sqrt(1.0 - rho**2)
    
print*, 'a% x(0)=', a% x(0)
    allocate(x(nx), y(ny))
    !$acc data present(a) create(x, y)
    !$acc kernels 
    x(:) = a% x(:)
    y(:) = a% y(:)
    !$acc end kernels

    !$acc parallel loop collapse(2) private(argx, argy, argxy, arg) 
    do i = 1, nx
       do j = 1, ny
          argx  = (x(i) - x0)**2 / sx**2
          argy  = (y(j) - y0)**2 / sy**2
          argxy = 2 * rho * (x(i) - x0) * (y(j) - y0) / (sx * sy)
          arg   = (argx + argy - argxy) / (-2 * (1.0 - rho**2))
          a% curve(i,j) = exp(arg) / norm
       enddo
    enddo
    !$acc end parallel loop
    !$acc end data

  end subroutine gen_gauss2d

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module kern
