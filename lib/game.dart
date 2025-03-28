import 'interfaces/DatabaseRepository.dart';
import 'game_settings.dart';
import 'src/game_prompt_info.dart';
import 'src/prompt.dart';
import 'src/team.dart';

class Game {
  final String userId;
  final DatabaseRepository dbRep;

  GameSettings? gameSettings;

  List<Prompt> gamePrompts = [];
  List<GamePromptInfo> roundPromptInfos = [];
  List<Team> teams = [];

  Game(this.userId, this.dbRep) {
    gameSettings = GameSettings(this.userId, this.dbRep);
    gamePrompts = dbRep.getNewGamePrompts(userId);
    roundPromptInfos = dbRep.getNewGamePromptInfos(userId, gamePrompts);
    teams = dbRep.getTeams(userId);
  }

  void run() {
    roundPromptInfos[0].isSolved = true;
    roundPromptInfos[1].isSolved = true;
    roundPromptInfos[3].isSolved = true;
    roundPromptInfos[4].isSolved = true;
    dbRep.sendEndRoundPromptInfos(userId, teamNumber: teams[0].number, roundPromptInfos: roundPromptInfos);

    teams[0] = dbRep.getTeamWithModPoints(userId, 0);
    roundPromptInfos = dbRep.getNewRoundPromptInfos(userId);

    roundPromptInfos[0].isSolved = true;
    roundPromptInfos[1].isSolved = true;
    dbRep.sendEndRoundPromptInfos(userId, teamNumber: teams[1].number, roundPromptInfos: roundPromptInfos);
    roundPromptInfos = dbRep.getNewRoundPromptInfos(userId);
    teams[1] = dbRep.getTeamWithModPoints(userId, 1);
  }
}
