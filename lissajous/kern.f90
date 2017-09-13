

module kern
  
   use vars

   implicit none 

   real, parameter :: pi = 4*atan(1.0), pi2 = 2*pi

   contains

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  logical function check_mutually_prime(a, b, c) result(check)
    integer, intent(in) :: a, b, c
 
    logical, dimension(3) :: OK

!    if (a == b .or. b == c .or. a == c) then 
    if (b <= a .or. c <= b .or. a == c) then 
       check = .false.
       return 
    endif

    OK(1) = gcd(a, b) == 1
    OK(2) = gcd(b, c) == 1
    OK(3) = gcd(c, a) == 1
    check = all(OK)

  end function check_mutually_prime

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  integer function gcd(a, b) 
    integer, intent(in) :: a, b
    integer, intent(out) :: gcd 

    integer :: k
    
    gcd = 1
    do k = 2, min(a, b) 
       if (mod(a, k)==0 .and. mod(b, k)==0) then 
          gcd = k
       else
          cycle
       endif
    enddo

  end function gcd 

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

  subroutine def_curve(crv, nx, ny, nz, npts, phix, phiy, phiz)
    type(curve), intent(inout) :: crv
    integer, intent(in) :: nx, ny, nz, npts
    real, intent(in) :: phix, phiy, phiz

    type(point) :: p
    integer :: k
    logical, dimension(3) :: OK
  
    real, parameter :: tstart = 0.0, tend = pi2

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

    crv% nx = nx 
    crv% ny = ny
    crv% nz = nz
    crv% phix = phix 
    crv% phiy = phiy
    crv% phiz = phiz

    ! set the timesteps
    crv% times = get_times(tstart, tend, npts)

  end subroutine def_curve

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  subroutine make_lissajous(crv)
    type(curve), intent(inout) :: crv

    integer :: npts, it
    real :: t

    npts   = crv% npoints
    if (.not. allocated(crv% knot) .or. &
        .not. allocated(crv% times)) &
       stop 'kern: make_lissajous: crv%knot or crv%times is not allocated yet'

    do it = 1, npts
       t   = crv% times(it)
       crv% knot(it)% x = cos(pi2 * ( crv% nx * t + crv% phix) )
       crv% knot(it)% y = cos(pi2 * ( crv% ny * t + crv% phiy) )
       crv% knot(it)% z = cos(pi2 * ( crv% nz * t + crv% phiz) )
    enddo
    

  end subroutine make_lissajous

  !+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module kern

