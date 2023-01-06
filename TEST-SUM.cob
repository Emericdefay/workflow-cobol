       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-SUM.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.      
      * Declare variables for SQL connection
       01 DB                 POINTER.
       01 ERR                POINTER.
       01 SQLQUERY           PIC X(100).
       01 DBNAME             PIC X(08).
       01 RC                 PIC 9 COMP-5.
       01 CALLBACK           PROCEDURE-POINTER.

       LINKAGE SECTION.
       01 Column-id         PIC 999.
       01 Column-Name       PIC X(20).
       01 argv.
           03  firstColumn   pointer.
           03  secondColumn  pointer.

       01 azColName          pointer.
       01 argc               pic 99 comp-5.
       01 notused            pointer.

      * RESULTS
       01  SUM-RESULT        PIC 9(4) VALUE 0 GLOBAL.

       PROCEDURE DIVISION.
           SET DB         TO NULL
           SET ERR        TO NULL

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

           SET CALLBACK TO ADDRESS OF ENTRY "SQLITE-CALLBACK"

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
           IF SUM-RESULT NOT = 5050 THEN
               DISPLAY "Test failed: invalid result"
               CALL "TEST-FAILED"
           ELSE
               DISPLAY "Test passed"
           END-IF

      * Disconnect from SQL databaseTOTO
           CALL "sqlite3_close" USING
               BY REFERENCE DB
           END-CALL

           STOP RUN.
