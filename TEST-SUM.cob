       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-SUM.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.      
      * Declare variables for SQL connection
       01 DB                POINTER.
       01 ERR               POINTER.
       01 SQLQUERY          PIC X(100).
       01 DBNAME            PIC X(08).
       01 RC                PIC 9 COMP-5.
       01 CALLBACK    USAGE PROCEDURE-POINTER.
      * RESULTS
       01 SUM-RESULT        PIC 9(5) VALUE 0.

       LINKAGE SECTION.
      * SQL CALLBACK
       01 ARGC              PIC 9(2) COMP-5.
       01 NOTUSED           POINTER.
       01 ARGV.
           03  FIRSTCOLUMN  POINTER.
           03  SECONDCOLUMN POINTER.
       01 AZCOLNAME         POINTER.
      * SQL CALLBACK SELECT
       01 COLUMN-ID         PIC X(3).
       01 COLUMN-NAME       PIC X(20).

       PROCEDURE DIVISION.
           SET DB           TO NULL
           SET ERR          TO NULL

           MOVE Z"test.db" TO DBNAME

           DISPLAY "RUNNING sqlite3_open"
      * Connect to SQL database
           CALL "sqlite3_open" USING
               BY REFERENCE  DBNAME
               BY REFERENCE  DB
               RETURNING     RC
           END-CALL

           IF RC NOT = ZERO
               DISPLAY "ERROR OPENING DATABASE."
           ELSE
               DISPLAY "DATABASE OPENED."
           END-IF

           SET CALLBACK TO ADDRESS OF ENTRY "CALLBACK"

           MOVE "SELECT * FROM TESTTABLE;" TO SQLQUERY
           
           CALL "sqlite3_exec" USING
               BY VALUE     DB
               BY REFERENCE SQLQUERY
               BY VALUE     CALLBACK
               BY VALUE     0
               BY REFERENCE ERR
               RETURNING RC
           END-CALL
           
      *    CALL "MAIN" USING BY REFERENCE COLUMN-ID, SUM-RESULT

           DISPLAY "SUM-RESULT: " SUM-RESULT
      * Check result
           IF SUM-RESULT NOT = 5151 THEN
               DISPLAY "Test : SUM-RESULT"
               DISPLAY "Test failed: invalid result"
               DISPLAY "EXPECTED/GOT : 5151/" SUM-RESULT
               COMPUTE SUM-RESULT = SUM-RESULT / 0
           ELSE
               DISPLAY "Test passed"
           END-IF

      * Disconnect from SQL databaseTOTO
           CALL "sqlite3_close" USING
               BY REFERENCE DB
           END-CALL

           STOP RUN.

      ******************************************************************
       ENTRY "CALLBACK" USING   BY VALUE NOTUSED
                                BY VALUE ARGC
                                BY REFERENCE ARGV
                                BY REFERENCE AZCOLNAME.

           SET ADDRESS OF COLUMN-ID TO FIRSTCOLUMN
           SET ADDRESS OF COLUMN-NAME TO SECONDCOLUMN
           DISPLAY "SQL > COLUMN-ID   : " COLUMN-ID
      *    DISPLAY "SQL > COLUMN-NAME : " COLUMN-NAME

      *        Call sum function
           CALL "MAIN" USING BY REFERENCE COLUMN-ID, 
                             BY REFERENCE SUM-RESULT

           GOBACK.
