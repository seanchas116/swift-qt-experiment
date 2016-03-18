SWIFTC = xcrun -sdk macosx swiftc
MODULE_NAME = SwiftQt
SRC = API.swift
OPTS = -I ./CSwiftQt
OUTFILES = $(MODULE_NAME).o $(MODULE_NAME).swiftmodule

all: $(OUTFILES)

$(MODULE_NAME).o: $(SRC)
	$(SWIFTC) $(OPTS) -emit-object -module-name $(MODULE_NAME) -parse-as-library $(SRC)
$(MODULE_NAME).swiftmodule: $(SRC)
	$(SWIFTC) $(OPTS) -emit-module -module-name $(MODULE_NAME) -parse-as-library $(SRC)

.PHONY: clean

clean:
	rm -f $(OUTFILES)
