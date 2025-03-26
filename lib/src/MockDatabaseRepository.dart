import 'dart:io';
import 'dart:math';

import '../interfaces/DatabaseRepository.dart';
import 'category.dart';
import 'category_user_info.dart';
import 'prompt.dart';
import 'settings.dart';
import 'team.dart';
import 'user.dart';

class MockDatabaseRepository extends DatabaseRepository {
  List<User> userMocks = [];

  List<Settings> settingsMocks = [];
  List<Category> categoryMocks = [];
  List<Prompt> promptMocks = [];
  List<CategoryUserInfo> CategoryUserInfoMocks = [];

  // User: der die App installiert hat
  @override
  void sendUser(User user) {
    // Wenn Mockliste schon einen passenden Eintrag hat,
    // wird der Eintrag überschrieben. Ansonsten wird er neu erzeugt.
    if (userMocks.contains(user.id)) {
      int index = userMocks.indexWhere((item) => item.id == user.id);
      userMocks[index] = user;
    } else {
      userMocks.add(user);
    }
  }

  @override
  User getUser(String userId) {
    User user = userMocks.firstWhere(
      (user) => user.id == userId,
      orElse: () => throw Exception('User with ID $userId not found'),
    );
    return user;
  }

  // Setting; Spieleinstellungen
  @override
  void sendSettings(Settings settings) {
    // Wenn in der settingsList schon eine settings mit userId existiert,
    // wird der Eintrag überschrieben. Ansonsten wird er neu erzeugt.
    if (settingsMocks.contains(settings.userId)) {
      int index = settingsMocks.indexWhere(
        (item) => item.userId == settings.userId,
      );
      settingsMocks[index] = settings;
    } else {
      settingsMocks.add(settings);
    }
  }

  @override
  Settings getSettings(String userId) {
    // Wenn ein Eintrag für die userId in 'settingsList' existiert wird dieser
    // zurückgegeben. Ansonsten wird eine neue Settings mit Standardwerten
    // erzeugt, in 'settingsList' geadded und zurückgegeben.
    if (settingsMocks.contains(userId)) {
      int index = settingsMocks.indexWhere((item) => item.userId == userId);
      return settingsMocks[index];
    } else {
      //mit Standardwerten erzeugen
      Settings settings = Settings.defaultValues();
      settingsMocks.add(settings);
      return settings;
    }
  }

  @override
  void sendCategoryUserInfos(
    String userId,
    List<CategoryUserInfo> categoryUserInfos,
  ) {
    if (CategoryUserInfoMocks.contains(categoryUserInfos[0].userId)) {
      for (var category in categoryUserInfos) {
        int index = CategoryUserInfoMocks.indexWhere(
          (item) =>
              item.userId == userId && item.categoryId == category.categoryId,
        );
        CategoryUserInfoMocks[index] = category;
      }
    } else {
      CategoryUserInfoMocks.addAll(categoryUserInfos);
    }
  }

  List<CategoryUserInfo> GetCategoryUserInfos(String userId) {
    if (CategoryUserInfoMocks.contains(userId)) {
      return CategoryUserInfoMocks.where(
        (item) => item.userId == userId,
      ).toList();
    } else {
      List<CategoryUserInfo> result = [];
      List<Category> categories = getAllCategories();
      for (Category category in categories) {
        User user = getUser(userId);
        bool isLocked = user.license.index < category.license.index;

        CategoryUserInfo categoryInGame = CategoryUserInfo(
          userId,
          categoryId: category.id,
          isLocked: isLocked,
          isSelected: true,
        );
        result.add(categoryInGame);
      }
      CategoryUserInfoMocks.addAll(result);
      return result;
    }
  }

  // Category:

  // Alle in DB gespeicherten Kategorien; Die Kategorien für das Spiel;
  @override
  List<Category> getAllCategories() {
    return categoryMocks;
  }

  // Prompt:

