       IDENTIFICATION DIVISION.
       PROGRAM-ID. SQLITE-CALLBACK.
       DATA DIVISION. 
       WORKING-STORAGE SECTION.
       LINKAGE SECTION.
       01 COLUMN-ID         PIC 99.
       01 COLUMN-NAME       PIC X(20).
       01 ARGC              PIC 99 COMP-5.
       01 NOTUSED           POINTER.
       01 ARGV.
          03  FIRSTCOLUMN   POINTER.
          03  SECONDCOLUMN  POINTER.
       01 AZCOLNAME         POINTER.
       PROCEDURE DIVISION USING
      *                         BY VALUE NOTUSED
      *                         BY VALUE ARGC
                               BY REFERENCE ARGV
                               BY REFERENCE AZCOLNAME
                               RETURNING ARGV.

           SET ADDRESS OF COLUMN-ID   TO FIRSTCOLUMN
           SET ADDRESS OF COLUMN-NAME TO SECONDCOLUMN
       
           DISPLAY COLUMN-ID "|" COLUMN-NAME
             
           GOBACK.
       END PROGRAM SQLITE-CALLBACK.
