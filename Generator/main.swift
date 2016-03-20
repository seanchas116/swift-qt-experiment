import CClang

func visit(cursor: CXCursor, parent: CXCursor, clientData: CXClientData) -> CXChildVisitResult {
  let name = clang_getCursorSpelling(cursor)
  print(String.fromCString(clang_getCString(name)) ?? "")
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
clang_visitChildren(rootCursor, visit, nil)

clang_disposeTranslationUnit(translationUnit)
clang_disposeIndex(index)
