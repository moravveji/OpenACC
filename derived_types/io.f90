
module io

  implicit none

  contains

  subroutine write_ascii(x, y, z, filename) 
    real, dimension(:), intent(in) :: x, y
    real, dimension(:,:), intent(in) :: z
    character(len=*), intent(in) :: filename
    
    integer :: handle, i, j, nx, ny
    integer :: ierr
    character :: msg
    
    nx = size(x)
    ny = size(y)
    if ( (size(z, dim=1) .ne. nx) .or. (size(z, dim=2) .ne. ny) ) then 
       stop 'Error: write_ascii: failed to match x, y, and z dimensions'
    endif

    open(newunit=handle, file=trim(filename), action='write', &
         status='replace', decimal='point', form='formatted', &
         position='rewind', iostat=ierr, iomsg=msg)

    if (ierr /= 0) then 
       stop 'Error: write_ascii: failed to open the file'
    endif

    do j = 1, ny
       do i = 1, nx
          write(unit=handle, fmt='(3(f9.6, 1x))', iostat=ierr, iomsg=msg, &
                advance='yes') x(i), y(j), z(i, j)
          if (ierr /= 0) then
              print '(a,2i4)', 'Error: write_ascii: write failed for i,j=', i, j
              stop               
          endif
       enddo
    enddo

!    endfile statement
    close(unit=handle)

  end subroutine write_ascii

end module io
