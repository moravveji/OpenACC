
module io

  use vars

  implicit none

  contains

  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  subroutine write_one_curve(crv, filename)
    type(curve), intent(in) :: crv 
    character(len=*), intent(in) :: filename

    integer :: funit, ierr, k
    character(len=:), allocatable :: msg

    open(newunit=funit, file=trim(filename), action='write', status='replace', &
         decimal='point', form='formatted', position='rewind', iostat=ierr, iomsg=msg)
    if (ierr /= 0) then 
       print *, msg
       stop 'io: write_one_curve: failed to open the file'
    endif

    do k = 1, crv% npoints
       write(unit=funit, fmt='(4(pes16.8e3, 1x))', iostat=ierr, iomsg=msg) &
             crv% times(k), crv% knot% x, crv% knot% y, crv% knot% z
    enddo

    if (ierr /= 0) then
       print*, msg
       stop 'io: write_one_curve: the write failed'
    endif 

    close(unit=funit)

  end subroutine write_one_curve

  ! ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end module io
