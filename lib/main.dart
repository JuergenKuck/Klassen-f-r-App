import 'dart:async';
import 'dart:io';

import 'src/category.dart';
import 'src/settings.dart';
import 'src/team.dart';
import 'src/timer.dart';

void main() {
  clearTerminal();

  List<String> prompts = ['Tischtennis, Volleyball'];
  Catagory sports = Catagory('Sportarten',
      isLocked: false, prompts: prompts, urlImage: 'sports.jpg');
  Catagory nature = Catagory('Natur',
      isLocked: false, prompts: prompts, urlImage: 'nature.jpg');

  List<Catagory> categoriesInGame = [sports, nature];

  Settings settings = Settings(
      nPromptsInGame: 8,
      nSecondsPerRound: 120,
      nTeams: 2,
      categoriesInGame: categoriesInGame);
  Team team = Team(name: 'Team1', color: 'red', urlImage: 'team1.jpg');

  Timer timer = Timer(timeStart: 120);

  print('${settings.categoriesInGame[0].name}\n');
  print('${team.name}\n');
  print('${timer.timeStart}');
}

void clearTerminal() {
  // ANSI-Escape-Sequenz zum Löschen des Bildschirms und Zurücksetzen des Cursors
  stdout.write('\ec \x1bc');
}
