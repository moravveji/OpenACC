
module vars

  implicit none
  
!  private
!  public :: coordinates, specie, species

  !========================================================

  type coordinate
    real :: x, y, z
  end type coordinate

  type velocity
    real :: vx, vy, vz
  end type velocity

  type accelerate
    real :: ax, ay, az
  end type accelerate

  type momentum
    real :: px, py, pz
  end type momentum

  type field
    real :: ex, ey, ez
  end type field

  type force
    real :: fx, fy, fz
  end type force

  type specie
    character(len=8) :: name
    integer :: id 
    logical :: is_added = .false.
    logical :: is_allocated = .false.
    integer :: charge
    integer :: n_specie
    type(coordinate), dimension(:), allocatable :: crd
    type(velocity),   dimension(:), allocatable :: vel
    type(accelerate), dimension(:), allocatable :: acc
    type(momentum),   dimension(:), allocatable :: mom
    type(field),      dimension(:), allocatable :: fld
    type(force),      dimension(:), allocatable :: frc

    contains 

    procedure, nopass :: alloc_specie

  end type specie

  type species
    integer :: n_species
    logical :: is_allocated = .false.
    logical, dimension(:), allocatable :: specie_is_added 
    type(specie), dimension(:), allocatable :: plasma
    
    contains

    procedure, nopass :: alloc_species
    procedure, nopass :: add_specie

  end type species

  !========================================================

  contains

  !========================================================

  subroutine alloc_specie(sp, n, c)
    type(specie), intent(inout) :: sp
    integer, intent(in) :: n, c

    integer :: ierr

    if (sp% is_allocated) return

    sp% n_specie = n
    sp% charge   = c

    allocate(sp% crd(n), sp% vel(n), sp% acc(n), sp% mom(n), &
             sp% fld(n), sp% frc(n), stat=ierr)
    if (ierr /= 0) then 
       print*, 'Error: vars: alloc_specie: allocate failed'
       stop 1
    endif

    sp% is_allocated = .true.
    
  end subroutine alloc_specie 

  !========================================================
  ! add one specie to the species and set the logical flags right,
  ! also sets the "id" of the specie
  subroutine add_specie(s, sp)
    type(species), intent(inout) :: s
    type(specie),  intent(in) :: sp

    integer :: k
    logical :: done
    done = .false.

    do k = 1, s% n_species
       if (s% specie_is_added(k)) cycle
       s% plasma(k) = sp
       s% specie_is_added(k) = .true.

       sp% id = k
       sp% is_added = .true.
       sp% is_allocated = .false.

       done = .true.
       exit
    enddo

    if (.not. done) then 
       print*, 'Error: vars: add_specie: exceeded the number of allocated species'
       stop 1
    endif

  end subroutine add_specie

  !========================================================
  ! allocates the derived type species, sets the logical flag specie_is_added to false
  ! and turns is_allocated flag to true
  subroutine alloc_species(s, n)
    type(species), intent(inout) :: s
    integer, intent(in) :: n
 
    integer :: ierr !, k

    if (s% is_allocated) return

    s% n_species = n
    allocate(s% plasma(n), s% specie_is_added(n), stat=ierr)
    if (ierr /=0 ) then 
       print*, 'Error: vars: alloc_species: allocate failed'
       stop 1
    endif

    s% specie_is_added(:) = .false.
    s% is_allocated = .true.
     
  end subroutine alloc_species

  !========================================================
  
end module vars
