import 'category.dart';

// frontEnd DB
class GameSettings {
  final int nPromptsInGame; //   Anzahl der Begriffe pro Spiel
  final int nSecondsPerRound; // Anzahl Sekunden pro Spielrunde
  final int nTeams; //           Anzahl der Teams
  final List<Category>
      categoriesInGame; //       Die im Spiel zu verwendenen Kategorien

  //constructor
  GameSettings(
      {required this.nPromptsInGame,
      required this.nSecondsPerRound,
      required this.nTeams,
      required this.categoriesInGame});

      
}
