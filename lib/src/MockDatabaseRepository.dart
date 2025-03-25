import 'dart:io';
import 'dart:math';

import '../interfaces/DatabaseRepository.dart';
import 'category.dart';
import 'category_ids_selected.dart';
import 'prompt.dart';
import 'settings.dart';
import 'team.dart';
import 'user.dart';

class MockDatabaseRepository extends DatabaseRepository {
  List<User> users = [];

  List<Settings> settingsList = [];
  List<Category> categories = [];
  List<Prompt> prompts = [];
  List<CategoryIdsSelected> categoryIdsSelected = [];

  // User: der die App installiert hat
  @override
  void sendUser(User user) {
    users.add(user);
  }

  @override
  User getUser(String userId) {
    return users.firstWhere(
      (user) => user.id == userId,
      orElse: () => users.first,
    );
  }

  // Setting; Spieleinstellungen
  @override
  void sendSettings(Settings settings) {
    // Wenn in der settingsList schon eine settings mit userId existiert,
    // wird der Eintrag überschrieben. Ansonsten wird er neu erzeugt.
    if (settingsList.contains(settings.userId)) {
      int index = settingsList.indexWhere(
        (item) => item.userId == settings.userId,
      );
      settingsList[index] = settings;
    } else {
      settingsList.add(settings);
    }
  }

  @override
  void clearCategoryIdsSelected(String userId) {
    categoryIdsSelected.removeWhere((item) => item.userId == userId);
  }

  @override
  Settings getSettings(String userId) {
    // Wenn ein Eintrag für die userId in 'settingsList' existiert wird dieser
    // zurückgegeben. Ansonsten wird eine neue Settings mit Standardwerten
    // erzeugt, in 'settingsList' geadded und zurückgegeben.
    if (settingsList.contains(userId)) {
      int index = settingsList.indexWhere((item) => item.userId == userId);
      return settingsList[index];
    } else {
      //mit Standardwerten erzeugen
      Settings settings = Settings.defaultValues();
      settingsList.add(settings);
      return settings;
    }
  }

  // Category:

  // Alle in DB gespeicherten Kategorien; Die Kategorien für das Spiel;
  @override
  List<Category> getAllCategories() {
    return categories;
  }

  // Prompt:

  // Die im Spiel zu erratenen Begriffe; Es wird aus den Kategorien gewählt,
  // die in der UI selektiert wurden (Settings).
  // für das Spiel und die vorgegebene Anzahl der Begriffe zufällig ausgewählt
  // (Settings).
  @override
  List<Prompt> getPromptsInGame(String userId, List<Category> categoriesGame) {
    List<Prompt> result = [];
    Settings settings = getSettings(userId);
    int nPromptGame = settings.nPromptsInGame; // Sollanzahl der Prompts
    int nPrompt = prompts.length;
    Random random = Random();
    List<int> rnds = [];
    int? rndCurrent;
    Prompt? prompt;
    for (int i = 0; i < nPromptGame; i++) {
      bool isWhile = true;
      while (isWhile) {
        rndCurrent = random.nextInt(nPrompt);
        prompt = prompts[rndCurrent];
        for (var category in categoriesGame) {
          if (category.isSelected) {
            if (category.id == prompt.categoryId) {
              isWhile = false;
              for (int rnd in rnds) {
                if (rnd == rndCurrent) {
                  isWhile = true;
                  break;
                }
              }
            }
          }
        }
      }
      rnds.add(rndCurrent!);
      result.add(prompt!);
    }
    return result;

    return [];
  }

  // Hier werden nach jeder Runde die in dieser Runde behandelten Begriffe mit
  // der jeweiligen info von prompt.isSolved (aus UI)
  // gesendet. Muss gesendet werden, weil hiervon die Team.points abhängen
  @override
  void sendPromptsInRound(String teamId, List<Prompt> promptsInRound) {
    // TODO: implement sendPromptsInRound
  }
  @override
  List<Prompt> getPromptsInRound() {
    // TODO: implement getPromptsInRound
    throw UnimplementedError();
  }

  // Team: abhängig von Anzahl der Teams in Settings werden die entsprechenden
  // Teams in der DB initialisiert und zurück gegeben
  @override
  List<Team> getTeams() {
    // TODO: implement getTeams
    throw UnimplementedError();
  }

  // Round:
  // Hier wird z.B. das nächste spielende Team gesetzt
  @override
  void RoundStart() {
    // TODO: implement RoundStart
  }

  void fillUsers() {
    users.clear();
    for (int i = 1; i <= 10; i++) {
      String _userId = i.toString().padLeft(2, '0');
      User user = User(
        _userId,
        firstName: 'VN_$_userId',
        lastName: 'NN_$_userId',
        eMail: 'e_$_userId@google.de',
        license: License.free,
      );
      sendUser(user);
    }
  }

  void fillCategories() {
    categories.clear();
    categories.add(
      Category(
        '00',
        'Alle Kategorien',
        urlImage: 'alle_kategorien.jpg',
        license: License.free,
      ),
    );
    categories.add(
      Category(
        '01',
        'Gebrauchsgegenstände',
        urlImage: 'gebrauchsgegenstände.jpg',
        license: License.free,
      ),
    );
    categories.add(
      Category(
        '02',
        'Sportarten',
        urlImage: 'sportarten.jpg',
        license: License.packageA,
      ),
    );
    categories.add(
      Category(
        '03',
        'Technischer Fortschritt',
        urlImage: 'technischer_fortschritt.jpg',
        license: License.free,
      ),
    );
    categories.add(
      Category('04', 'Tiere', urlImage: 'tiere.jpg', license: License.free),
    );
    categories.add(
      Category(
        '05',
        'Ökologie',
        urlImage: 'oekologie.jpg',
        license: License.packageA,
      ),
    );
    categories.add(
      Category(
        '06',
        'Spiele und Unterhaltung',
        urlImage: 'spiele_unterhaltung.jpg',
        license: License.free,
      ),
    );
    categories.add(
      Category(
        '07',
        'Anlässe',
        urlImage: 'anlaesse.jpg',
        license: License.packageA,
      ),
    );
    categories.add(
      Category(
        '08',
        'Geisteswissenschaften',
        urlImage: 'geisteswissenschaften.jpg',
        license: License.free,
      ),
    );
    categories.add(
      Category('09', 'Natur', urlImage: 'natur.jpg', license: License.free),
    );
    categories.add(
      Category(
        '10',
        'Hobbys und Freizeit',
        urlImage: 'hobbys_freizeit.jpg',
        license: License.free,
      ),
    );
    categories.add(
      Category(
        '11',
        'Reisen und Abenteuer',
        urlImage: 'reisen_abenteuer.jpg',
        license: License.free,
      ),
    );
    categories.add(
      Category('12', 'im Haus', urlImage: 'im_haus.jpg', license: License.free),
    );
    categories.add(
      Category(
        '13',
        'Gesundheit und Wellness',
        urlImage: 'gesundheit_wellness.jpg',
        license: License.free,
      ),
    );
    categories.add(
      Category(
        '14',
        'Essen und Trinken',
        urlImage: 'essen_trinken.jpg',
        license: License.packageA,
      ),
    );
  }

  void fillPrompts() {
    prompts.clear();
    for (Category category in categories) {
      String text0 = category.name;
      String categoryId = category.id;
      for (var i = 1; i <= 500; i++) {
        String id = i.toString().padLeft(3, '0');
        String text = text0 + ' $id';
        prompts.add(Prompt(id, categoryId, text));
      }
    }
  }
}
