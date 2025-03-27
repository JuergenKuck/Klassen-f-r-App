import 'interfaces/DatabaseRepository.dart';
import 'game_settings.dart';

class Game {
  final String userId;
  final DatabaseRepository dbRep;

  GameSettings? gameSettings;

  Game(this.userId, this.dbRep) {
    gameSettings = GameSettings(this.userId, this.dbRep);
  }
}
