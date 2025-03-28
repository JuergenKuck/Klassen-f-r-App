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
  List<Team> teams = [];
  List<Prompt> gamePrompts = [];
  List<GamePromptInfo> roundPromptInfos = [];

  GameSettings(this.userId, this.dbRep) {
    categories = dbRep.getAllCategories();
    settings = dbRep.getSettings(userId);
    categoryUserInfos = dbRep.getCategoryUserInfos(userId);
    gamePrompts = dbRep.getNewGamePrompts(userId);
    roundPromptInfos = dbRep.getNewGamePromptInfos(userId, gamePrompts);

    dbRep.initialTeams(userId);

    teams = dbRep.getTeams(userId);
    roundPromptInfos[0].isSolved = true;
    roundPromptInfos[1].isSolved = true;
    roundPromptInfos[3].isSolved = true;
    roundPromptInfos[4].isSolved = true;
    dbRep.sendEndRoundPromptInfos(
      userId,
      teamNumber: teams[0].number,
      roundPromptInfos: roundPromptInfos,
    );

    teams[0] = dbRep.getTeamWithModPoints(userId, 0);

    roundPromptInfos = dbRep.getNewRoundPromptInfos(userId);
    roundPromptInfos[0].isSolved = true;
    dbRep.sendEndRoundPromptInfos(
      userId,
      teamNumber: teams[1].number,
      roundPromptInfos: roundPromptInfos,
    );
    roundPromptInfos = dbRep.getNewRoundPromptInfos(userId);

    //ToDo isFaild!!!!!!!
  }
}
