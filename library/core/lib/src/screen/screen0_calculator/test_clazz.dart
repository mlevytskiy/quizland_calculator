base class TestClazz {
  TestClazz() {
    print("init base");
  }
  void printR(int value) {
    print("$value");
  }
}

final class Text2 extends TestClazz {}

mixin Tt {
  // void printR(double value) {
  //   print("$value");
  // }
}
