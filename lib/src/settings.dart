import 'category.dart';

class Settings {
  final String userId;
  final int nPromptsInGame; //             Anzahl der Begriffe pro Spiel
  final int nSecondsPerRound; //           Anzahl Sekunden pro Spielrunde
  final int nTeams; //                     Anzahl der Teams
  final List<String> categorySelectedIds;

  //constructor
  Settings({
    required this.userId,
    required this.nPromptsInGame,
    required this.nSecondsPerRound,
    required this.nTeams,
    required this.categorySelectedIds,
  });
  Settings.defaultValues()
    : userId = '01',
      nPromptsInGame = 20,
      nSecondsPerRound = 120,
      nTeams = 2,
      categorySelectedIds = [];
}
