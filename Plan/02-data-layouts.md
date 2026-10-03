# Data Layouts

## Customer (CUSTREC) — 101 bytes
| Field | PIC | Len |
|-------|-----|-----|
| CUST-ID | X(6) | 6 |
| CUST-NAME | X(30) | 30 |
| CUST-ADDR1 | X(30) | 30 |
| CUST-CITY | X(20) | 20 |
| CUST-STATE | X(2) | 2 |
| CUST-ZIP | X(5) | 5 |
| CUST-TERMS | 9(3) | 3 |
| CUST-TAX-RATE | 9V9999 | 5 |

Implied decimals in file images (no decimal point character).

## Line item (LINEREC) — 68 bytes
| Field | PIC | Len |
|-------|-----|-----|
| LI-CUST-ID | X(6) | 6 |
| LI-JOB-DATE | 9(8) | 8 |
| LI-DESC | X(40) | 40 |
| LI-QTY | 9(5)V99 | 7 |
| LI-UNIT-PRICE | 9(5)V99 | 7 |

## Reject (REJREC)
| Field | PIC | Notes |
|-------|-----|-------|
| REJ-REASON | X(2) | 01–05 |
| REJ-LINE | LINEREC | original bytes |

## Control record — 14 bytes
| Field | PIC | Notes |
|-------|-----|-------|
| CTRL-NEXT-INV | 9(6) | next invoice number |
| CTRL-INV-DATE | 9(8) | run invoice date YYYYMMDD |

## Sample master data (acceptance)
Three customers:
- C00001 ACME PROPERTY MGMT — Tigard OR — terms 30 — tax 0.0000
- C00002 RIVER CITY HOA — Portland OR — terms 45 — tax 0.0000
- C00003 BEAVERTON RETAIL LLC — Beaverton OR — terms 30 — tax 0.0000 (or one with non-zero tax for coverage)

Include extra line items for unknown customer C99999 and bad qty/date rows for reject coverage.

## Invoice print lines (INVLINES)
Fixed 80–96 char lines matching PRD sample:
- Company header, invoice no, date/due
- Bill-to block
- Column header + separator
- Detail: date, description, qty, price, amount
- Footer: subtotal, tax (rate%), total due
- Form feed (X'0C') between invoices
