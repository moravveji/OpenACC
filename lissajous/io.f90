
module io

  use vars

  implicit none

  contains

  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  subroutine write_one_curve(crv, dirname)
    type(curve), intent(in) :: crv 
    character(len=*), intent(in) :: dirname

    integer :: funit, ierr, k
    character(len=:), allocatable :: msg
    character(len=1024) :: filename
    character(len=17), parameter :: frmt = '(4(es16.8e3, 1x))'

    write(filename, '(a,3(a1,i0),a)') 'data/Lissajous', '(', &
                     crv% nx, ',', crv% ny, ',', crv% nz, ').txt'

    open(newunit=funit, file=trim(filename), action='write', status='replace', &
         decimal='point', form='formatted', position='rewind', iostat=ierr, iomsg=msg)
    if (ierr /= 0) then 
       print *, msg
       stop 'io: write_one_curve: failed to open the file'
    endif

    do k = 1, crv% npoints
       write(unit=funit, fmt=frmt, iostat=ierr, iomsg=msg) &
             crv% times(k), crv% knot(k)% x, crv% knot(k)% y, crv% knot(k)% z
      if (ierr /= 0) then
         print*, k, msg
         write(*, frmt) crv% times(k), crv% knot(k)% x, crv% knot(k)% y, crv% knot(k)% z
         stop 'io: write_one_curve: the write failed'
      endif 

    enddo

    close(unit=funit)

    print '(a, a)', 'io: write_one_curve: saved: ', trim(filename)

  end subroutine write_one_curve

  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module io
