       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-SUM.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       01  TEST-ARRAY.
           05  FILLER OCCURS 5 TIMES.
               10  ITEM PIC 9(4) VALUE 0.

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
           EXEC SQL
               PREPARE S1 FROM :SQL-CONNECTION
           END-EXEC
           EXEC SQL
               EXECUTE S1
           END-EXEC

      * Define test to sum array elements
      * Expected result: 15
           MOVE ZERO TO ITEM.
           PERFORM VARYING ITEM FROM 1 BY 1 UNTIL ITEM > 5
      * Open cursor
           EXEC SQL
               OPEN C1
           END-EXEC
      * Fetch value from SQL
           EXEC SQL
               FETCH FROM C1 INTO :ITEM
           END-EXEC
      * Add value to array
           ADD ITEM TO TEST-ARRAY(ITEM)
      * Close cursor
           EXEC SQL
               CLOSE C1
           END-EXEC
           END-PERFORM

      * Call sum function
           CALL "SUM" USING BY REFERENCE TEST-ARRAY
           GIVING RESULT

      * Check result
           IF RESULT NOT = 15 THEN
               DISPLAY "Test failed: invalid result"
           ELSE
               DISPLAY "Test passed"
           END-IF

      * Disconnect from SQL database
           call "ocsqlite_close"
               using
                   by value db
               returning result
           end-call

           STOP RUN.
