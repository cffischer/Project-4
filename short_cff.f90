!***********************************************************************
!                                                                      *
      PROGRAM short_to_normal
!-----------------------------------------------
!                                                                      *
!   Program for changing the format for the expasion from the new      *
!   foramt to the old format                                           *
!                                                                      *
!***********************************************************************

!-----------------------------------------------
!   I n t e r f a c e   B l o c k s
!-----------------------------------------------
      IMPLICIT NONE
!-----------------------------------------------
!   L o c a l   P a r a m e t e r s
!-----------------------------------------------
      integer, parameter :: fil_1 = 1 
      integer, parameter :: fil_2 = 2
      CHARACTER :: FILNAM*256 
!-----------------------------------------------
!   L o c a l   V a r i a b l e s
!-----------------------------------------------

      CHARACTER(LEN=256) :: pl1,pl2,pl3,cl1,cl2,cl3
      CHARACTER(LEN=256) :: line1,line2,line3,line4,line5
      INTEGER            :: IOS,ncsf(100),nblock,i
      CHARACTER(LEN=5)   :: Jblock(100)
      CHARACTER(LEN=1)   :: ch
       
!-----------------------------------------------


       
      print *, "Input file: list with shortened CSFs"
      read(*,'(a)') FILNAM
      
      open(unit=fil_1, file=FILNAM, status='old', position='asis') 
      open(unit=fil_2, file='rcsf.out', status='unknown', position='asis') 
      
      ncsf = 0 

!     The first five lines are copied from input to output
     
      read(fil_1,'(A)')line1
      read(fil_1,'(A)')line2
      read(fil_1,'(A)')line3
      read(fil_1,'(A)')line4
      read(fil_1,'(A)')line5

      write(fil_2,'(A)')trim(line1)
      write(fil_2,'(A)')trim(line2)
      write(fil_2,'(A)')trim(line3)
      write(fil_2,'(A)')trim(line4)
      write(fil_2,'(A)')trim(line5)

!     Start collecting the CSFs defined by three lines.
!     We have pl1, pl2, pl3 as the previous three lines for long format
!             cl1, cl2, cl3 as current lines from short input format

      do
         read (fil_1, '(A)', IOSTAT=IOS) cl1
         if (IOS == 0) then                            
!           .. end of file has not been encountered
	    if(cl1(1:2).ne.' *')then
!              .. end of block has not been encountered
               ch = cl1(len_trim(cl1):len_trim(cl1))
               if(ch .eq.'+'.or. ch .eq.'-')then
                  pl3=cl1
               else
	          read (fil_1, '(A)', IOSTAT=IOS) cl2
                  ch = cl2(len_trim(cl2):len_trim(cl2))
                  if(ch .eq.'+'.or. ch .eq.'-')then
                     pl2=cl1
                     pl3=cl2
		  else
                     read (fil_1, '(A)', IOSTAT=IOS) cl3
                     ch = cl3(len_trim(cl3):len_trim(cl3))
                     if(ch .eq.'+'.or. ch .eq.'-')then
                        pl1=cl1
                        pl2=cl2
                        pl3=cl3
		     endif    
		  endif    
               endif
            else 
!              .. the block has ended
               write(fil_2,'(A)')trim(cl1)
            endif
         else
!           .. end of file has been encountered.
            exit
         endif
!        .. a new CSF has been found 
         write(fil_2,'(A)')trim(pl1)
	 write(fil_2,'(A)')trim(pl2)
	 write(fil_2,'(A)')trim(pl3)
      enddo

end 
