SWIFTC = xcrun -sdk macosx swiftc
CXX = clang++
SRC = Example.swift
SWIFTC_OPTS = -I ../
LINK_OPTS = -L/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/lib/swift/macosx -F//Users/seanchas116/Qt/5.6/clang_64/lib -framework QtGui -L../CSwiftQt -lCSwiftQt
OUTFILES = Example Example.o

Example: Example.o
	$(CXX) $(LINK_OPTS) Example.o ../API.o -o Example

Example.o: $(SRC)
	$(SWIFTC) $(SWIFTC_OPTS) -emit-object $(OPTS) $(SRC)

.PHONY: clean

clean:
	rm -f $(OUTFILES)
