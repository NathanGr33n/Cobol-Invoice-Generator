# Test Plan and Quality Checks

## Golden-file tests
`tests/run_tests.sh`:
1. Reset CONTROL.DAT to known next-invoice and date
2. Rebuild indexed customers from CUSTOMERS.SEQ
3. Run `bin/invgen`
4. Diff `output/INVOICES.TXT`, `output/REJECTS.DAT`, `output/SUMMARY.TXT` against `tests/golden/`
5. Exit non-zero on any diff

## Functional cases
- Happy path: 3 invoices, correct line math and totals
- Tax-exempt (0%) and non-zero tax customer
- Unknown customer → all group lines reason 01
- Non-numeric qty/price → 02
- Zero quantity → 03
- Invalid date → 04
- Out-of-sequence customer ID → 05
- Summary grand total = sum of invoice totals
- Control file advances by number of invoices generated

## Logic checks
- No floating-point PIC
- ROUNDED on multiply/tax
- FILE STATUS after every I/O
- EOF handled without treating 10 as fatal
- Invoice not emitted for fully-rejected unknown customer groups

## Security / safety checks
- No shell execution from COBOL
- Fixed assign names under data/ and output/ only (no user-controlled paths)
- Binary/index artifacts and output/ contents gitignored where appropriate
- No secrets in sample data
- Reject file does not echo unbounded input beyond fixed record length

## Commit discipline
- Create stub file → commit
- Implement → compile/run check → commit
- Messages: short, blunt, professional; feat-> / fix-> / refactor-> prefixes
- No co-authors
