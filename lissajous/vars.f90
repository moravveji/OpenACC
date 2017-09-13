

module vars

  implicit none

  private 

  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  type, public :: point
    integer :: nx, ny, nz
    real :: phix, phiy, phiz
    real :: x, y, z
  end type point

  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  type, public :: curve
    integer :: npoints
    type(point), dimension(:), allocatable :: knot
    real, dimension(:), allocatable :: times 
    contains 
 
    procedure, nopass :: alloc

  end type curve

  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  contains

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  subroutine alloc(crv, npts)
    type(curve), intent(inout) :: crv
    integer, intent(in) :: npts

    integer :: ierr 
    
    crv% npoints = npts

    if (allocated(crv% knot))  deallocate(crv% knot)
    if (allocated(crv% times)) deallocate(crv% times)

    allocate(crv%knot(npts), crv%times(npts), stat=ierr)
    if (ierr /= 0) &
       stop 'vars: alloc: failed to allocate the knot(npoints) or times(npoints)'

  end subroutine alloc

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module vars

