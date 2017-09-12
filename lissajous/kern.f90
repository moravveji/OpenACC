

module kern
  
   use vars

   implicit none 

   contains

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  function get_times(t0, t1, nt) result(arr)
    real, intent(in) :: t0, t1
    integer, intent(in) :: nt
    real, dimension(nt), intent(out) :: arr

    integer :: ierr, k
    real :: dt

    dt = (t1 - t0) / (nt - 1)

    do k = 1, nt
       arr(k) = t0 + dt * (k-1)
    enddo 

  end function get_times

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  subroutine def_curve(nx, ny, nz, npts, phix, phiy, phiz, &
                       tstart, tend)
    integer, intent(in) :: nx, ny, nz, npts
    real, intent(in) :: phix, phiy, phiz
    real, intent(in) :: tstart, tend

    type(point) :: p
    integer :: k

    if (.not. allocated(this% knot) .or. &
        .not. allocated(this% times)) call alloc(npts)

    do k = 1, npts
       p     = this% knot(k)
       p% nx = nx 
       p% ny = ny
       p% nz = nz
       p% phix = phix 
       p% phiy = phiy
       p% phiz = phiz
    enddo

    ! set the timesteps
    this% times = get_times(tstart, tend, npts)


  end subroutine def_curve

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  subroutine make_lissajous()
    type(point) :: p
    integer :: npts, it
    real :: t

    npts   = this% npoints
    if (.not. allocated(this% knot) .or. &
        .not. allocated(this% times)) &
       stop 'kern: make_lissajous: this%knot or this%times is not allocated yet'

    do it = 1, npts
       t   = this% times(it)
       p   = this% knot(it)
       p%x = cos(p%nx * t + p%phix)
       p%y = cos(p%ny * t + p%phiy)
       p%z = cos(p%nz * t + p%phiz)
    enddo
    

  end subroutine make_lissajous

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module kern

