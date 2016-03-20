SWIFTC = swiftc
MODULE_NAME = SwiftQt
SRC = API.swift CUtil.swift
OUTFILES = lib$(MODULE_NAME).dylib $(MODULE_NAME).swiftmodule
SDKPATH = $(shell xcrun -sdk macosx --show-sdk-path)
SWIFTCFLAGS = -sdk $(SDKPATH) -I ./CSwiftQt\
	-Xlinker -L./CSwiftQt -Xlinker -lCSwiftQt -Xlinker -rpath -Xlinker $(PWD)/CSwiftQt\
	-Xlinker -install_name -Xlinker @rpath/lib$(MODULE_NAME).dylib

all: $(OUTFILES)

lib$(MODULE_NAME).dylib: $(SRC)
	$(SWIFTC) $(SWIFTCFLAGS) -emit-library -module-name $(MODULE_NAME) -parse-as-library $(SRC)
$(MODULE_NAME).swiftmodule: $(SRC)
	$(SWIFTC) $(SWIFTCFLAGS) -emit-module -module-name $(MODULE_NAME) -parse-as-library $(SRC)

.PHONY: clean

clean:
	rm -f $(OUTFILES)
