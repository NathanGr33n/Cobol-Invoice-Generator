*> Customer master record layout (101 bytes)
01  CUSTOMER-RECORD.
    05  CUST-ID               PIC X(6).
    05  CUST-NAME             PIC X(30).
    05  CUST-ADDR1            PIC X(30).
    05  CUST-CITY             PIC X(20).
    05  CUST-STATE            PIC X(2).
    05  CUST-ZIP              PIC X(5).
    05  CUST-TERMS            PIC 9(3).
    05  CUST-TAX-RATE         PIC 9V9999.
