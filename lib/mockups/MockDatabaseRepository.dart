import 'dart:io';
import 'dart:math';

import '../interfaces/DatabaseRepository.dart';
import '../src/category.dart';
import '../src/category_user_info.dart';
import '../src/prompt.dart';
import '../src/game_prompt_info.dart';
import '../src/settings.dart';
import '../src/team.dart';
import '../src/user.dart';

class MockDatabaseRepository extends DatabaseRepository {
  List<User> userMocks = [];

  List<Settings> settingsMocks = [];
  List<Category> categoryMocks = [];
  List<Prompt> promptMocks = [];
  List<CategoryUserInfo> categoryUserInfoMocks = [];
  List<GamePromptInfo> gamePromptInfoMocks = [];

  MockDatabaseRepository() {
    fillUsers();
    fillCategories();
    fillPrompts();
  }

  // User: der die App installiert hat
  @override
  void sendUser(User user) {
    // Wenn Mockliste schon einen passenden Eintrag hat,
    // wird der Eintrag überschrieben. Ansonsten wird er neu erzeugt.
    int index = userMocks.indexWhere((item) => item.id == user.id);
    if (index >= 0) {
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
    int index = settingsMocks.indexWhere(
      (item) => item.userId == settings.userId,
    );
    if (index >= 0) {
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
    int index = settingsMocks.indexWhere((item) => item.userId == userId);
    if (index >= 0) {
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
    bool isContain = categoryUserInfoMocks.any(
      (item) => item.userId == categoryUserInfos[0].userId,
    );
    if (isContain) {
      for (var category in categoryUserInfos) {
        int index = categoryUserInfoMocks.indexWhere(
          (item) =>
              item.userId == userId && item.categoryId == category.categoryId,
        );
        categoryUserInfoMocks[index] = category;
      }
    } else {
      categoryUserInfoMocks.addAll(categoryUserInfos);
    }
  }

  List<CategoryUserInfo> getCategoryUserInfos(String userId) {
    bool isContain = categoryUserInfoMocks.any((item) => item.userId == userId);
    if (isContain) {
      return categoryUserInfoMocks
          .where((item) => item.userId == userId)
          .toList();
    } else {
      List<CategoryUserInfo> result = [];
      List<Category> categories = getAllCategories();
      for (Category category in categories) {
        User user = getUser(userId);
        // isLocked ist false, wenn die Lizens der users dies nicht zulässt.
        // Wenn er die Kategorie verwenden will, muss er die entsprechende
        // Lizenz erwerben.
        bool isLocked = user.license.index < category.license.index;

        // IsSelected= true bedeutet, das der user im letzten Spiel mit dieser
        // Kategorie gespielt hat. Im aller ersten Spiel wird die 1. Kategorie,
        // die immer isLocked false ist, als selected gesetzt ist.
        bool isSelected = category == categories.first;

        CategoryUserInfo categoryInGame = CategoryUserInfo(
          userId,
          categoryId: category.id,
          isLocked: isLocked,
          isSelected: isSelected,
        );
        result.add(categoryInGame);
      }
      categoryUserInfoMocks.addAll(result);
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
  List<Prompt> getGamePrompts(String userId) {
    List<Prompt> result = [];

    Settings settings = getSettings(userId);
    int nPromptGame = settings.nPromptsInGame; // Sollanzahl der Prompts
    int nPrompt = promptMocks.length; // Gesamtzahl der Prompts

    List<CategoryUserInfo> categoryUserInfos = getCategoryUserInfos(userId);

    Random random = Random();
    List<int> rnds = [];
    int? rndCurrent;
    Prompt? prompt;

    for (int i = 0; i < nPromptGame; i++) {
      bool isWhile = true;
      while (isWhile) {
        rndCurrent = random.nextInt(nPrompt);
        if (!rnds.contains(rndCurrent)) {
          prompt = promptMocks[rndCurrent];
          int index = categoryUserInfos.indexWhere(
            (item) => item.isSelected && item.categoryId == prompt?.categoryId,
          );
          isWhile = index < 0;
        }
      }
      rnds.add(rndCurrent!);
      result.add(prompt!);
    }
    return result;
  }

  @override
  List<GamePromptInfo> getGamePromptInfos(
    String userId,
    List<Prompt> gamePrompts,
  ) {
    //vorherige PromptGameInfos der Users werden gelöscht.
    gamePromptInfoMocks.removeWhere((item) => item.userId == userId);

    //die neuen PromptGameInfos werden gesetzt
    List<GamePromptInfo> result = [];
    for (Prompt prompt in gamePrompts) {
      result.add(GamePromptInfo(userId, prompt.id, isSolved: false));
    }
    return result;
  }

  @override
  void sendGamePromptInfos(
    String userId,
    List<GamePromptInfo> gamePromptInfos,
  ) {
    List<GamePromptInfo> _gamePromptInfoMocks =
        gamePromptInfoMocks.where((item) => item.userId == userId).toList();
    if (_gamePromptInfoMocks.length > 0) {
      for (var vMock in _gamePromptInfoMocks) {
        int index = gamePromptInfos.indexWhere(
          (item) => item.promptId == vMock.promptId,
        );
        if (index >= 0) {
          vMock = gamePromptInfos[index];
        }
      }
    } else {
      gamePromptInfoMocks.addAll(gamePromptInfos);
    }
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
