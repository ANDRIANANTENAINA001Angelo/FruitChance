import 'Fruit.dart';
import 'Widget.dart';

class GameFruitChance {
  Widget widget = Widget.base();
  int coupsUtilises = 0;
  int score = 0;
  int stars = 3;
  int coupsMax = 0;
  final int NOMBRE_COUP_PAR_CASE = 1;
  final int SCORE_PAR_FRUIT = 10;
  final int NOMBRE_ETOILE_MAX = 3;
  bool isGameOver = false;

  GameFruitChance() {
    this.coupsMax = this.widget.listCases.length * this.NOMBRE_COUP_PAR_CASE;
  }
  GameFruitChance.custom(int dimentionWidget) {
    this.widget = new Widget.square(dimentionWidget);
    this.coupsMax = this.widget.listCases.length * this.NOMBRE_COUP_PAR_CASE;
  }

  void printPretty() {
    const Map<FruitType, String> fruitIcons = {
      FruitType.Apple: '🍎',
      FruitType.Lemon: '🍋',
      FruitType.Banana: '🍌',
    };

    print('\n🌈 Plateau de jeu:\n');

    for (int i = 0; i < widget.numberVerticalCase; i++) {
      String row = '';
      for (int j = 0; j < widget.numberHorizontalCase; j++) {
        final currentCase = widget.getCaseAt(j, i);
        if (currentCase.isEmpty()) {
          row += '⬛ ';
        } else {
          final fruit = currentCase.getFruit()!;
          final emoji =
              fruitIcons[fruit.typeOfFruit] ??
              fruit.typeOfFruit.name[0].toUpperCase();
          row += '$emoji ';
        }
      }
      print(row.trim());
    }

    print('─' * 40);

    final etoiles = '⭐' * stars + '☆' * (NOMBRE_ETOILE_MAX - stars);

    if (isWin() || isGameOver) {
      print(
        '🔢 Score: $score | 💥 Coups: $coupsUtilises / $coupsMax | ⭐ Étoiles: $etoiles',
      );
    } else {
      print('🔢 Score: $score | 💥 Coups: $coupsUtilises / $coupsMax');
    }
    print(""); //espace vide
    if (this.isWin()) {
      print("🎉 Félicitations ! Tu as gagné !");
    }

    if (isGameOver) {
      print("😭 GAME OVER !!!");
    }
  }

  bool isWin() {
    return this.widget.allFruitIsSame();
  }

  void roll() {
    widget.fillRandomFruit();
  }

  void updateScore(int removedFruit) {
    coupsUtilises++;
    if (coupsUtilises == coupsMax) {
      isGameOver = true;
    }

    final double ratio = coupsUtilises / coupsMax;

    // Score de base : décrément linéairement selon l'avancement
    final int baseScore = (SCORE_PAR_FRUIT * removedFruit * (1.2 - ratio))
        .toInt()
        .clamp(1, SCORE_PAR_FRUIT * removedFruit);

    score += baseScore;

    // Bonus à la victoire : plus t’as de coups restants, plus le bonus est gros
    if (isWin()) {
      final int bonus = (SCORE_PAR_FRUIT * (coupsMax - coupsUtilises)).clamp(
        0,
        coupsMax * SCORE_PAR_FRUIT,
      );
      score += bonus;
    }

    // Mise à jour des étoiles
    if (ratio <= 0.33) {
      stars = NOMBRE_ETOILE_MAX;
    } else if (ratio <= 0.66) {
      stars = NOMBRE_ETOILE_MAX - 1;
    } else if (ratio < 1.0) {
      stars = NOMBRE_ETOILE_MAX - 2;
    } else {
      stars = 0;
    }
  }

  void play(FruitType typeOfFruit) {
    if (this.widget.isExist(typeOfFruit)) {
      int numberRemoved = this.widget.removeFruit(typeOfFruit);
      this.roll();
      this.updateScore(numberRemoved);
    } else {
      throw Exception("Type of Fruit not in Widget");
    }
  }

  static void printInfoDebutPartie() {
    print('''📋 Objectif du jeu :
🔸 Élimine tous les fruits pour n’en laisser qu’un seul type.
🔸 Plus tu fais ça en peu de coups, plus tu gagnes de points ⭐

🎯 Commandes :
  a = Apple 🍎
  b = Banana 🍌
  l = Lemon 🍋
  q = Quitter ❌

Bonne chance 🍀 et amuse-toi bien !

''');
  }
}
