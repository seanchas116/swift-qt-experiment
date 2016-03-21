#define Q_OBJECT static_assert(true, "Q_OBJECT");

class Test {
  Q_OBJECT
public:
  int foo() {
    return 0;
  }
  int bar(int x, int y) {
    return x + y;
  }
};
