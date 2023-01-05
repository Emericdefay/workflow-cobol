       IDENTIFICATION DIVISION.
       PROGRAM-ID. SQLITE-CALLBACK.
       DATA DIVISION. 
       WORKING-STORAGE SECTION.
       LINKAGE SECTION.
       01 COLUMN-ID         PIC 9999.
       01 COLUMN-NAME       PIC X(20).
       01 QUERY             PIC X(80).
       01 ARGC              PIC 99 COMP-5.
       01 NOTUSED           POINTER.
       01 ARGV.
           03  FIRSTCOLUMN  POINTER.
       01 AZCOLNAME         POINTER.
       PROCEDURE DIVISION USING
                                BY VALUE NOTUSED
                                BY VALUE ARGC
                                BY REFERENCE ARGV
                                BY REFERENCE AZCOLNAME.

           SET ADDRESS OF COLUMN-ID   TO FIRSTCOLUMN
           DISPLAY "COLUMN-ID : " COLUMN-ID
           GOBACK.
       END PROGRAM SQLITE-CALLBACK.
