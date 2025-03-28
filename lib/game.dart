import 'interfaces/DatabaseRepository.dart';
import 'game_settings.dart';
import 'src/game_prompt_info.dart';
import 'src/prompt.dart';
import 'src/settings.dart';
import 'src/team.dart';

class Game {
  final String userId;
  final DatabaseRepository dbRep;

  GameSettings? gameSettings;

  List<Prompt> gamePrompts = [];
  List<GamePromptInfo> roundPromptInfos = [];
  List<Team> teams = [];
  int iTeam = 0;

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
    nextRound();
    roundPromptInfos[0].isSolved = true;
    roundPromptInfos[1].isSolved = true;
    nextRound();
  }

  void nextRound() {
    dbRep.sendEndRoundPromptInfos(userId, teamNumber: teams[iTeam].number, roundPromptInfos: roundPromptInfos);
    teams[iTeam] = dbRep.getTeamWithModPoints(userId, teams[iTeam].number);
    roundPromptInfos = dbRep.getNewRoundPromptInfos(userId);
    iTeam++;
    if (iTeam > gameSettings!.settings.nTeams) {
      iTeam = 0;
    }
  }
}