  // Die im Spiel zu erratenen Begriffe; Es wird aus den Kategorien gewählt,
  // die in der UI selektiert wurden (Settings).
  // für das Spiel und die vorgegebene Anzahl der Begriffe zufällig ausgewählt
  // (Settings).
  @override
  List<Prompt> getPromptsInGame(String userId) {
    List<Prompt> result = [];
    Settings settings = getSettings(userId);
    List<CategoryUserInfo> categoryUserInfos = GetCategoryUserInfos(userId);
    int nPromptGame = settings.nPromptsInGame; // Sollanzahl der Prompts
    int nPrompt = promptMocks.length;
    Random random = Random();
    List<int> rnds = [];
    int? rndCurrent;
    Prompt? prompt;
    for (int i = 0; i < nPromptGame; i++) {
      bool isWhile = true;
      while (isWhile) {
        rndCurrent = random.nextInt(nPrompt);
        prompt = promptMocks[rndCurrent];
        for (var category in categoryUserInfos) {
          if (category.isSelected) {
            if (category.categoryId == prompt.categoryId) {
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
    userMocks.clear();
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
    categoryMocks.clear();
    categoryMocks.add(
      Category(
        '00',
        'Alle Kategorien',
        urlImage: 'alle_kategorien.jpg',
        license: License.free,
      ),
    );
    categoryMocks.add(
      Category(
        '01',
        'Gebrauchsgegenstände',
        urlImage: 'gebrauchsgegenstände.jpg',
        license: License.free,
      ),
    );
    categoryMocks.add(
      Category(
        '02',
        'Sportarten',
        urlImage: 'sportarten.jpg',
        license: License.packageA,
      ),
    );
    categoryMocks.add(
      Category(
        '03',
        'Technischer Fortschritt',
        urlImage: 'technischer_fortschritt.jpg',
        license: License.free,
      ),
    );
    categoryMocks.add(
      Category('04', 'Tiere', urlImage: 'tiere.jpg', license: License.free),
    );
    categoryMocks.add(
      Category(
        '05',
        'Ökologie',
        urlImage: 'oekologie.jpg',
        license: License.packageA,
      ),
    );
    categoryMocks.add(
      Category(
        '06',
        'Spiele und Unterhaltung',
        urlImage: 'spiele_unterhaltung.jpg',
        license: License.free,
      ),
    );
    categoryMocks.add(
      Category(
        '07',
        'Anlässe',
        urlImage: 'anlaesse.jpg',
        license: License.packageA,
      ),
    );
    categoryMocks.add(
      Category(
        '08',
        'Geisteswissenschaften',
        urlImage: 'geisteswissenschaften.jpg',
        license: License.free,
      ),
    );
    categoryMocks.add(
      Category('09', 'Natur', urlImage: 'natur.jpg', license: License.free),
    );
    categoryMocks.add(
      Category(
        '10',
        'Hobbys und Freizeit',
        urlImage: 'hobbys_freizeit.jpg',
        license: License.free,
      ),
    );
    categoryMocks.add(
      Category(
        '11',
        'Reisen und Abenteuer',
        urlImage: 'reisen_abenteuer.jpg',
        license: License.free,
      ),
    );
    categoryMocks.add(
      Category('12', 'im Haus', urlImage: 'im_haus.jpg', license: License.free),
    );
    categoryMocks.add(
      Category(
        '13',
        'Gesundheit und Wellness',
        urlImage: 'gesundheit_wellness.jpg',
        license: License.free,
      ),
    );
    categoryMocks.add(
      Category(
        '14',
        'Essen und Trinken',
        urlImage: 'essen_trinken.jpg',
        license: License.packageA,
      ),
    );
  }

  void fillPrompts() {
    promptMocks.clear();
    for (Category category in categoryMocks) {
      String text0 = category.name;
      String categoryId = category.id;
      for (var i = 1; i <= 500; i++) {
        String id = i.toString().padLeft(3, '0');
        String text = text0 + ' $id';
        promptMocks.add(Prompt(id, categoryId, text));
      }
    }
  }
}
