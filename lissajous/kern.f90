

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

  subroutine def_curve(crv, nx, ny, nz, npts, phix, phiy, phiz, &
                       tstart, tend)
    type(curve), intent(inout) :: crv
    integer, intent(in) :: nx, ny, nz, npts
    real, intent(in) :: phix, phiy, phiz
    real, intent(in) :: tstart, tend

    type(point) :: p
    integer :: k
    logical, dimension(3) :: OK

    if (nx < 1 .or. ny < 1 .or. nz < 1) &
       stop 'kern: def_curve: nx, ny and nz must be .ge. 1'
    OK(1) = (phix >= 0 .or. phix <= 1)
    OK(2) = (phiy >= 0 .or. phiy <= 1)
    OK(3) = (phiz >= 0 .or. phiz <= 1)
    if (.not. all(OK)) then
       print*, OK
       stop 'kern: def_curve: phix, phiy, phiz must be between 0 and 1'
    endif

    if (.not. allocated(crv% knot) .or. &
        .not. allocated(crv% times)) call crv% alloc(crv, npts)

    do k = 1, npts
       p% nx = nx 
       p% ny = ny
       p% nz = nz
       p% phix = phix 
       p% phiy = phiy
       p% phiz = phiz
       crv% knot(k) = p
    enddo

    ! set the timesteps
    crv% times = get_times(tstart, tend, npts)

  end subroutine def_curve

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  subroutine make_lissajous(crv)
    type(curve), intent(inout) :: crv

    integer :: npts, it
    real :: t
    real, parameter :: pi = 4*atan(1.0), pi2 = 2*pi

    npts   = crv% npoints
    if (.not. allocated(crv% knot) .or. &
        .not. allocated(crv% times)) &
       stop 'kern: make_lissajous: crv%knot or crv%times is not allocated yet'

    do it = 1, npts
       t   = crv% times(it)
       crv% knot(it)% x = cos(pi2 * ( crv% knot(it)% nx * t + crv% knot(it)% phix) )
       crv% knot(it)% y = cos(pi2 * ( crv% knot(it)% ny * t + crv% knot(it)% phiy) )
       crv% knot(it)% z = cos(pi2 * ( crv% knot(it)% nz * t + crv% knot(it)% phiz) )
    enddo
    

  end subroutine make_lissajous

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module kern

