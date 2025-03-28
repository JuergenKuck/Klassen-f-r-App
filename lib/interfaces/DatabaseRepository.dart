import '../src/category.dart';
import '../src/prompt.dart';
import '../src/category_user_info.dart';
import '../src/game_prompt_info.dart';
import '../src/settings.dart';
import '../src/teamname.dart';
import '../src/user.dart';
import '../src/team.dart';

abstract class DatabaseRepository {
  // User: der die App installiert hat
  void sendUser(User user);
  User getUser(String userId);

  // Setting; Spieleinstellungen
  void sendSettings(Settings settings);
  Settings getSettings(String userId);

  void sendCategoryUserInfos(String userId, List<CategoryUserInfo> categoryUserInfos);
  List<CategoryUserInfo> getCategoryUserInfos(String userId);

  // Category:
  Category getCategory(String categorieId);
  void sendCategory(Category category);

  List<Category> getAllCategories();

  // Prompt:

  // Routine zum Laden aller Prompts
  //List<Prompt> gatAllPrompts();
  // Routine zum senden einer Liste von Prompts
  void sendPrompts(List<Prompt> prompts);

  // Die im Spiel zu erratenen Begriffe; Es wird aus den Kategorien gewählt,
  // die in der UI selektiert wurden (Settings).
  // für das Spiel und die vorgegebene Anzahl der Begriffe zufällig ausgewählt
  // (Settings).
  List<Prompt> getNewGamePrompts(String userId);

  // Hier werden die Begriffinfos für das Spiel geladen,
  // ohne team.number und team.isSolved, weil diese sich erst beim Spiel ergeben.
  List<GamePromptInfo> getNewGamePromptInfos(String userId, List<Prompt> promptsInGame);

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

  List<Teamname> getTeamnamesRandom(String userId, int nNames);

  // Teams:
  // Die Teams des Users werden zurück gegeben
  List<Team> getTeams(String userId);

  //Die TeamPoints werden gesetzt
  Team getTeamWithModPoints(String userId, int teamNumber);
}
