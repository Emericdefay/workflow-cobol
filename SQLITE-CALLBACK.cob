       IDENTIFICATION DIVISION.
       PROGRAM-ID. SQLITE-CALLBACK.
       DATA DIVISION. 
       WORKING-STORAGE SECTION.
       LINKAGE SECTION.
       01 COLUMN-ID         PIC 9(4).
       01 COLUMN-NAME       PIC 9(4).
       01 SUM-RESULT        PIC 9(4) GLOBAL.
       01 QUERY             PIC X(80).
       01 ARGC              PIC 99 COMP-5.
       01 NOTUSED           POINTER.
       01 ARGV.
           03  FIRSTCOLUMN  POINTER.
           03  SECONDCOLUMN  POINTER.
       01 AZCOLNAME         POINTER.

       PROCEDURE DIVISION USING
                                BY VALUE NOTUSED
                                BY VALUE ARGC
                                BY REFERENCE ARGV
                                BY REFERENCE AZCOLNAME.

           SET ADDRESS OF COLUMN-ID TO FIRSTCOLUMN
           SET ADDRESS OF COLUMN-NAME TO SECONDCOLUMN
           DISPLAY "SQL > COLUMN-ID : " COLUMN-NAME

      *        Call sum function
           CALL "MAIN" USING BY REFERENCE COLUMN-NAME, SUM-RESULT

           GOBACK.
       END PROGRAM SQLITE-CALLBACK.
