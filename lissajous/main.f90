
program main
  
  use vars
  use kern
  use io
  use openacc

  implicit none

  integer :: nx, ny, nz, npoints
  integer, parameter :: i_max = 10
  integer, parameter :: multiply_points_by = 1000
  real, parameter :: phix=0.1, phiy=0.7, phiz=0.0
  type(curve) :: this

  logical :: mutually_prime

  integer :: i_curve
  integer, parameter :: num_curves = 100
  type(curve), dimension(num_curves) :: curves
  character(len=*), parameter :: output_dir = 'data'

  ! warm up openacc
  call openacc_init(acc_device_nvidia)
  call acc_set_device_num(0, acc_device_nvidia)

  i_curve = 0

  !acc enter data copyin(this, curves) copyin(this% nx, this% ny, this% nz, this% npoints, this% phix, this% phiy, this% phiz, this% knot, this% times) 
  !$acc parallel loop collapse(3) private(mutually_prime, this, npoints) 
  do nx = 1, i_max
     do ny = 1, i_max
        do nz = 1, i_max
           ! check the condition that nx, ny and nz are mutually prime
           mutually_prime = check_mutually_prime(nx, ny, nz)
           if (.not. mutually_prime) cycle

           !$acc atomic 
           i_curve = i_curve + 1
           this    = curves(i_curve)

           ! npoints depends on the frequency so that each lasts differently
           npoints = multiply_points_by * nx * ny * nz

           ! define the curve with a fixed number of points
           call def_curve(this, nx, ny, nz, npoints, phix, phiy, phiz)

           ! calculate this lissajous curve
           call make_lissajous(this)

        enddo
     enddo
  enddo
  !$acc end parallel loop
  !$acc update self(this)

  !$acc wait
!  call write_all_curves(curves, output_dir)
!  call system('python plotter.py')

  print '(/, a, i0, a)', 'Created ', i_curve, ' lissajous curves.'

  !$acc exit data copyout(this) copyout(this% npoints, this% times, this% knot)

end program main 

