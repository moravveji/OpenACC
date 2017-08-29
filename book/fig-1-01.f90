
program fig_1_01
  
!  use openacc

  implicit none
  integer :: nCount
  integer, dimension(:), allocatable :: array
  integer :: ierr, j, k, isum
  logical :: equal
  real :: start, end
  
!  call acc_init(acc_device_nvidia) 

  nCount = 1000
  print '(a,i4)', 'nCount=', nCount

  if (nCount <= 0) stop 'nCount must be greater than zero'
  
  nCount = nCount * 1000000
  ! allocate the array variable
  allocate(array(nCount), stat=ierr)
  if (ierr /= 0) stop 'Failed to allocate the array(nCount)'
  array(:) = -1

  call cpu_time(start)

  ! Here is where we fill the status vector
  !$acc parallel loop copyout(array(1:nCount)) 
  do k = 1, nCount
     array(k) = 1
  enddo
  !$acc end parallel loop
  
  isum = 0
  do k = 1, nCount
     isum = isum + array(k)
  enddo 

  call cpu_time(end)

  equal = .false.
  equal = (isum == nCount)
  print '(a,i4,a)', 'Final sum is ', isum/1000000, ' millions'
  print *, 'assert (sum == nCount):', equal
  print '(a, f7.4, a)', 'Runtime took ', end-start, ' (sec)'

end program fig_1_01

