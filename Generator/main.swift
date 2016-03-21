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

func visitParameters(root: CXCursor) -> [Variable] {
  var parameters = [Variable]()

  visitChildren(root) { cursor, parent in
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

  return parameters
}

func visitMembers(root: CXCursor) -> [Member] {
  var members = [Member]()

  visitChildren(root) { cursor, parent in
    let kind = cursor.kind
    if kind != CXCursor_CXXMethod && kind != CXCursor_FieldDecl {
      return CXChildVisit_Recurse
    }
    if cursor.accessSpecifier == CX_CXXPrivate {
      return CXChildVisit_Continue
    }

    if kind == CXCursor_CXXMethod {
      let method = Method(
        name: cursor.description,
        parameters: visitParameters(cursor),
        returnType: cursor.type.resultType.description
      )
      print(method)
      members.append(.method(method))
    }
    if kind == CXCursor_FieldDecl {
      let variable = Variable(
        name: cursor.description,
        type: cursor.type.description
      )
      print(variable)
      members.append(.variable(variable))
    }
    return CXChildVisit_Continue
  }

  return members
}

func visitClasses(root: CXCursor) -> [Type] {
  var types = [Type]()

  visitChildren(root) { cursor, parent in
    let kind = cursor.kind
    if kind == CXCursor_ClassDecl {
      let type = Type(
        name: cursor.description,
        namespace: "",
        members: visitMembers(cursor)
      )
      types.append(type)
      print(type)
      return CXChildVisit_Continue
    }
    return CXChildVisit_Recurse
  }

  return types
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

func dumpAST() {
  visitChildren(rootCursor) { cursor, parent in
    print("\(cursor.kind): \(cursor)")
    return CXChildVisit_Recurse
  }
}

dumpAST()
visitClasses(rootCursor)

clang_disposeTranslationUnit(translationUnit)
clang_disposeIndex(index)
