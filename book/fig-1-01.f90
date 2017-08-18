
program fig_1_01
  
  implicit none
  integer :: nCount, nLoop
  integer, dimension(:), allocatable :: array
  integer :: ierr, k, isum
  
  read*, nCount, nLoop
  if (nCount <= 0 .or. nLoop <= 0) stop 'nCount and nLoop must be greater than zero'
  
  nCount = nCount * 1000000
  ! allocate the array variable
  allocate(array(nCount), stat=ierr)
  if (ierr /= 0) stop 'Failed to allocate the array(nCount)'
  
  ! Here is where we fill the status vector
  do k = 1, nCount
     array(k) = 1
  enddo
  
  isum = 0
  do k = 1, nCount
     isum = isum + array(k)
  enddo 
  
  print '(a,i,a)', 'Final sum is ', isum/1000000, 'millions'
  print '(a,i)', 'assert (sum == nCount)', (isum == nCount)
  
end program fig_1_01