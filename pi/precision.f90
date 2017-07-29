
module precision

  implicit none 

  public

  integer, parameter :: sp = selected_real_kind(p=6)
  integer, parameter :: dp = selected_real_kind(p=15)
  integer, parameter :: qp = selected_real_kind(p=33)
  integer, parameter :: hp = selected_real_kind(p=34, r=1)

  contains

  integer function check_precision() result(none)
    none = 0

    write(*,'(a,i2)') 'sp: ', sp
    write(*,'(a,i2)') 'dp: ', dp
    write(*,'(a,i2)') 'qp: ', qp
    write(*,'(a,i2)') 'hp: ', hp

  end function check_precision

end module precision