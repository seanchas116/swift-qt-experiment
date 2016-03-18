import CSwiftQt

class CString {
    let len: Int
    let buffer: UnsafeMutablePointer<Int8>

    init(_ string: String) {
        (len, buffer) = string.withCString {
            let len = Int(strlen($0) + 1)
            let dst = strcpy(UnsafeMutablePointer<Int8>.alloc(len), $0)
            return (len, dst)
        }
    }

    deinit {
        buffer.dealloc(len)
    }
}

class CStringArray {
    private let _strings: [CString]
    let len: Int
    let pointers: [UnsafeMutablePointer<Int8>]

    init(_ strings: [String]) {
        _strings = strings.map { CString($0) }
        len = _strings.count
        pointers = _strings.map { $0.buffer }
    }
}

class QString {
  private let ptr: COpaquePointer

  init(_ string: String) {
    let utf16s = [UInt16](string.utf16)
    ptr = QString_new(utf16s.count, utf16)
  }

  deinit {
    QString_delete(ptr)
  }
}

public class QObject {
  private let ptr: COpaquePointer

  init(ptr: COpaquePointer) {
    self.ptr = ptr
  }

  deinit {
    QObject_delete(ptr)
  }
}

public class QApplication: QObject {
  public init(args: [String]) {
    let array = CStringArray(args)
    super.init(ptr: QApplication_new(array.len, array.buffer))
  }

  public func exec() -> Int {
    return QApplication_exec(ptr)
  }
}

public class QWidget: QObject {
  public func show() {
    QWidget_show(ptr)
  }
}

public class QLabel: QObject {
  public init(text: String) {
    let qtext = QString(text)
    super.init(ptr: QLabel_new(qtext))
  }
}
