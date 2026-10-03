>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. VALIDATE.

*> Validate a line-item record.
*> LS-REASON: "00" ok, "02" non-numeric qty/price,
*>            "03" zero/negative qty, "04" invalid job date
*> LS-STATUS: 0 = valid, 1 = invalid

DATA DIVISION.
WORKING-STORAGE SECTION.
01  WS-DATE-INT              PIC S9(9) COMP-5.
01  WS-JOB-DATE              PIC 9(8).

LINKAGE SECTION.
01  LS-LINE-ITEM.
    05  LS-CUST-ID           PIC X(6).
    05  LS-JOB-DATE          PIC 9(8).
    05  LS-DESC              PIC X(40).
    05  LS-QTY               PIC 9(5)V99.
    05  LS-UNIT-PRICE        PIC 9(5)V99.
01  LS-REASON                PIC X(2).
01  LS-STATUS                PIC 9.

PROCEDURE DIVISION USING LS-LINE-ITEM
                          LS-REASON
                          LS-STATUS.
MAIN-LOGIC.
    MOVE "00" TO LS-REASON
    MOVE 0 TO LS-STATUS

    *> Non-numeric quantity or unit price
    IF LS-QTY IS NOT NUMERIC
        OR LS-UNIT-PRICE IS NOT NUMERIC
        MOVE "02" TO LS-REASON
        MOVE 1 TO LS-STATUS
        GOBACK
    END-IF

    *> Zero or negative quantity (unsigned PIC cannot be negative;
    *> treat zero as invalid per PRD)
    IF LS-QTY = 0
        MOVE "03" TO LS-REASON
        MOVE 1 TO LS-STATUS
        GOBACK
    END-IF

    *> Invalid job date
    MOVE LS-JOB-DATE TO WS-JOB-DATE
    IF WS-JOB-DATE IS NOT NUMERIC
        MOVE "04" TO LS-REASON
        MOVE 1 TO LS-STATUS
        GOBACK
    END-IF

    IF WS-JOB-DATE < 16010101 OR WS-JOB-DATE > 99991231
        MOVE "04" TO LS-REASON
        MOVE 1 TO LS-STATUS
        GOBACK
    END-IF

    COMPUTE WS-DATE-INT = FUNCTION INTEGER-OF-DATE(WS-JOB-DATE)
    IF WS-DATE-INT = 0
        MOVE "04" TO LS-REASON
        MOVE 1 TO LS-STATUS
        GOBACK
    END-IF

    GOBACK.

END PROGRAM VALIDATE.
