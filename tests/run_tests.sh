#!/usr/bin/env bash
# Golden-file regression tests for COBOL Invoice Generator
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

mkdir -p output bin data

echo "==> Building"
make all

echo "==> Resetting control file"
cp data/CONTROL.DAT.template data/CONTROL.DAT

echo "==> Loading indexed customers"
bin/loadcust

echo "==> Running invgen"
bin/invgen

fail=0
for f in INVOICES.TXT REJECTS.DAT SUMMARY.TXT; do
  echo "==> Diff output/$f"
  if ! diff -u "tests/golden/$f" "output/$f"; then
    echo "FAIL: $f differs from golden"
    fail=1
  else
    echo "OK: $f"
  fi
done

# Control file must advance by number of invoices (3): 142 -> 145
expected_ctl="00014520261003"
actual_ctl="$(tr -d '\r\n' < data/CONTROL.DAT)"
echo "==> Checking CONTROL.DAT (expect $expected_ctl)"
if [[ "$actual_ctl" != "$expected_ctl" ]]; then
  echo "FAIL: CONTROL.DAT is '$actual_ctl'"
  fail=1
else
  echo "OK: CONTROL.DAT"
fi

if [[ "$fail" -ne 0 ]]; then
  echo "TESTS FAILED"
  exit 1
fi

echo "ALL TESTS PASSED"
exit 0
