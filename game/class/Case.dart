import 'Fruit.dart';

class Case {
  final int positionVerticale;
  final int positionHorizontale;

  Fruit? _fruit = Fruit.random();

  Case(this.positionHorizontale, this.positionVerticale);
  Case.origin() : this.positionHorizontale = 0, this.positionVerticale = 0;

  Case.samePosition(int position)
    : this.positionHorizontale = position,
      this.positionVerticale = position;

  bool isEmpty() {
    if (this._fruit == null) {
      return true;
    }
    return false;
  }

  Fruit? getFruit() {
    if (!this.isEmpty()) {
      return this._fruit;
    } else {
      throw Exception("This case is empty, has no fruit.");
    }
  }

  void insertFruit(Fruit f) {
    if (!this.isEmpty()) {
      throw Exception("This case has already fruit : ${this._fruit}");
    }

    this._fruit = f;
  }

  void removeFruit() {
    this._fruit = null;
  }
}
