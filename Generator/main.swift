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
}

extension CXCursorKind: CustomStringConvertible {
  public var description: String {
    return ClangString(clang_getCursorKindSpelling(self)).description
  }
}

func visitMethods(cursor: CXCursor, parent: CXCursor, clientData: CXClientData) -> CXChildVisitResult {
  let kind = cursor.kind
  if kind == CXCursor_CXXMethod {
    print("METHOD: \(cursor)")
    print("TYPE: \(cursor.type)")
  }
  return CXChildVisit_Recurse
}

func visitClasses(cursor: CXCursor, parent: CXCursor, clientData: CXClientData) -> CXChildVisitResult {
  let kind = cursor.kind
  if kind == CXCursor_ClassDecl {
    print("CLASS: \(kind)")
    clang_visitChildren(cursor, visitMethods, nil)
    return CXChildVisit_Continue
  }
  return CXChildVisit_Recurse
}

func visitDump(cursor: CXCursor, parent: CXCursor, clientData: CXClientData) -> CXChildVisitResult {
  print(cursor.kind)
  return CXChildVisit_Recurse
}

let index = clang_createIndex(0, 1)
let args = [String]()
let translationUnit = clang_createTranslationUnitFromSourceFile(
  index,
  Process.arguments[1],
  Int32(CStringArray(args).length),
  CStringArray(args).constPointers,
  0, nil
)
let rootCursor = clang_getTranslationUnitCursor(translationUnit)
clang_visitChildren(rootCursor, visitDump, nil)
clang_visitChildren(rootCursor, visitClasses, nil)

clang_disposeTranslationUnit(translationUnit)
clang_disposeIndex(index)
