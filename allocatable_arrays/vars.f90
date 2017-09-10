
module vars
  
  use openacc

  implicit none

  public

  integer :: nx, ny  ! number of points along each direction
  real :: sx, sy     ! dispersions
  real :: rho        ! x-y correlation factor 0 <= rho <= 1
  real :: x0, y0     ! coordinates of the peak
  real, dimension(:), allocatable :: x, y ! coordinates
  real, dimension(:,:), allocatable :: curve ! the 2D gaussian curve

  contains 

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine alloc()
!    integer, intent(in) :: n1, n2

    integer :: ierr
   
    allocate(x(nx), y(ny), curve(nx, ny), stat=ierr)
    if (ierr /= 0) stop 'vars: alloc: Failed to allocate derived type allocatable arrays'

  end subroutine alloc

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine h2d()
    ! $ acc enter data pcreate(sx, sy, nx, ny, rho, x0, y0) copy(x, y, curve)
  end subroutine h2d

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine d2h()
    ! $ acc exit data copyout(x, y, curve)
  end subroutine d2h

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
end module vars
