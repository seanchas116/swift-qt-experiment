SWIFTC = swiftc
MODULE_NAME = SwiftQt
SRC = API.swift
OUTFILES = $(MODULE_NAME).o $(MODULE_NAME).swiftmodule
SDKPATH = $(shell xcrun -sdk macosx --show-sdk-path)
SWIFTCFLAGS = -sdk $(SDKPATH) -I ./CSwiftQt

all: $(OUTFILES)

$(MODULE_NAME).o: $(SRC)
	$(SWIFTC) $(SWIFTCFLAGS) -emit-object -module-name $(MODULE_NAME) -parse-as-library $(SRC)
$(MODULE_NAME).swiftmodule: $(SRC)
	$(SWIFTC) $(SWIFTCFLAGS) -emit-module -module-name $(MODULE_NAME) -parse-as-library $(SRC)

.PHONY: clean

clean:
	rm -f $(OUTFILES)
