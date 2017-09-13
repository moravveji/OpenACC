
program main
  
  use vars
  use kern
  use io

  implicit none

  integer :: nx, ny, nz, npoints
  integer, parameter :: i_max = 10
  integer, parameter :: multiply_points_by = 100
  real, parameter :: phix=0.1, phiy=0.7, phiz=0.0
  type(curve) :: this

  logical :: mutually_prime

  integer :: i_curve
  integer, parameter :: num_curves = 1000
  type(curve), dimension(num_curves) :: curves
  character(len=*), parameter :: output_dir = 'data'

  i_curve = 0

  do nx = 1, i_max
     do ny = 1, i_max
        do nz = 1, i_max
           ! check the condition that nx, ny and nz are mutually prime
           mutually_prime = check_mutually_prime(nx, ny, nz)
           if (.not. mutually_prime) cycle

           i_curve = i_curve + 1
           this    = curves(i_curve)

           ! npoints depends on the frequency so that each lasts differently
           npoints = multiply_points_by * nx * ny * nz

           ! define the curve with a fixed number of points
           call def_curve(this, nx, ny, nz, npoints, phix, phiy, phiz)

           ! calculate this lissajous curve
           call make_lissajous(this)

           ! write the curve to an ascii file
           call write_one_curve(this, output_dir)

        enddo
     enddo
  enddo

  call system('python plotter.py')

  print '(/, a, i0, a)', 'Created ', i_curve, ' lissajous curves.'

end program main 

