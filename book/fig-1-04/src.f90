
program src
  
  use openacc
  
  implicit none

  integer :: nCount = 100
  integer, allocatable, dimension(:) :: arr
  integer :: isum, k, ierr
  real :: start, end
  logical :: equal

  nCount = nCount * 1000000
  isum = 0
  
  allocate(arr(nCount), stat=ierr)
  if (ierr /= 0) stop 'Allocate failed'
  arr(:) = 0

  call cpu_time(start)

  !$acc kernels copyin(arr(1:nCount)) copyout(isum)
  do k = 1, nCount
     arr(k) = 1
  enddo

  !$acc loop vector reduction(+:isum)
  do k = 1, nCount
     isum = isum + arr(k)
  enddo
  !$acc end loop
  !$acc end kernels

  call cpu_time(end)

  equal = (isum == nCount)
  print*, 'assert (isum == nCount)', equal
  print '(a, f7.4)', 'Time lapse (sec): ', end-start
  
end program src
