# COBOL Invoice Generator — GnuCOBOL build

COBC     := cobc
COBFLAGS := -x -free -I copybooks -Wall
BINDIR   := bin
SRC      := src

.PHONY: all clean test loadcust dirs

all: dirs $(BINDIR)/invgen $(BINDIR)/loadcust

dirs:
	mkdir -p $(BINDIR) output data

$(BINDIR)/invgen: $(SRC)/INVGEN.cob $(SRC)/CUSTLKUP.cob \
		$(SRC)/DATEUTIL.cob $(SRC)/VALIDATE.cob \
		copybooks/CUSTREC.cpy copybooks/LINEREC.cpy \
		copybooks/REJREC.cpy copybooks/INVLINES.cpy
	$(COBC) $(COBFLAGS) -o $@ $(SRC)/INVGEN.cob \
		$(SRC)/CUSTLKUP.cob $(SRC)/DATEUTIL.cob $(SRC)/VALIDATE.cob

$(BINDIR)/loadcust: $(SRC)/LOADCUST.cob copybooks/CUSTREC.cpy
	$(COBC) $(COBFLAGS) -o $@ $(SRC)/LOADCUST.cob

loadcust: $(BINDIR)/loadcust
	$(BINDIR)/loadcust

test: all
	./tests/run_tests.sh

clean:
	rm -f $(BINDIR)/invgen $(BINDIR)/loadcust
	rm -f output/INVOICES.TXT output/REJECTS.DAT output/SUMMARY.TXT
	rm -f data/CUSTOMERS.DAT data/CUSTOMERS.DAT.lck
