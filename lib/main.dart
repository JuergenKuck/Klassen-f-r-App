import 'dart:io';

import 'src/category.dart';
import 'src/settings.dart';
import 'src/team.dart';

void main() {
  clearTerminal();

  List<String> prompts = ['Tischtennis, Volleyball'];
  Category sports = Category(
    '01',
    'Sportarten',
    prompts: prompts,
    urlImage: 'sports.jpg',
    isLocked: true,
  );
  Category nature = Category(
    '02',
    'Natur',
    prompts: prompts,
    urlImage: 'nature.jpg',
    isLocked: true,
  );

  List<Category> categoriesInGame = [sports, nature];

  Settings settings = Settings(
    nPromptsInGame: 8,
    nSecondsPerRound: 120,
    nTeams: 2,
    categories: categoriesInGame,
  );
  Team team = Team(
    '01',
    'Team1',
    color: 'red',
    urlImage: 'team1.jpg',
    points: 10,
  );

  print('${settings.categories[0].name}\n');
  print('${team.name}\n');
}

void clearTerminal() {
  // ANSI-Escape-Sequenz zum Löschen des Bildschirms und Zurücksetzen des Cursors
  stdout.write('\ec \x1bc');
}
