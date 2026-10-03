# Completion Record

## Acceptance criteria (PRD §11)
| Criterion | Result |
|-----------|--------|
| 3 customers / ~15 line items → 3 invoices | Pass (15 valid + 6 reject rows) |
| Unknown IDs / malformed → REJECTS with codes | Pass (01,02,03,04,05) |
| SUMMARY totals = invoice totals | Pass ($5,648.01 / tax $126.51) |
| Tax correct incl. 0% exempt | Pass (C00001/C00002 0%, C00003 8.25%) |
| Golden tests pass | Pass |

## Sample invoice math checks
- C00001 subtotal: 450+105+255+112+210 = 1132.00; tax 0; due 1132.00
- C00002 subtotal: 1200+176+750+540+190 = 2856.00; tax 0; due 2856.00
- C00003 subtotal: 890+220+111+162.50+150 = 1533.50; tax 126.51; due 1660.01
- Grand: 1132+2856+1660.01 = 5648.01

## How to regenerate fixtures
```bash
python3 scripts/generate_sample_data.py
make loadcust
cp data/CONTROL.DAT.template data/CONTROL.DAT
bin/invgen
# refresh goldens only if intentional output change:
# cp output/* tests/golden/
make test
```

## Stretch goals (not in scope of this delivery)
- AR aging report
- JSON GENERATE export
- PDF/email wrapper
- Customer maintenance menu program
