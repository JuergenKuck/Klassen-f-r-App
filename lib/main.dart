import 'dart:io';

import 'game.dart';
import 'game_settings.dart';
import 'interfaces/DatabaseRepository.dart';
import 'mockups/MockDatabaseRepository.dart';
import 'src/category.dart';
import 'src/category_user_info.dart';
import 'src/settings.dart';
import 'src/team.dart';
import 'src/user.dart';

void main() {
  clearTerminal();

  String userId = '05';

  DatabaseRepository dbRep = MockDatabaseRepository();

  Game game = Game(userId, dbRep);
  print('Ende\n');
}

void clearTerminal() {
  // ANSI-Escape-Sequenz zum Löschen des Bildschirms und Zurücksetzen des Cursors
  stdout.write('\ec \x1bc');
}
