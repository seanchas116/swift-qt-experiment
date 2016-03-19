import CClang

let index = clang_createIndex(0, 1)
let args = [String]()
let translationUnit = clang_createTranslationUnitFromSourceFile(
  index,
  "./unbrella.cpp",
  Int32(CStringArray(args).length),
  CStringArray(args).constPointers,
  0, nil
)
clang_disposeTranslationUnit(translationUnit)
