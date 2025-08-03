import 'dart:math';

final Random rng = Random();

enum FruitType { Apple, Lemon, Banana }

class Fruit {
  final FruitType typeOfFruit;

  Fruit(this.typeOfFruit);
  Fruit.base() : this.typeOfFruit = FruitType.Apple;
  Fruit.random()
    : typeOfFruit = FruitType.values[Random().nextInt(FruitType.values.length)];

  bool isSameFruit(Fruit f) {
    return this.typeOfFruit == f.typeOfFruit;
  }

  @override
  String toString() => typeOfFruit.name;
}

extension StringToFruitType on String {
  FruitType toFruit() {
    String input = this.trim().toLowerCase();
    return FruitType.values.firstWhere(
      (f) => f.name[0].toLowerCase() == input,
      orElse: () => throw Exception("Fruit inconnu : $this"),
    );
  }
}
