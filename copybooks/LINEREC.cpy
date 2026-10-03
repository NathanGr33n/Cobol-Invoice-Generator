*> Line item input record layout (68 bytes)
01  LINE-ITEM-RECORD.
    05  LI-CUST-ID            PIC X(6).
    05  LI-JOB-DATE           PIC 9(8).
    05  LI-DESC               PIC X(40).
    05  LI-QTY                PIC 9(5)V99.
    05  LI-UNIT-PRICE         PIC 9(5)V99.
