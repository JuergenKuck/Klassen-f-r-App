import 'dart:math';

import 'interfaces/DatabaseRepository.dart';
import 'src/category.dart';
import 'src/category_user_info.dart';
import 'src/prompt.dart';
import 'src/game_prompt_info.dart';
import 'src/settings.dart';
import 'src/team.dart';
import 'src/user.dart';

class GameSettings {
  // Simuliert die UI

  final DatabaseRepository dbRep;
  final String userId;

  Settings settings = Settings.defaultValues();
  List<Category> categories = [];
  List<CategoryUserInfo> categoryUserInfos = [];

  GameSettings(this.userId, this.dbRep) {
    settings = dbRep.getSettings(userId);
    categoryUserInfos = dbRep.getCategoryUserInfos(userId);
  }
}
