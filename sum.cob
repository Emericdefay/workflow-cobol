       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUM.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       LINKAGE SECTION.
       01  ITEM   PIC 9(4) VALUE 0.
       01  RESULT PIC 9(4) VALUE 0.

       PROCEDURE DIVISION USING ITEM.
      * Calculate sum of array elements
           ADD ITEM TO RESULT

           EXIT PROGRAM.
