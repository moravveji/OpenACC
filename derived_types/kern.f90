
module kern
  
  use vars

  implicit none

  contains

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine set_xy(a, xlo, xhi, ylo, yhi)
    type(gaussian2d), intent(inout) :: a
    real, intent(in) :: xlo, xhi, ylo, yhi

    integer :: i, j, k
    real :: wx, wy, dx, dy

    if (.not. allocated(a%x) .or. .not. allocated(a%y)) then
       stop 'Error: kern: set_xy: a%x and/or a%y is not allocated'
    endif

    ! let x and y arrays vary uniformly between lo and hi 
    wx = xhi - xlo
    wy = yhi - ylo
    dx = wx / (a% nx - 1)
    dy = wy / (a% ny - 1)

    !$acc data pcopy(xlo, ylo, dx, dy) 
    !$acc kernels 
    do k = 1, a% nx
       a% x(k) = xlo + (k-1) * dx
    enddo

    do k = 1, a% ny
       a% y(k) = ylo + (k-1) * dy
    enddo

    do i = 1, a% nx
       do j = 1, a% ny
          a% curve(i, j) = -9
       enddo
    enddo
    !$acc end kernels
    !$acc end data

  end subroutine set_xy

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine gen_gauss2d(a)
    type(gaussian2d) :: a
    integer :: i, j
    integer :: nx, ny
    real :: rho, sx, sy, x0, y0
    real :: norm, expx, expy, argx, argy, argxy, arg
    real, parameter :: pi = 4.0 * atan(1.0)

    norm = 2.0 * pi * a% sx * a% sy * sqrt(1.0 - a% rho**2)
    
    !$acc data present(a% x, a% y, a% curve)
    !$acc parallel loop num_gangs(1000) vector_length(100) collapse(2) private(argx, argy, argxy, arg) 
    do i = 1, a% nx
       do j = 1, a% ny
          argx  = (a% x(i) - a% x0)**2 / a% sx**2
          argy  = (a% y(j) - a% y0)**2 / a% sy**2
          argxy = 2 * a% rho * (a% x(i) - a% x0) * (a% y(j) - a% y0) / (a% sx * a% sy)
          arg   = (argx + argy - argxy) / (-2 * (1.0 - a% rho**2))
          a% curve(i,j) = exp(arg) / norm
       enddo
    enddo
    !$acc end parallel loop
    !$acc end data

  end subroutine gen_gauss2d

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module kern
