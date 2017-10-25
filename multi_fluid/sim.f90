
program sim
  
  use vars

  implicit none

  type(species) :: fluid
  integer, parameter :: num_species = 2

  type(specie)  :: electrons
  integer, parameter :: num_electrons = 4

  type(specie)  :: protons
  integer, parameter :: num_protons = 4

  ! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  call fluid% alloc_species(fluid, num_species)

  call electrons% alloc_specie(electrons, num_electrons, -1)
  call protons%   alloc_specie(protons, num_protons, +1)

  call fluid% add_specie(fluid, electrons)
  call fluid% add_specie(fluid, protons)
  
  print*, 'Hello from sim.f90:', fluid% n_species
  print*, 'Num electrons: ', fluid% plasma(electrons% id)% n_specie

end program sim
