import Darwin

class CString {
    let length: Int
    let pointer: UnsafeMutablePointer<Int8>
    var constPointer: UnsafePointer<Int8> {
      return UnsafePointer(pointer)
    }

    init(_ string: String) {
        (length, pointer) = string.withCString {
            let len = Int(strlen($0) + 1)
            let dst = strcpy(UnsafeMutablePointer<Int8>.alloc(len), $0)
            return (len, dst)
        }
    }

    deinit {
        pointer.dealloc(length)
    }
}

class CStringArray {
    let strings: [CString]
    var length: Int {
      return strings.count
    }
    var pointers: [UnsafeMutablePointer<Int8>] {
      return strings.map { $0.pointer }
    }
    var constPointers: [UnsafePointer<Int8>] {
      return strings.map { $0.constPointer }
    }

    init(_ strings: [String]) {
        self.strings = strings.map { CString($0) }
    }
}
