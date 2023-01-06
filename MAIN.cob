       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN. 

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       LINKAGE SECTION.
       01 SUM-RESULT        PIC 9(5).
       01 COLUMN-ID         PIC 999.

       PROCEDURE DIVISION USING BY REFERENCE COLUMN-ID, 
                                             SUM-RESULT.
      * Calculate sum of array elements
           DISPLAY "MAIN > SUM-RESULT : " SUM-RESULT
           DISPLAY "MAIN > COLUMN-ID : "  COLUMN-ID
           ADD COLUMN-ID TO SUM-RESULT

           EXIT PROGRAM.
