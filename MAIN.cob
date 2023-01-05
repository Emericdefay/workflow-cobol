       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN. 

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       LINKAGE SECTION.
       01 COLUMN-NAME         PIC 999.
       01 SUM-RESULT        PIC 9(4) GLOBAL.

       PROCEDURE DIVISION USING BY REFERENCE COLUMN-NAME, 
                                             SUM-RESULT.
      * Calculate sum of array elements
           DISPLAY "MAIN > COLUMN-ID : " COLUMN-NAME
           ADD COLUMN-NAME TO SUM-RESULT

           EXIT PROGRAM.
