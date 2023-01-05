       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN. 

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       LINKAGE SECTION.
       01  RC     PIC 9 COMP-5.
       01  RESULT PIC 9(4).

       PROCEDURE DIVISION USING 
                                RC
                          RETURNING 
                                RESULT.
      * Calculate sum of array elements
           DISPLAY "RC " RC
           ADD RC TO RESULT

           EXIT PROGRAM.
