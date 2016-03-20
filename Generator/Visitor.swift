import CClang

private func visitImpl(cursor: CXCursor, parent: CXCursor, clientData: CXClientData) -> CXChildVisitResult {
  let visitor = Unmanaged<Visitor>.fromOpaque(COpaquePointer(clientData)).takeUnretainedValue()
  return visitor.visit(cursor, parent: parent)
}

class Visitor {
  func visitChildren(cursor: CXCursor) {
    let selfPointer = UnsafeMutablePointer<Void>(Unmanaged.passUnretained(self).toOpaque())
    clang_visitChildren(cursor, visitImpl, selfPointer)
  }

  func visit(cursor: CXCursor, parent: CXCursor) -> CXChildVisitResult {
    return CXChildVisit_Recurse
  }
}
