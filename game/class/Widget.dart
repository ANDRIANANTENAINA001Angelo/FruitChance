import 'Case.dart';
import 'Fruit.dart';

class Widget {
  static const int DEFAULT_NUMBER_CASE = 3;

  final numberVerticalCase, numberHorizontalCase;
  List<Case> listCases = [];

  Widget(this.numberHorizontalCase, this.numberVerticalCase) {
    this.generateCases();
  }

  Widget.square(int number)
    : this.numberHorizontalCase = number,
      this.numberVerticalCase = number {
    this.generateCases();
  }

  Widget.base() : this.square(DEFAULT_NUMBER_CASE);

  void generateCases() {
    for (int i = 0; i < this.numberHorizontalCase; i++) {
      for (int j = 0; j < this.numberVerticalCase; j++) {
        Case c = new Case(i, j);
        this.listCases.add(c);
      }
    }
  }

  Case getCaseAt(int x, int y) {
    return this.listCases.firstWhere(
      (c) => c.positionHorizontale == x && c.positionVerticale == y,
      orElse: () => throw Exception("Case ($x, $y) not found"),
    );
  }

  int removeFruit(FruitType typeOfFruit) {
    int removedFruit = 0;
    for (final c in listCases) {
      if (!c.isEmpty() && c.getFruit()!.typeOfFruit == typeOfFruit) {
        c.removeFruit();
        removedFruit++;
      }
    }

    return removedFruit;
  }

  void fillRandomFruit() {
    this.listCases.forEach((c) {
      if (c.isEmpty()) {
        c.insertFruit(Fruit.random());
      }
    });
  }

  bool allFruitIsSame() {
    return this.listCases.every(
      (c) => c.getFruit()!.isSameFruit(this.listCases[0].getFruit()!),
    );
  }

  bool isExist(FruitType typeOfFruit) {
    return this.listCases.any(
      (c) => !c.isEmpty() && c.getFruit()!.typeOfFruit == typeOfFruit,
    );
  }
}
