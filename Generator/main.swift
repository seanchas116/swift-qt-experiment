import CClang

class MethodVisitor: Visitor {
  override func visit(cursor: CXCursor, parent: CXCursor) -> CXChildVisitResult {
    let kind = cursor.kind
    if kind == CXCursor_CXXMethod {
      print("METHOD: \(cursor)")
      print("TYPE: \(cursor.type)")
    }
    return CXChildVisit_Recurse
  }
}

class ClassVisitor: Visitor {
  override func visit(cursor: CXCursor, parent: CXCursor) -> CXChildVisitResult {
    let kind = cursor.kind
    if kind == CXCursor_ClassDecl {
      print("CLASS: \(kind)")
      MethodVisitor().visitChildren(cursor)
      return CXChildVisit_Continue
    }
    return CXChildVisit_Recurse
  }
}

class DumpVisitor: Visitor {
  override func visit(cursor: CXCursor, parent: CXCursor) -> CXChildVisitResult {
    print(cursor.kind)
    return CXChildVisit_Recurse
  }
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

DumpVisitor().visitChildren(rootCursor)
ClassVisitor().visitChildren(rootCursor)

clang_disposeTranslationUnit(translationUnit)
clang_disposeIndex(index)
