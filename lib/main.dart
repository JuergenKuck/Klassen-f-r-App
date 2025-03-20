import 'dart:io';

import 'src/category.dart';
import 'src/game_settings.dart';
import 'src/game_team.dart';

void main() {
  clearTerminal();

  List<String> prompts = ['Tischtennis, Volleyball'];
  Category sports =
      Category('01', 'Sportarten', prompts: prompts, urlImage: 'sports.jpg');
  Category nature =
      Category('02', 'Natur', prompts: prompts, urlImage: 'nature.jpg');

  List<Category> categoriesInGame = [sports, nature];

  GameSettings settings = GameSettings(
      nPromptsInGame: 8,
      nSecondsPerRound: 120,
      nTeams: 2,
      categoriesInGame: categoriesInGame);
  GameTeam team =
      GameTeam('01', 'Team1', color: 'red', urlImage: 'team1.jpg', points: 10);

  print('${settings.categoriesInGame[0].name}\n');
  print('${team.name}\n');
}

void clearTerminal() {
  // ANSI-Escape-Sequenz zum Löschen des Bildschirms und Zurücksetzen des Cursors
  stdout.write('\ec \x1bc');
}
