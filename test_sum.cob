       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-SUM.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       01  TEST-ARRAY.
           05  FILLER OCCURS 5 TIMES.
               10  ITEM PIC 9(4) VALUE 0.
      
       01 DB POINTER.

      * Declare variables for SQL connection
       01  SQL-CONNECTION PIC X(128).
       01  SQL-HOST PIC X(64) VALUE "localhost".
       01  SQL-PORT PIC 9(5) VALUE 50000.
       01  SQL-DATABASE PIC X(64) VALUE "test".
       01  SQL-USERNAME PIC X(64) VALUE "user".
       01  SQL-PASSWORD PIC X(64) VALUE "password".

      * Declare cursor for SQL query
           EXEC SQL
               DECLARE C1 CURSOR FOR
               SELECT VALUE FROM TABLE
           END-EXEC.

       PROCEDURE DIVISION.

      * Connect to SQL database
           STRING "CONNECT TO " SQL-DATABASE
                  " USER " SQL-USERNAME
                  " USING " SQL-PASSWORD
           INTO SQL-CONNECTION
           END-STRING

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

           MOVE "SELECT * FROM testTable;" TO SQLQUERY
           
           CALL "sqlite3_exec" USING
               BY VALUE     DB
               BY REFERENCE SQLQUERY
               BY VALUE     CALLBACK
               BY VALUE     0
               BY REFERENCE ERR
               RETURNING RC
      *        Call sum function
               CALL "SUM" USING BY REFERENCE RC GIVING RESULT
           END-CALL

      * Check result
           IF RESULT NOT = 15 THEN
               DISPLAY "Test failed: invalid result"
           ELSE
               DISPLAY "Test passed"
           END-IF

      * Disconnect from SQL database
           CALL "sqlite3_close" USING
               BY REFERENCE DB
           END-CALL

           STOP RUN.
