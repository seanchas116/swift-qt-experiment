SWIFTC = swiftc
CXX = clang++
SRC = Example.swift
SDKPATH = $(shell xcrun -sdk macosx --show-sdk-path)
SWIFTCFLAGS = -sdk $(SDKPATH) -I ../
SWIFT_LIBS_PATH = /Library/Developer/Toolchains/swift-latest.xctoolchain/usr/lib/swift/macosx
LDFLAGS = -L$(SWIFT_LIBS_PATH) -Wl,-rpath,$(SWIFT_LIBS_PATH) -L../CSwiftQt -lCSwiftQt
OUTFILES = Example Example.o

Example: Example.o
	$(CXX) $(LDFLAGS) Example.o ../API.o -o Example

Example.o: $(SRC)
	$(SWIFTC) $(SWIFTCFLAGS) -emit-object $(OPTS) $(SRC)

.PHONY: clean

clean:
	rm -f $(OUTFILES)
