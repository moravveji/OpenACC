
module vars
  
  use openacc

  implicit none

  public

  integer :: nx, ny  ! number of points along each direction
  real :: sx, sy     ! dispersions
  real :: rho        ! x-y correlation factor 0 <= rho <= 1
  real :: x0, y0     ! coordinates of the peak
  real, dimension(:), allocatable :: x, y ! coordinates
  real, dimension(:,:), allocatable :: z  ! the 2D gaussian z

  contains 

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine alloc()
    integer :: ierr
   
    allocate(x(nx), y(ny), z(nx, ny), stat=ierr)
    if (ierr /= 0) stop 'vars: alloc: Failed to allocate derived type allocatable arrays'

  end subroutine alloc

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine h2d()
    !$acc enter data copyin(sx, sy, nx, ny, rho, x0, y0, x, y, z)
  end subroutine h2d

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine d2h()
    !$acc exit data copyout(x, y, z)
  end subroutine d2h

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
end module vars
