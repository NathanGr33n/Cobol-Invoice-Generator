# Implementation Milestones

Status: **COMPLETE** (all M1–M7 delivered; `make test` passes)

## M1 — Skeleton — DONE
- Directory tree, Makefile, copybooks
- INVGEN + subprograms compile with `cobc -x -free`

## M2 — Core math — DONE
- Control break by customer ID
- Extended amount, subtotal, tax, total via `COMP-3` + `ROUNDED`

## M3 — Formatting — DONE
- INVLINES copybook
- `INVOICES.TXT` with PRD layout and form feeds

## M4 — Customer lookup — DONE
- `LOADCUST` builds indexed master from `CUSTOMERS.SEQ`
- `CUSTLKUP` subprogram
- Bill-to from customer record

## M5 — Validation and rejects — DONE
- `VALIDATE` subprogram
- `REJECTS.DAT` + reason codes 01–05
- Sequence check in main

## M6 — Control file and due dates — DONE
- `CONTROL.DAT` read/rewrite (next inv # + run date)
- `DATEUTIL` for due date
- Sequential invoice numbers

## M7 — Summary and tests — DONE
- `SUMMARY.TXT`
- Sample data (3 customers, 21 lines including rejects)
- `tests/run_tests.sh` + golden files
- `README.md`
- `scripts/generate_sample_data.py` to regenerate seeds

## Verification
```bash
make test
```
Expected: `ALL TESTS PASSED` (3 invoices, 6 rejects, control 000142→000145)
