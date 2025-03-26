import '../src/category.dart';
import '../src/prompt.dart';
import '../src/category_user_info.dart';
import '../src/game_prompt_info.dart';
import '../src/settings.dart';
import '../src/user.dart';
import '../src/team.dart';

abstract class DatabaseRepository {
  // User: der die App installiert hat
  void sendUser(User user);
  User getUser(String userId);

  // Setting; Spieleinstellungen
  void sendSettings(Settings settings);
  Settings getSettings(String userId);

  void sendCategoryUserInfos(
    String userId,
    List<CategoryUserInfo> categoryUserInfos,
  );
  List<CategoryUserInfo> getCategoryUserInfos(String userId);

  // Category:

  // Alle in DB gespeicherten Kategorien; Die Kategorien für das Spiel;
  List<Category> getAllCategories();

  // Die vom User in der UI (Settings) ausgewählten Kategorien
  //List<Category> getCategoriesSettings(String userId);

  // Prompt:

  // Die im Spiel zu erratenen Begriffe; Es wird aus den Kategorien gewählt,
  // die in der UI selektiert wurden (Settings).
  // für das Spiel und die vorgegebene Anzahl der Begriffe zufällig ausgewählt
  // (Settings).
  List<Prompt> getNewGamePrompts(String userId);

  // Hier werden die Begriffinfos für das Spiel geladen,
  // ohne team.number und team.isSolved, weil diese sich erst beim Spiel ergeben.
  List<GamePromptInfo> getNewGamePromptInfos(
    String userId,
    List<Prompt> promptsInGame,
  );

  // Hier werden die BegriffInfos nochmals für das Spiel geladen,
  // ohne team.number und team.isSolved, weil diese sich erst beim Spiel ergeben.
  List<GamePromptInfo> getGamePromptInfos(String userId);

  // Hier werden nach jeder Runde die in dieser Runde behandelten BegriffInfos
  // (aus UI) gesendet. wird benötigt, weil hiervon die Team.points abhängen
  void sendEndRoundPromptInfos(
    String userId, {
    required int teamNumber,
    required List<GamePromptInfo> roundPromptInfos,
  });

  // Hier werden die PromptInfos für eine neuer Runde mit den die noch nicht
  // gelösten Begriffen geladen.
  List<GamePromptInfo> getNewRoundPromptInfos(String userId);

  // Team: abhängig von Anzahl der Teams in Settings werden die entsprechenden
  // Teams in der DB initialisiert und zurück gegeben
  List<Team> getTeams();

  // Round:
  // Hier wird z.B. das nächste spielende Team gesetzt
  void RoundStart();
}
