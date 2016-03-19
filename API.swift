import CSwiftQt
import Darwin

class QString {
  let ptr: UnsafeMutablePointer<Void>

  init(_ string: String) {
    let utf16s = [UInt16](string.utf16)
    ptr = QString_new(Int32(utf16s.count), UnsafeMutablePointer(utf16s))
  }

  deinit {
    QString_delete(ptr)
  }
}

public class QObject {
  let ptr: UnsafeMutablePointer<Void>

  init(ptr: UnsafeMutablePointer<Void>) {
    self.ptr = ptr
  }

  deinit {
    QObject_delete(ptr)
  }
}

public class QApplication: QObject {
  public init(args: [String]) {
    let array = CStringArray(args)
    super.init(ptr: QApplication_new(Int32(array.length), UnsafeMutablePointer(array.pointers)))
  }

  public func exec() -> Int {
    return Int(QApplication_exec(ptr))
  }
}

public class QWidget: QObject {
  public func show() {
    QWidget_show(ptr)
  }
}

public class QLabel: QWidget {
  public init(text: String) {
    let qtext = QString(text)
    super.init(ptr: QLabel_new(qtext.ptr))
  }
}
