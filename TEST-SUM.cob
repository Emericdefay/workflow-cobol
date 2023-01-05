       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-SUM.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.      
       01 DB                 POINTER.
       01 ERR                POINTER.
       01 SQLQUERY           PIC X(100).
       01 DBNAME             PIC X(08).
       01 RC                 PIC 9 COMP-5.
       01 CALLBACK USAGE PROCEDURE-POINTER.
       01 VARIABLE PIC xxxxxxxx.

      * Declare variables for SQL connection
       01  SQL-CONNECTION PIC X(128).
       01  SQL-HOST PIC X(64) VALUE "localhost".
       01  SQL-PORT PIC 9(5) VALUE 50000.
       01  SQL-DATABASE PIC X(64) VALUE "test".
       01  SQL-USERNAME PIC X(64) VALUE "user".
       01  SQL-PASSWORD PIC X(64) VALUE "password".

       01  RESULT PIC 9(4) VALUE 0.

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

           SET CALLBACK TO ADDRESS OF ENTRY "SQLITE-CALLBACK".

           MOVE "SELECT * FROM TESTTABLE;" TO SQLQUERY
           
           CALL "sqlite3_exec" USING
               BY VALUE     DB
               BY REFERENCE SQLQUERY
               BY VALUE     CALLBACK
               BY VALUE     0
               BY REFERENCE ERR
               RETURNING VARIABLE

               DISPLAY CALLBACK
      *        Call sum function
               CALL "MAIN" USING 
                               BY REFERENCE RC 
                               RETURNING    RESULT
           END-CALL
           
           DISPLAY "RESULTS: " RESULT
      * Check result
           IF RESULT NOT = 0 THEN
               DISPLAY "Test failed: invalid result"
               CALL "TEST-FAILED"
           ELSE
               DISPLAY "Test passed"
           END-IF

      * Disconnect from SQL database
           CALL "sqlite3_close" USING
               BY REFERENCE DB
           END-CALL

           STOP RUN.
