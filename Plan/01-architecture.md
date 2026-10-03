# Architecture

## Program roles
| Program | Role |
|---------|------|
| `INVGEN.cob` | Main driver: open files, control-break by customer, print invoices, summary, rewrite control |
| `CUSTLKUP.cob` | Random READ of indexed customer master by ID |
| `DATEUTIL.cob` | Due date = invoice date + terms using INTEGER-OF-DATE / DATE-OF-INTEGER |
| `VALIDATE.cob` | Line-item field validation; returns reason code |
| `LOADCUST.cob` | Build helper: load CUSTOMERS.SEQ → indexed CUSTOMERS.DAT |

## Main control flow
```
OPEN files
READ control (next invoice #, run date)
READ first line item
PERFORM UNTIL EOF line items
    SAVE customer ID
    CALL CUSTLKUP
    IF not found: reject remaining lines in group (01), skip invoice
    ELSE
        PRINT header (invoice #, dates, bill-to)
        PERFORM UNTIL ID changes OR EOF
            IF ID < previous ID: reject 05
            CALL VALIDATE
            IF invalid: write reject
            ELSE: extend amount, print detail, add subtotal
            READ next line
        END-PERFORM
        COMPUTE tax ROUNDED, total
        PRINT footer
        bump invoice #, add run totals
    END-IF
END-PERFORM
WRITE summary
REWRITE control
CLOSE files
```

## File I/O
| File | Org | Record |
|------|-----|--------|
| data/CUSTOMERS.DAT | INDEXED, KEY CUST-ID | CUSTREC (101 bytes) |
| data/CUSTOMERS.SEQ | SEQUENTIAL seed | same layout |
| data/LINEITEMS.DAT | SEQUENTIAL | LINEREC (68 bytes) |
| data/CONTROL.DAT | SEQUENTIAL | 14 bytes (inv# + date) |
| output/INVOICES.TXT | SEQUENTIAL line sequential | print lines |
| output/REJECTS.DAT | SEQUENTIAL | REJREC |
| output/SUMMARY.TXT | SEQUENTIAL line sequential | report lines |

## Money math
- Working fields: `PIC S9(7)V99 COMP-3` (and wider for grand totals)
- Extended amount: `qty * price ROUNDED`
- Tax: `subtotal * tax-rate ROUNDED`
- Display with edited pictures (`$$,$$$,$$9.99` / `Z,ZZZ,ZZ9.99` style per layout)

## Error handling
- After every OPEN/READ/WRITE/REWRITE/CLOSE: check FILE STATUS
- `00`/`10` (EOF on READ) expected; anything else → display message and STOP RUN with non-zero status
- Validation failures never abort the batch

## Build
```
cobc -x -free -I copybooks -o bin/invgen src/INVGEN.cob src/CUSTLKUP.cob src/DATEUTIL.cob src/VALIDATE.cob
cobc -x -free -I copybooks -o bin/loadcust src/LOADCUST.cob
```
