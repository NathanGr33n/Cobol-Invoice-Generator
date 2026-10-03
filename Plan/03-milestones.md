# Implementation Milestones

## M1 — Skeleton
- Directory tree, Makefile, copybooks (empty structures filled)
- INVGEN opens line items, reads/echoes to console
- Compiles with cobc -x -free

## M2 — Core math
- Control break by customer ID
- Extended amount, subtotal, tax, total in working storage
- Console dump of totals

## M3 — Formatting
- INVLINES copybook
- Write INVOICES.TXT with PRD layout and form feeds

## M4 — Customer lookup
- LOADCUSTbuild indexed master
- CUSTLKUP subprogram
- Bill-to from customer record

## M5 — Validation and rejects
- VALIDATE subprogram
- REJECTS.DAT + reason codes 01–05
- Sequence check in main

## M6 — Control file and due dates
- CONTROL.DAT read/rewrite
- DATEUTIL for due date
- Sequential invoice numbers

## M7 — Summary and tests
- SUMMARY.TXT
- Sample data (3 customers, 15+ lines including rejects)
- tests/run_tests.sh + golden files
- README.md

## Verification per milestone
After each milestone: compile, run on sample data, inspect output, fix security/logic/function issues, commit.
