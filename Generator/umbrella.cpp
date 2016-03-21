#define Q_OBJECT static_assert("Q_OBJECT");
#define Q_PROPERTY(info) static_assert("Q_PROPERTY " #info);

using QString = int;

class QObject {};

class Test: QObject {
  Q_OBJECT
  Q_PROPERTY(QString text READ text WRITE setText)
  QString _text;
public:
  int value;

  int foo() {
    return 0;
  }
  QString bar(QString x, QString y) {
    return x + y;
  }
  QString text() {
    return _text;
  }
  void setText(QString text) {
    _text = text;
  }
};
