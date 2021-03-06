program main
  include "mpif.h"

  integer(kind = 4) error
  integer(kind = 4) id
  integer(kind = 4) p
  integer(kind = 4) len
  
  character*(MPI_MAX_PROCESSOR_NAME) name
  real(kind = 8) wtime

  call MPI_Init(error)
  call MPI_Comm_size(MPI_COMM_WORLD, p, error)
  call MPI_Comm_rank(MPI_COMM_WORLD, id, error)
  call MPI_GET_PROCESSOR_NAME(name, len, error)
  if (id == 0) then
     wtime = MPI_Wtime( )
     
     write( *, '(a)' ) ' '
     write( *, '(a)' ) 'HELLO_MPI - Master process: '
     write( *, '(a)' ) ' FORTRAN90/MPI Version'
     write( *, '(a)' ) ' '
     write( *, '(a)' ) ' An MPI test program.'
     write( *, '(a)' ) ' '
     write( *, '(a,i8)' )  ' The number of processes is ' , p
     write( *, '(a)' ) ' '

  end if

  print *, ' Process ',id,' on host ',name,' says Hello, world!'
 
  if (id == 0) then
     
     write( *, '(a)' ) ' '
     write( *, '(a)' ) 'HELLO_MPI - Master process: '
     write( *, '(a)' ) ' Normal end of execution: "Goodbye, world!". '
     
     wtime = MPI_Wtime( ) - wtime
     write( *, '(a)' ) ' '
     write( *, '(a,g14.6,a)' ) &
          ' Elapsed wall clock time = ', wtime, ' seconds.'
  
  end if

  call MPI_Finalize(error)

  stop

end

subroutine timestamp( )
  
  implicit none
  
  character(len = 8) ampm
  integer(kind = 4) d
  integer(kind = 4) h
  integer(kind = 4) m
  integer(kind = 4) mm
  character(len = 9), parameter, dimension(12) :: month = (/ &
      & 'January  ', 'February ', 'March    ', 'April    ', &
      & 'May      ', 'June     ', 'July     ', 'August   ', &
      & 'September', 'October  ', 'November ', 'December ' /)
  integer(kind = 4) n
  integer(kind = 4) s
  integer(kind = 4) values(8)
  integer(kind = 4) y

  call date_and_time(values = values)

  y = values(1)
  m = values(2)
  d = values(3)
  h = values(5)
  n = values(6)
  s = values(7)
  mm = values(8)
  
  if(h < 12) then
     ampm = 'AM'
  else if(h == 12) then
     if(n == 0 .and. s==0) then
        ampm = 'Noon'
     else
        ampm = 'PM'
     end if
  else
     h = h - 12
     if( h < 12 ) then
        ampm = 'PM'
     else if (h == 12) then
        if(n == 0 .and. s == 0) then
           ampm = 'Midnight'
        else
           ampm = 'AM'
        end if
     end if
  end if
  
  write( *, '(i2,1x,a,1x,i4,2x,i2,a1,i2.2,a1,i2.2,a1,i3.3,1x,a)' ) &
     &  d, trim( month(m) ), y, h, ':', n, ':', s, '.', mm, trim( ampm)

  return
end
