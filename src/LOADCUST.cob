>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. LOADCUST.

*> Load sequential CUSTOMERS.SEQ into indexed CUSTOMERS.DAT

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT SEQ-FILE
        ASSIGN TO "data/CUSTOMERS.SEQ"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-SEQ-STATUS.

    SELECT IDX-FILE
        ASSIGN TO "data/CUSTOMERS.DAT"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CUST-ID
        FILE STATUS IS WS-IDX-STATUS.

DATA DIVISION.
FILE SECTION.
FD  SEQ-FILE.
01  SEQ-RECORD               PIC X(101).

FD  IDX-FILE.
    COPY "CUSTREC.cpy".

WORKING-STORAGE SECTION.
01  WS-SEQ-STATUS            PIC X(2).
01  WS-IDX-STATUS            PIC X(2).
01  WS-EOF                   PIC X VALUE "N".
    88  SEQ-EOF              VALUE "Y".
01  WS-COUNT                 PIC 9(5) VALUE 0.
01  WS-ERRORS                PIC 9(5) VALUE 0.

PROCEDURE DIVISION.
MAIN-LOGIC.
    OPEN INPUT SEQ-FILE
    IF WS-SEQ-STATUS NOT = "00"
        DISPLAY "LOADCUST: cannot open CUSTOMERS.SEQ status="
            WS-SEQ-STATUS
        MOVE 1 TO RETURN-CODE
        STOP RUN
    END-IF

    OPEN OUTPUT IDX-FILE
    IF WS-IDX-STATUS NOT = "00"
        DISPLAY "LOADCUST: cannot open CUSTOMERS.DAT status="
            WS-IDX-STATUS
        MOVE 1 TO RETURN-CODE
        STOP RUN
    END-IF

    PERFORM UNTIL SEQ-EOF
        READ SEQ-FILE
            AT END
                SET SEQ-EOF TO TRUE
            NOT AT END
                IF WS-SEQ-STATUS = "00"
                    MOVE SEQ-RECORD TO CUSTOMER-RECORD
                    WRITE CUSTOMER-RECORD
                        INVALID KEY
                            DISPLAY "LOADCUST: duplicate or bad key="
                                CUST-ID
                            ADD 1 TO WS-ERRORS
                    END-WRITE
                    IF WS-IDX-STATUS = "00"
                        ADD 1 TO WS-COUNT
                    ELSE
                        IF WS-IDX-STATUS NOT = "22"
                            DISPLAY "LOADCUST: WRITE status="
                                WS-IDX-STATUS
                            ADD 1 TO WS-ERRORS
                        END-IF
                    END-IF
                ELSE
                    DISPLAY "LOADCUST: READ status=" WS-SEQ-STATUS
                    ADD 1 TO WS-ERRORS
                END-IF
        END-READ
    END-PERFORM

    CLOSE SEQ-FILE
    CLOSE IDX-FILE

    DISPLAY "LOADCUST: loaded " WS-COUNT " customers, errors "
        WS-ERRORS

    IF WS-ERRORS > 0
        MOVE 1 TO RETURN-CODE
    ELSE
        MOVE 0 TO RETURN-CODE
    END-IF
    STOP RUN.

END PROGRAM LOADCUST.
