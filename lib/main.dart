import 'dart:io';

import 'game.dart';

import 'interfaces/DatabaseRepository.dart';
import 'mockups/MockDatabaseRepository.dart';

void main() {
  clearTerminal();

  String userId = '05';

  DatabaseRepository dbRep = MockDatabaseRepository();

  Game game = Game(userId, dbRep);
  game.run();

  print('Ende\n');
}

void clearTerminal() {
  // ANSI-Escape-Sequenz zum Löschen des Bildschirms und Zurücksetzen des Cursors
  stdout.write('\ec \x1bc');
}
