      * Invoice print line working layouts
       01  INV-PRINT-LINES.
           05  INV-BLANK-LINE        PIC X(80) VALUE SPACES.
           05  INV-COMPANY-LINE.
               10  FILLER            PIC X(25) VALUE SPACES.
               10  INV-COMPANY-NAME  PIC X(30) VALUE "HARDLINE STRIPING LLC".
               10  FILLER            PIC X(25) VALUE SPACES.
           05  INV-NUMBER-LINE.
               10  FILLER            PIC X(25) VALUE SPACES.
               10  FILLER            PIC X(12) VALUE "Invoice No: ".
               10  INV-NUMBER-OUT    PIC 9(6)  VALUE ZERO.
               10  FILLER            PIC X(37) VALUE SPACES.
           05  INV-DATE-LINE.
               10  FILLER            PIC X(25) VALUE SPACES.
               10  FILLER            PIC X(6)  VALUE "Date: ".
               10  INV-DATE-OUT      PIC X(10) VALUE SPACES.
               10  FILLER            PIC X(3)  VALUE "   ".
               10  FILLER            PIC X(5)  VALUE "Due: ".
               10  INV-DUE-OUT       PIC X(10) VALUE SPACES.
               10  FILLER            PIC X(16) VALUE SPACES.
           05  INV-BILLTO-LABEL.
               10  FILLER            PIC X(8)  VALUE "Bill To:".
               10  FILLER            PIC X(72) VALUE SPACES.
           05  INV-BILLTO-NAME.
               10  FILLER            PIC X(2)  VALUE SPACES.
               10  INV-CUST-NAME-OUT PIC X(30) VALUE SPACES.
               10  FILLER            PIC X(48) VALUE SPACES.
           05  INV-BILLTO-ADDR.
               10  FILLER            PIC X(2)  VALUE SPACES.
               10  INV-CUST-ADDR-OUT PIC X(30) VALUE SPACES.
               10  FILLER            PIC X(48) VALUE SPACES.
           05  INV-BILLTO-CSZ.
               10  FILLER            PIC X(2)  VALUE SPACES.
               10  INV-CSZ-OUT       PIC X(40) VALUE SPACES.
               10  FILLER            PIC X(38) VALUE SPACES.
           05  INV-COL-HEADER.
               10  FILLER            PIC X(80) VALUE
               "DATE        DESCRIPTION                        QTY     PRICE      AMOUNT".
           05  INV-COL-RULE.
               10  FILLER            PIC X(80) VALUE
               "----------  ---------------------------------- ------- ---------- -----------".
           05  INV-DETAIL-LINE.
               10  INV-DET-DATE      PIC X(10).
               10  FILLER            PIC X(2)  VALUE SPACES.
               10  INV-DET-DESC      PIC X(34).
               10  FILLER            PIC X(1)  VALUE SPACES.
               10  INV-DET-QTY       PIC ZZ,ZZ9.99.
               10  FILLER            PIC X(1)  VALUE SPACES.
               10  INV-DET-PRICE     PIC ZZZ,ZZ9.99.
               10  FILLER            PIC X(2)  VALUE SPACES.
               10  INV-DET-AMT       PIC Z,ZZZ,ZZ9.99.
           05  INV-SUBTOTAL-LINE.
               10  FILLER            PIC X(47) VALUE SPACES.
               10  FILLER            PIC X(10) VALUE "SUBTOTAL: ".
               10  FILLER            PIC X(2)  VALUE SPACES.
               10  INV-SUB-OUT       PIC Z,ZZZ,ZZ9.99.
           05  INV-TAX-LINE.
               10  FILLER            PIC X(47) VALUE SPACES.
               10  FILLER            PIC X(5)  VALUE "TAX (".
               10  INV-TAX-PCT-OUT   PIC ZZ9.99.
               10  FILLER            PIC X(3)  VALUE "%):".
               10  FILLER            PIC X(1)  VALUE SPACES.
               10  INV-TAX-OUT       PIC Z,ZZZ,ZZ9.99.
           05  INV-TOTAL-LINE.
               10  FILLER            PIC X(47) VALUE SPACES.
               10  FILLER            PIC X(10) VALUE "TOTAL DUE:".
               10  FILLER            PIC X(2)  VALUE SPACES.
               10  INV-TOT-OUT       PIC Z,ZZZ,ZZ9.99.
           05  INV-FORM-FEED         PIC X     VALUE X"0C".
