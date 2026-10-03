# COBOL Invoice Generator — Implementation Plan

## Problem
Build a batch-oriented COBOL invoice generator that reads customer and line-item flat files, computes subtotals/tax/totals with fixed-point math, and writes print-ready invoices, rejects, and a summary report.

## Goals
- Idiomatic COBOL: copybooks, paragraphs, PICTURE clauses, FILE STATUS checks
- Accurate COMP-3 / ROUNDED monetary math (no floating point)
- Graceful rejects instead of abends
- Small, testable codebase with golden-file tests

## Non-Goals
No GUI, DB, PDF, payments, or multi-currency.

## Environment
- Compiler: GnuCOBOL 3.1.2 (`cobc`) — available; indexed handler = BDB
- Build: `make` + `cobc -x -free`
- Source format: **free-format** (friendlier editors; still idiomatic structure)
- OS sort assumed for line-item input order; runtime also rejects out-of-sequence (code 05)

## Deliverable layout
Matches PRD section 8:
```
src/ INVGEN.cob CUSTLKUP.cob DATEUTIL.cob VALIDATE.cob
copybooks/ CUSTREC.cpy LINEREC.cpy INVLINES.cpy REJREC.cpy
data/ CUSTOMERS.DAT LINEITEMS.DAT CONTROL.DAT (+ loader input)
output/ INVOICES.TXT REJECTS.DAT SUMMARY.TXT
tests/ run_tests.sh golden/
Makefile README.md
```

## Design decisions
1. **Free-format source** compiled with `-free`.
2. **Customer master = INDEXED** (BDB) via `LOADCUST.cob` from sequential seed `CUSTOMERS.SEQ`.
3. **CONTROL.DAT** holds next invoice number (6) + invoice run date (8) so tests are repeatable.
4. **Paths**: relative `data/` and `output/` from working directory (run from repo root).
5. **Subprograms** via `CALL` with explicit LINKAGE; FILE STATUS checked after every I/O.
6. **Reject codes** per PRD: 01–05.

## Success criteria (acceptance)
- 3 customers / ~15 line items → 3 correct invoices
- Bad IDs and malformed rows → REJECTS.DAT with correct codes; run continues
- SUMMARY.TXT totals match invoice totals
- 0% tax for exempt customers
- `tests/run_tests.sh` passes vs golden files
