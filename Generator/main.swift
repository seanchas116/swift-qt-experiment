import CClang

func visitClasses(cursor: CXCursor, parent: CXCursor, clientData: CXClientData) -> CXChildVisitResult {
  let kind = clang_getCursorKind(cursor)
  if kind == CXCursor_ClassDecl {
    let name = clang_getCursorSpelling(cursor)
    print(String.fromCString(clang_getCString(name)) ?? "")
  }
  return CXChildVisit_Recurse
}

func visitDump(cursor: CXCursor, parent: CXCursor, clientData: CXClientData) -> CXChildVisitResult {
  let kindStr = clang_getCursorKindSpelling(clang_getCursorKind(cursor))
  print(String.fromCString(clang_getCString(kindStr)) ?? "")
  clang_disposeString(kindStr)
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
