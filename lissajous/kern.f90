

module kern
  
   use vars

   implicit none 

   contains

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  real function get_times(t0, t1, nt) result(arr)
    real, intent(in) :: t0, t1
    integer, intent(in) :: nt
    real, dimension(:), allocatable, intent(out) :: arr

    integer :: ierr, k
    real :: dt

    allocate(arr(nt), stat=ierr)
    if (ierr /= 0) &
       stop 'kern: get_times: failed to allocate arr(nt)'

    dt = (t1 - t0) / (nt - 1)

    do k = 1, nt
       arr(k) = t0 + dt * (k-1)
    enddo 

  end function get_times

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  subroutine make_lissajous(times)
    real, intent(in), allocatable :: times(:)

    type(point) :: p
    integer :: ntimes, it
    real :: t

    if (.not. allocated(times)) &
       stop 'kern: make_lissajous: the times vector is not allocated yet'
    ntimes = size(times)

    if (.not. allocated(knot)) &
       stop 'kern: make_lissajous: the knot is not allocated yet'

    do it = 1, ntimes
       t   = times(it)
       p   = knot(it)
       p%x = cos(p%nx * t + p%phix)
       p%y = cos(p%ny * t + p%phiy)
       p%z = cos(p%nz * t + p%phiz)
    enddo
    

  end subroutine make_lissajous

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module kern

