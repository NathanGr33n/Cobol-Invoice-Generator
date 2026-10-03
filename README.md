# COBOL Invoice Generator

Batch-oriented invoice generator in COBOL (GnuCOBOL). Reads customer and line-item flat files, calculates subtotals/tax/totals with fixed-point math, and writes print-ready invoices, a reject file, and a run summary.

## Requirements

- GnuCOBOL 3.x (`cobc`) with BDB indexed-file support
- `make`, `bash`, standard Unix tools

## Quick start

```bash
make all          # build bin/invgen and bin/loadcust
make loadcust     # build indexed data/CUSTOMERS.DAT from CUSTOMERS.SEQ
cp data/CONTROL.DAT.template data/CONTROL.DAT
bin/invgen        # write output/INVOICES.TXT, REJECTS.DAT, SUMMARY.TXT
make test         # golden-file regression
```

## Layout

```
Plan/           Implementation plans
src/            INVGEN, CUSTLKUP, DATEUTIL, VALIDATE, LOADCUST
copybooks/      Record and print-line layouts
data/           Input seeds (SEQ, LINEITEMS, CONTROL template)
output/         Runtime outputs (generated)
tests/          run_tests.sh + golden/
```

## Inputs

| File | Description |
|------|-------------|
| `data/CUSTOMERS.SEQ` | Sequential seed for customer master (101-byte fixed fields) |
| `data/CUSTOMERS.DAT` | Indexed customer master (built by `loadcust`) |
| `data/LINEITEMS.DAT` | Line items sorted by customer ID (68-byte fields) |
| `data/CONTROL.DAT` | Next invoice number (6) + run date YYYYMMDD (8) |

Monetary and quantity fields use implied decimals (no decimal point in the file).

## Outputs

| File | Description |
|------|-------------|
| `output/INVOICES.TXT` | Formatted invoices, form-feed between pages |
| `output/REJECTS.DAT` | Rejected lines with reason code prefix |
| `output/SUMMARY.TXT` | Run totals |
| `data/CONTROL.DAT` | Updated next invoice number |

## Reject codes

| Code | Meaning |
|------|---------|
| 01 | Customer ID not found |
| 02 | Non-numeric quantity or price |
| 03 | Zero or negative quantity |
| 04 | Invalid job date |
| 05 | Line item out of sequence |

## Design notes

- Free-format COBOL (`cobc -free`)
- Money in `COMP-3` with `ROUNDED` multiplies
- `FILE STATUS` checked after I/O
- Due dates via `INTEGER-OF-DATE` / `DATE-OF-INTEGER` in `DATEUTIL`
- See `Plan/` and `DevDocs/PRD.md` for full requirements
