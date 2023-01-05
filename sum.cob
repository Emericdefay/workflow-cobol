       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUM.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       LINKAGE SECTION.
       01  NUM    PIC 9(4) VALUE 0.
       01  RESULT PIC 9(4) VALUE 0.

       PROCEDURE DIVISION USING 
                                NUM
                          GIVING 
                                RESULT.
      * Calculate sum of array elements
           ADD NUM TO RESULT

           EXIT PROGRAM.
