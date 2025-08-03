import 'class/Fruit.dart';
import 'class/GameFruitChance.dart';
import 'dart:io';

import 'class/Widget.dart';

void main(List<String> args) {
  GameFruitChance.printInfoDebutPartie();
  final niveau = demanderNiveau();
  final taille = (niveau * Widget.DEFAULT_NUMBER_CASE);
  final game = GameFruitChance.custom(taille);

  while (!game.isWin() && !game.isGameOver) {
    game.printPretty(); // améliore cette fonction pour l’affichage stylé ci-dessous
    FruitType? fruit = demanderFruit();
    // 👉 L'utilisateur veut quitter
    if (fruit == null) {
      print("👋 Partie quittée.");
      return;
    }

    while (fruit == null || !game.widget.isExist(fruit)) {
      print("❌ Type fruit saisie invalid, réessayé ! ");
      fruit = demanderFruit();
      // 👉 L'utilisateur veut quitter
      if (fruit == null) {
        print("👋 Partie quittée.");
        return;
      }
    }
    game.play(fruit);
  }

  game.printPretty();
}

/// Demande et retourne un niveau de 1 à 5
int demanderNiveau() {
  const niveaux = {
    1: 'Débutant',
    2: 'Intermédiaire',
    3: 'Avancé',
    4: 'Expert',
    5: 'Sénior',
  };

  int? niveau;
  do {
    print(
      "Choisir niveau : ${niveaux.entries.map((e) => '${e.key} => ${e.value}').join(', ')}",
    );
    stdout.write("Votre choix : ");
    final input = stdin.readLineSync();
    niveau = int.tryParse(input ?? "");
  } while (niveau == null || !niveaux.containsKey(niveau));
  print("");
  return niveau;
}

/// Demande un fruit à supprimer
FruitType? demanderFruit() {
  final prompt =
      FruitType.values
          .map((e) => '${e.name[0].toLowerCase()} = ${e.name}')
          .join(', ') +
      ', q = quitter';
  print("Quel fruit veux-tu retirer ? $prompt");
  stdout.write("Tape la lettre ou le nom du fruit : ");

  final input = stdin.readLineSync()?.trim().toLowerCase();
  if (input == null || input.isEmpty) {
    print("❌ Entrée vide. Réessaie.");
    print("");
    return demanderFruit();
  }
  if (input == 'q') {
    print("👋 Partie quittée.");
    return null;
  }

  try {
    print("");
    return input.toFruit();
  } catch (_) {
    print("⚠️ Fruit inconnu. Réessaie.");
    print("");
    return demanderFruit();
  }
}
