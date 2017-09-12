

module vars

  implicit none

  public 

  type point
       integer :: nx, ny, nz
       real :: phix, phiy, phiz
!       real :: t
       real :: x, y, z
  end type point

  type(point), allocatable, dimension(:) :: knot 
  
  contains

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine alloc(npts)
    integer, intent(in) :: npts

    integer :: ierr 

    allocate(knot(npts), stat=ierr)
    if (ierr /= 0) &
       stop 'vars: alloc: failed to allocate the knot(npoints)'

  end subroutine alloc
  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module vars

