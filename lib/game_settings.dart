import 'dart:math';

import 'interfaces/DatabaseRepository.dart';
import 'src/category.dart';
import 'src/category_user_info.dart';
import 'src/prompt.dart';
import 'src/game_prompt_info.dart';
import 'src/settings.dart';
import 'src/user.dart';

class GameSettings {
  // Simuliert die UI

  final DatabaseRepository dbRep;
  final String userId;

  Settings settings = Settings.defaultValues();
  List<Category> categories = [];
  List<CategoryUserInfo> categoryUserInfos = [];
  List<Prompt> gamePrompts = [];
  List<GamePromptInfo> gamePromptInfos = [];

  GameSettings(this.userId, this.dbRep) {
    categories = dbRep.getAllCategories();
    settings = dbRep.getSettings(userId);
    categoryUserInfos = dbRep.getCategoryUserInfos(userId);
    gamePrompts = dbRep.getGamePrompts(userId);
    gamePromptInfos = dbRep.getGamePromptInfos(userId, gamePrompts);

    gamePromptInfos[0].isSolved = true;
    dbRep.sendGamePromptInfos(userId, gamePromptInfos);
    gamePromptInfos[1].isSolved = true;
    dbRep.sendGamePromptInfos(userId, gamePromptInfos);
  }
}
