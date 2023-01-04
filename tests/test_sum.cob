       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-SUM.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       01  TEST-ARRAY.
           05  FILLER OCCURS 5 TIMES.
               10  ITEM PIC 9(4) VALUE 0.

      * Declare variables for DB2 connection
       01  DB2-CONNECTION PIC X(128).
       01  DB2-HOST PIC X(64) VALUE "localhost".
       01  DB2-PORT PIC 9(5) VALUE 50000.
       01  DB2-DATABASE PIC X(64) VALUE "TOTO".
       01  DB2-USERNAME PIC X(64) VALUE "user".
       01  DB2-PASSWORD PIC X(64) VALUE "password".

      * Declare cursor for DB2 query
           EXEC SQL
               DECLARE C1 CURSOR FOR
               SELECT VALUE FROM TABLE
           END-EXEC.

       PROCEDURE DIVISION.

      * Connect to DB2 database
           STRING "CONNECT TO " DB2-DATABASE
                  " USER " DB2-USERNAME
                  " USING " DB2-PASSWORD
           INTO DB2-CONNECTION
           END-STRING
           EXEC SQL
               PREPARE S1 FROM :DB2-CONNECTION
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
      * Fetch value from DB2
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

      * Disconnect from DB2 database
           EXEC SQL
               CONNECT RESET
           END-EXEC

       STOP RUN.
