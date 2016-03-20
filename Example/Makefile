SWIFTC = swiftc
SRC = Example.swift
SDKPATH = $(shell xcrun -sdk macosx --show-sdk-path)
SWIFTCFLAGS = -sdk $(SDKPATH) -I ../ -Xlinker -L.. -Xlinker -lSwiftQt -Xlinker -rpath -Xlinker $(PWD)/..
SWIFT_LIBS_PATH = /Library/Developer/Toolchains/swift-latest.xctoolchain/usr/lib/swift/macosx
TARGET = Example

$(TARGET): $(SRC)
	$(SWIFTC) $(SWIFTCFLAGS)  -module-name $(TARGET) $(SRC)

.PHONY: clean

clean:
	rm -f $(TARGET)
