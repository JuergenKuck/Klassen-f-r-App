import '../src/category.dart';
import '../src/prompt.dart';
import '../src/category_user_info.dart';
import '../src/prompt_info.dart';
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

  // Hier werden die CategoryUserInfos (categoryId) des Users (userId) geholt
  List<CategoryUserInfo> getCategoryUserInfos(String userId);

  // Category:
  void sendCategory(Category category);

  List<Category> getAllCategories();

  // Prompt:

  // Routine zum Laden aller Prompts
  //List<Prompt> gatAllPrompts();
  // Routine zum senden einer Liste von Prompts
  void sendPrompts(List<Prompt> prompts);

  // Ids der im Spiel zu erratenen Begriffe; Es wird aus den Kategorien gewählt,
  // die in der UI selektiert wurden (Settings).
  // für das Spiel und die vorgegebene Anzahl der Begriffe zufällig ausgewählt
  // (Settings).

  // Hier werden die Begriffinfos für das Spiel geladen,
  // ohne team.number und team.isSolved, weil diese sich erst beim Spiel ergeben.
  List<PromptInfo> getGamePromptInfos(String userId);

  List<PromptInfo> getNextRoundPromptInfos(String userId);

  // Wird nach jeder Änderung von IsSolved gesendet; hiervon hängen die Team.points ab.
  void sendPromptInfo(String userId, {required int teamNumber, required bool isSolved, required PromptInfo promptInfo});

  // Hier werden die PromptInfos für eine neuer Runde mit den die noch nicht
  // gelösten Begriffen geladen.
  // List<GamePromptInfo> getNewRoundPromptInfos(String userId);

  List<Teamname> getTeamnamesRandom(String userId, int nNames);

  // Teams:
  // Die Teams des Users werden zurück gegeben
  List<Team> getTeams(String userId);

  //Die TeamPoints werden gesetzt
  Team getTeamUpdated(String userId, int teamNumber);
}
