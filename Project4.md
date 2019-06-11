
This project consists of several steps.

  1. Change the input format to a shorter, more readable form for the user. 
  This means that the lib/librang90/lodcsh2.f90 program needs to be rewritten.
  Output should also be in this shorter form.

  2. Re-organize lib/librang90 library to reflect its structure and attemp some
    documentation.

  3. Change the way angular data is stored, using a list of integrals, to
    avoid the need for sorting.

##  Algorithm for reading the short format

  1. Read the first 5 lines

  2. Read the first CSF (3 lines)
         Line 1 -- subshells and their occupation : contains at least one '('
         Line 2 -- quantum numbers for each subshell
         Line 3 -- coupling, J and parity (ends with either + or -)
         
  3. Do
       Read Next line 
        if (end of file or *)  then
            exit
        end
       if (type is LIne 1)  then
          we have a new case -- copy NEXT -> Line 1
          Read next line -> Line 2
          Read next line --> Line 3
          save information as done before
       else if (TYpe is line 3) 
          Line 1 is unchanged, save next -> Line 3
          save information and process as before
       else 
          TYpe is line 2 -- copy to line 2
          Read next line -> Line 2
          save informaton and process as before
       end if
   End Do
        
          

