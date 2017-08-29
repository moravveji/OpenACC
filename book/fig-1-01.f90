
program fig_1_01
  
  implicit none
  integer :: nCount
  integer, dimension(:), allocatable :: array
  integer :: ierr, j, k, isum
  logical :: equal
  real :: start, end
  
  nCount = 100
  print '(a,i4)', 'nCount=', nCount

  if (nCount <= 0) stop 'nCount must be greater than zero'
  
  nCount = nCount * 1000000
  ! allocate the array variable
  allocate(array(nCount), stat=ierr)
  if (ierr /= 0) stop 'Failed to allocate the array(nCount)'
  array(:) = -1

  call cpu_time(start)

  isum = 0
 
  ! Here is where we fill the status vector
  !$acc parallel loop copyin(array(1:nCount)) copyout(isum)
  do k = 1, nCount
     array(k) = 1
  enddo
  
  !$acc loop reduction(+:isum)
  do k = 1, nCount
     isum = isum + array(k)
  enddo 
  !$acc end loop

  call cpu_time(end)

  equal = .false.
  equal = (isum == nCount)
  print '(a,i4,a)', 'Final sum is ', isum/1000000, ' millions'
  print *, 'assert (isum == nCount):', equal
  print '(a, f7.4, a)', 'Runtime took ', end-start, ' (sec)'

end program fig_1_01

