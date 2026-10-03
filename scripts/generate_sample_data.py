#!/usr/bin/env python3
"""Generate fixed-width sample input files for the COBOL invoice generator."""

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data"


def cust(cid, name, addr, city, state, zip_, terms, tax):
    tax_s = f"{int(round(tax * 10000)):05d}"
    rec = (
        f"{cid:6.6s}{name:30.30s}{addr:30.30s}{city:20.20s}"
        f"{state:2.2s}{zip_:5.5s}{terms:03d}{tax_s}"
    )
    if len(rec) != 101:
        raise ValueError(f"customer length {len(rec)} != 101")
    return rec


def line(cid, date, desc, qty, price):
    qty_s = f"{int(round(qty * 100)):07d}"
    pr_s = f"{int(round(price * 100)):07d}"
    rec = f"{cid:6.6s}{date:8.8s}{desc:40.40s}{qty_s}{pr_s}"
    if len(rec) != 68:
        raise ValueError(f"line length {len(rec)} != 68")
    return rec


def main():
    DATA.mkdir(parents=True, exist_ok=True)

    customers = [
        cust("C00001", "ACME PROPERTY MGMT", "123 MAIN ST", "TIGARD", "OR", "97223", 30, 0.0),
        cust("C00002", "RIVER CITY HOA", "800 RIVER RD", "PORTLAND", "OR", "97201", 45, 0.0),
        cust("C00003", "BEAVERTON RETAIL LLC", "4550 SW MURRAY", "BEAVERTON", "OR", "97005", 30, 0.0825),
    ]
    (DATA / "CUSTOMERS.SEQ").write_text("\n".join(customers) + "\n", encoding="ascii")

    lines = [
        line("C00001", "20260928", "RESTRIPE 40-STALL LOT", 1.00, 450.00),
        line("C00001", "20260928", "ADA SYMBOL REPAINT", 3.00, 35.00),
        line("C00001", "20260929", "WHEEL STOP REPLACE", 6.00, 42.50),
        line("C00001", "20260929", "DIRECTIONAL ARROW PAINT", 4.00, 28.00),
        line("C00001", "20260930", "CURB PAINT - YELLOW", 120.00, 1.75),
        line("C00001", "20260930", "ZERO QTY LINE", 0.00, 10.00),
        line("C00002", "20260920", "PARKING LOT FULL RESTRIPE", 1.00, 1200.00),
        line("C00002", "20260920", "FIRE LANE STENCIL", 8.00, 22.00),
        line("C00002", "20260921", "SPEED BUMP INSTALL", 2.00, 375.00),
        line("C00002", "20260921", "CROSSWALK THERMOPLASTIC", 3.00, 180.00),
        line("C00002", "20260922", "HANDICAP STALL PACKAGE", 2.00, 95.00),
        line("C00002", "20261301", "BAD DATE LINE", 1.00, 10.00),
        line("C00003", "20260915", "RETAIL LOT RESTRIPE", 1.00, 890.00),
        line("C00003", "20260915", "CART CORRAL STRIPING", 4.00, 55.00),
        line("C00003", "20260916", "STOP BAR REPAINT", 6.00, 18.50),
        line("C00003", "20260916", "NUMBER STENCIL 1-50", 50.00, 3.25),
        line("C00003", "20260917", "ENTRY LANE ARROWS", 5.00, 30.00),
    ]
    bad_num = line("C00003", "20260917", "BAD QTY LINE", 1.00, 10.00)
    bad_num = bad_num[:54] + "AAAAAAA" + bad_num[61:]
    lines.append(bad_num)
    lines.append(line("C99999", "20260910", "UNKNOWN CUSTOMER JOB", 1.00, 100.00))
    lines.append(line("C99999", "20260911", "UNKNOWN CUSTOMER JOB 2", 2.00, 50.00))
    lines.append(line("C00001", "20260930", "OUT OF SEQUENCE LINE", 1.00, 25.00))

    (DATA / "LINEITEMS.DAT").write_text("\n".join(lines) + "\n", encoding="ascii")
    control = "00014220261003\n"
    (DATA / "CONTROL.DAT.template").write_text(control, encoding="ascii")
    (DATA / "CONTROL.DAT").write_text(control, encoding="ascii")

    print(f"wrote {len(customers)} customers, {len(lines)} line items to {DATA}")


if __name__ == "__main__":
    main()
