import 'dart:math';

import 'lib/interfaces/DatabaseRepository.dart';
import 'lib/src/category.dart';
import 'lib/src/prompt.dart';
import 'lib/src/settings.dart';
import 'lib/src/user.dart';

class Step01Settings {
  // Simuliert die UI

  final DatabaseRepository dbRep;
  final String userId;

  Settings settings = Settings.defaultValues();
  List<Category> categoriesGame = [];
  List<Prompt> promptsGame = [];

  Step01Settings(this.userId, this.dbRep);

  void initialValues() {
    settings = dbRep.getSettings(userId);

    // Aufstelung der Kategorien für das Spiel
    License license = dbRep.getUser(userId).license;
    for (var category in dbRep.getAllCategories()) {
      categoriesGame.add(category.clone());
    }
    List<Category> categoriesLicensed =
        categoriesGame
            .where((item) => item.license.index <= license.index)
            .toList();
    Random random = Random();
    for (var category in categoriesLicensed) {
      category.isLicensed = true;
      int rnd = random.nextInt(2);
      if (rnd != 3) {
        category.isSelected = true; // Passiert erst in UI; hier noch mit random
      }
    }
    promptsGame = dbRep.getPromptsInGame(userId, categoriesGame);
  }

  // Änderung in UI
}
