import CClang

struct Variable {
  let name: String
  let type: String
}

struct Method {
  let name: String
  let parameters: [Variable]
  let returnType: String
}

struct Type {
  let name: String
  let namespace: String
  let members: [Member]
}

enum Member {
  case variable(Variable)
  case method(Method)
}

class ParameterVisitor: Visitor {
  var parameters = [Variable]()
  override func visit(cursor: CXCursor, parent: CXCursor) -> CXChildVisitResult {
    let kind = cursor.kind
    if kind == CXCursor_ParmDecl {
      let param = Variable(
        name: cursor.description,
        type: cursor.type.description
      )
      parameters.append(param)
      return CXChildVisit_Continue
    }
    return CXChildVisit_Recurse
  }
}

class MemberVisitor: Visitor {
  var members = [Member]()
  override func visit(cursor: CXCursor, parent: CXCursor) -> CXChildVisitResult {
    let kind = cursor.kind
    if kind == CXCursor_CXXMethod {
      let paramVisitor = ParameterVisitor()
      paramVisitor.visitChildren(cursor)
      let method = Method(
        name: cursor.description,
        parameters: paramVisitor.parameters,
        returnType: cursor.type.resultType.description
      )
      print(method)
      members.append(.method(method))
      return CXChildVisit_Continue
    }
    if kind == CXCursor_FieldDecl {
      let variable = Variable(
        name: cursor.description,
        type: cursor.type.description
      )
      print(variable)
      members.append(.variable(variable))
    }
    return CXChildVisit_Recurse
  }
}

class ClassVisitor: Visitor {
  var types = [Type]()

  override func visit(cursor: CXCursor, parent: CXCursor) -> CXChildVisitResult {
    let kind = cursor.kind
    if kind == CXCursor_ClassDecl {
      let memberVisitor = MemberVisitor()
      memberVisitor.visitChildren(cursor)
      let type = Type(
        name: cursor.description,
        namespace: "",
        members: memberVisitor.members
      )
      types.append(type)
      print(type)
      return CXChildVisit_Continue
    }
    return CXChildVisit_Recurse
  }
}

class DumpVisitor: Visitor {
  override func visit(cursor: CXCursor, parent: CXCursor) -> CXChildVisitResult {
    print("\(cursor.kind): \(cursor)")
    return CXChildVisit_Recurse
  }
}

let index = clang_createIndex(0, 1)
let args = CStringArray(["-std=c++11"])
let translationUnit = clang_createTranslationUnitFromSourceFile(
  index,
  Process.arguments[1],
  Int32(args.length),
  args.constPointers,
  0, nil
)
let rootCursor = clang_getTranslationUnitCursor(translationUnit)

DumpVisitor().visitChildren(rootCursor)
ClassVisitor().visitChildren(rootCursor)

clang_disposeTranslationUnit(translationUnit)
clang_disposeIndex(index)
