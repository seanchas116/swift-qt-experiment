SWIFTC = swiftc
TARGET = SwiftQt
LIBNAME = lib$(TARGET).dylib
SRC = API.swift CUtil.swift
OUTFILES = $(LIBNAME) $(TARGET).swiftmodule
SDKPATH = $(shell xcrun -sdk macosx --show-sdk-path)
SWIFTCFLAGS = -sdk $(SDKPATH) -I ./CSwiftQt\
	-Xlinker -L./CSwiftQt -Xlinker -lCSwiftQt -Xlinker -rpath -Xlinker $(PWD)/CSwiftQt\
	-Xlinker -install_name -Xlinker @rpath/$(LIBNAME)

all: $(OUTFILES)

$(LIBNAME): $(SRC)
	$(SWIFTC) $(SWIFTCFLAGS) -emit-library -module-name $(TARGET) -parse-as-library $(SRC)
$(TARGET).swiftmodule: $(SRC)
	$(SWIFTC) $(SWIFTCFLAGS) -emit-module -module-name $(TARGET) -parse-as-library $(SRC)

.PHONY: clean

clean:
	rm -f $(OUTFILES)
