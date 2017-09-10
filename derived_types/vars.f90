
module vars
  
  use openacc

  implicit none

  public

  type gaussian2d
    integer :: nx, ny  ! number of points along each direction
    real :: sx, sy     ! dispersions
    real :: rho        ! x-y correlation factor 0 <= rho <= 1
    real :: x0, y0     ! coordinates of the peak
    real, dimension(:), allocatable :: x, y ! coordinates
    real, dimension(:,:), allocatable :: curve ! the 2D gaussian curve
  end type

!  type(gaussian2d) :: g2d 
 
  contains 

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine alloc(a, nx, ny, sx, sy, rho, x0, y0)
    type(gaussian2d), intent(inout) :: a
    integer, intent(in) :: nx, ny
    real, intent(in) :: sx, sy, rho, x0, y0

    integer :: ierr
    
    a% nx = nx
    a% ny = ny
    a% sx = sx
    a% sy = sy
    a% rho= rho
    a% x0 = x0
    a% y0 = y0

    allocate(a% x(nx), a% y(ny), a% curve(nx, ny), stat=ierr)
    if (ierr /= 0) stop 'vars: alloc: Failed to allocate derived type allocatable arrays'

  end subroutine alloc

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine h2d(a)
    type(gaussian2d) :: a
    !$acc enter data copyin(a) pcreate(a%sx, a%sy, a%nx, a%ny, a%rho, a%x0, a%y0) copyin(a%x, a%y, a%curve)
  end subroutine h2d

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine d2h(a)
    type(gaussian2d) :: a
    !$acc exit data copyout(a%x, a%y, a%curve)
  end subroutine d2h

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
end module vars
