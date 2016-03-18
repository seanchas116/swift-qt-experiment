import SwiftQt

let app = QApplication(args: Process.arguments)
let label = QLabel(text: "Hello, world!")
label.show()
app.exec()
