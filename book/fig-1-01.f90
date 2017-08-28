
program fig_1_01
  
  use openacc

  implicit none
  integer :: nCount, nLoop
  integer, dimension(:), allocatable :: array
  integer :: ierr, j, k, isum
  logical :: equal
  real :: start, end
  
  call acc_init(acc_device_nvidia) 

  nCount = 6; nLoop = 1000
  print '(2(a,i4))', 'nCount=', nCount, '; and nLoop=', nLoop 

  if (nCount <= 0 .or. nLoop <= 0) stop 'nCount and nLoop must be greater than zero'
  
  nCount = nCount * 1000000
  ! allocate the array variable
  allocate(array(nCount), stat=ierr)
  if (ierr /= 0) stop 'Failed to allocate the array(nCount)'
  
  call cpu_time(start)

  !$acc data create(array) pcopyin(nCount, nLoop) pcopy(isum) 
  do j = 1, nLoop

    ! Here is where we fill the status vector
    !$acc kernels loop
    do k = 1, nCount
       array(k) = 1
    enddo
  
    isum = 0

    !$acc loop 
    do k = 1, nCount
       !$acc atomic
       isum = isum + array(k)
    enddo 
    !$acc end kernels loop

  enddo 
  !$acc end data

  call cpu_time(end)

  equal = .false.
  equal = (isum == nCount)
  print '(a,i4,a)', 'Final sum is ', isum/1000000, ' millions'
  print *, 'assert (sum == nCount):', equal
  print '(a, f7.4, a)', 'Runtime took ', end-start, ' (sec)'

end program fig_1_01

