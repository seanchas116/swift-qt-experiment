import CClang

class ClangString: CustomStringConvertible {
  let data: CXString
  init(_ data: CXString) {
    self.data = data
  }

  var description: String {
    return String.fromCString(clang_getCString(data)) ?? ""
  }

  deinit {
    clang_disposeString(data)
  }
}

extension CXType: CustomStringConvertible {
  public var description: String {
    return ClangString(clang_getTypeSpelling(self)).description
  }
  var resultType: CXType {
    return clang_getResultType(self)
  }
  var argumentTypes: [CXType] {
    return (0 ..< clang_getNumArgTypes(self)).map { clang_getArgType(self, UInt32($0)) }
  }
}

extension CXCursor: CustomStringConvertible {
  var type: CXType {
    return clang_getCursorType(self)
  }

  var kind: CXCursorKind {
    return clang_getCursorKind(self)
  }

  public var description: String {
    return ClangString(clang_getCursorSpelling(self)).description
  }

  var accessSpecifier: CX_CXXAccessSpecifier {
    return clang_getCXXAccessSpecifier(self)
  }
}

extension CXCursorKind: CustomStringConvertible {
  public var description: String {
    return ClangString(clang_getCursorKindSpelling(self)).description
  }
}
