SWIFTC = swiftc
SRC = CXUtil.swift Visitor.swift main.swift ../CUtil.swift
SDKPATH = $(shell xcrun -sdk macosx --show-sdk-path)
CLANG_INCLUDE = /Library/Developer/Toolchains/swift-latest.xctoolchain/usr/local/include
CLANG_LIBS = /Library/Developer/Toolchains/swift-latest.xctoolchain/usr/lib
SWIFTCFLAGS = -sdk $(SDKPATH) -Xcc "-I$(CLANG_INCLUDE)" -Xlinker -L$(CLANG_LIBS) -Xlinker -lclang -Xlinker -rpath -Xlinker $(CLANG_LIBS) -I ./CClang
TARGET = Generator

$(TARGET): $(SRC)
	$(SWIFTC) $(SWIFTCFLAGS)  -module-name $(TARGET) $(SRC)

.PHONY: clean

clean:
	rm -f $(TARGET)
