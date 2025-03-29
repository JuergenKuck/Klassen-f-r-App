import 'interfaces/DatabaseRepository.dart';
import 'game_settings.dart';
import 'src/prompt_info.dart';
import 'src/team.dart';

class Game {
  final String userId;
  final DatabaseRepository dbRep;

  GameSettings? gameSettings;

  List<PromptInfo> roundPromptInfos = [];
  List<Team> teams = [];
  int iTeam = 0;

  Game(this.userId, this.dbRep) {
    gameSettings = GameSettings(this.userId, this.dbRep);

    //PromptInfos für die erste Runde
    roundPromptInfos = dbRep.getGamePromptInfos(userId);
    teams = dbRep.getTeams(userId);
  }

  int get teamNumber => teams[iTeam].number;
  int get teamPoints => teams[iTeam].points;

  void run() {
    ChangeSolved(infoIndex: 0, isSolved: true);
    ChangeSolved(infoIndex: 1, isSolved: true);
    ChangeSolved(infoIndex: 3, isSolved: true);
    ChangeSolved(infoIndex: 4, isSolved: true);
    nextRound();
    ChangeSolved(infoIndex: 0, isSolved: true);
    ChangeSolved(infoIndex: 1, isSolved: true);
    nextRound();
    ChangeSolved(infoIndex: 0, isSolved: true);
    //    ChangeSelected(infoIndex: 1, isSelected: true);
  }

  void ChangeSolved({required int infoIndex, required bool isSolved}) {
    dbRep.sendPromptInfo(userId, teamNumber: teamNumber, isSolved: isSolved, promptInfo: roundPromptInfos[infoIndex]);
    teams[iTeam] = dbRep.getTeamUpdated(userId, teamNumber);
  }

  void nextRound() {
    teams[iTeam] = dbRep.getTeamUpdated(userId, teamNumber);

    //PromptInfos für die nächset Runde
    roundPromptInfos = dbRep.getNextRoundPromptInfos(userId);

    // Team der nächsten Runde
    iTeam++;
    if (iTeam >= gameSettings!.settings.nTeams) {
      iTeam = 0;
    }
  }
}
