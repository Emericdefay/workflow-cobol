       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN. 

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       LINKAGE SECTION.
       01  NUM    PIC 9(4) VALUE 0.
       01  RESULT PIC 9(4) VALUE 0.

       PROCEDURE DIVISION USING 
                                NUM
                          RETURNING 
                                RESULT.
      * Calculate sum of array elements
           ADD NUM TO RESULT

           EXIT PROGRAM.
