
module kern
  
  use vars

  implicit none

  contains

  subroutine gen_gauss2d(a)
    type(gaussian2d) :: a
    integer :: i, j, nx, ny
    real :: norm, exp2d

    nx = a%nx
    ny = a%ny

    !acc parallel loop collapse(2) present(a) 
    do i = 1, nx
       do j = 1, ny
          norm   = 1.0
          exp2d  = 1.0
          a%curve(i,j) = norm * exp2d
       enddo
    enddo

  end subroutine gen_gauss2d

end module kern
