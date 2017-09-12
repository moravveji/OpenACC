

module vars

  implicit none

  public 

  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  type point
    integer :: nx, ny, nz
    real :: phix, phiy, phiz
    real :: x, y, z
  end type point

  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  type curve
    integer :: npoints
    type(point), dimension(:), allocatable :: knot
    real, dimension(:), allocatable :: times   
  end type curve
  
  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  type(curve), target, save :: this
  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  contains

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  subroutine alloc(npts)
    integer, intent(in) :: npts

    integer :: ierr 
    
    this% npoints = npts

    if (allocated(this% knot))  deallocate(this% knot)
    if (allocated(this% times)) deallocate(this% times)

    allocate(this%knot(npts), this%times(npts), stat=ierr)
    if (ierr /= 0) &
       stop 'vars: alloc: failed to allocate the knot(npoints) or times(npoints)'

  end subroutine alloc

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module vars

