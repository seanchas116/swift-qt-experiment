import CClang

private func visitImpl(cursor: CXCursor, parent: CXCursor, clientData: CXClientData) -> CXChildVisitResult {
  let visitor = Unmanaged<Visitor>.fromOpaque(COpaquePointer(clientData)).takeUnretainedValue()
  return visitor.visit(cursor, parent: parent)
}

typealias VisitAction = (CXCursor, CXCursor) -> CXChildVisitResult

class Visitor {
  let action: VisitAction

  init(action: VisitAction) {
    self.action = action
  }

  func visitChildren(cursor: CXCursor) {
    let selfPointer = UnsafeMutablePointer<Void>(Unmanaged.passUnretained(self).toOpaque())
    clang_visitChildren(cursor, visitImpl, selfPointer)
  }

  func visit(cursor: CXCursor, parent: CXCursor) -> CXChildVisitResult {
    return action(cursor, parent)
  }
}

func visitChildren(cursor: CXCursor, action: (CXCursor, CXCursor) -> CXChildVisitResult) {
  Visitor(action: action).visitChildren(cursor)
}
