*> Reject record: reason code + original line item
01  REJECT-RECORD.
    05  REJ-REASON            PIC X(2).
    05  REJ-LINE-ITEM.
        10  REJ-CUST-ID       PIC X(6).
        10  REJ-JOB-DATE      PIC 9(8).
        10  REJ-DESC          PIC X(40).
        10  REJ-QTY           PIC 9(5)V99.
        10  REJ-UNIT-PRICE    PIC 9(5)V99.
