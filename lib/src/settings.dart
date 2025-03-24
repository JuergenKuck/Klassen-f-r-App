import 'category.dart';

class Settings {
  final int nPromptsInGame; //             Anzahl der Begriffe pro Spiel
  final int nSecondsPerRound; //           Anzahl Sekunden pro Spielrunde
  final int nTeams; //                     Anzahl der Teams
  final List<Category>
  categories; //       Die im Spiel zu verwendenen Kategorien

  //constructor
  Settings({
    required this.nPromptsInGame,
    required this.nSecondsPerRound,
    required this.nTeams,
    required this.categories,
  });
}
