import '../src/category.dart';
import '../src/prompt.dart';
import '../src/settings.dart';
import '../src/user.dart';
import '../src/team.dart';

abstract class DatabaseRepository {
  // User: der die App installiert hat
  void sendUser(User user);
  User getUser(String UserId);

  // Setting; Spieleinstellungen
  void sendSettings(String UserId);
  Settings getSettings(String UserId);

  // Category:

  // Alle in DB gespeicherten Kategorien; Die Kategorien für das Spiel;
  // isLocked ergibt sich aus der User.lizense,
  // isSelected ist bei Start des Spiels false und wird erst in der UI festgelegt;
  List<Category> getAllCategories();

  // Prompt:

  // Die im Spiel zu erratenen Begriffe; Es wird aus den Kategorien gewählt,
  // die in der UI selektiert wurden (Settings).
  // für das Spiel und die vorgegebene Anzahl der Begriffe zufällig ausgewählt
  // (Settings).
  List<Prompt> getPromptsInGame();

  // Hier werden nach jeder Runde die in dieser Runde behandelten Begriffe mit
  // der jeweiligen info von prompt.isSolved (aus UI)
  // gesendet. Muss gesendet werden, weil hiervon die Team.points abhängen
  void sendPromptsInRound(String teamId, List<Prompt> promptsInRound);
  List<Prompt> getPromptsInRound();

  // Team: abhängig von Anzahl der Teams in Settings werden die entsprechenden
  // Teams in der DB initialisiert und zurück gegeben
  List<Team> getTeams();

  // Round:
  // Hier wird z.B. das nächste spielende Team gesetzt
  void RoundStart();
}
