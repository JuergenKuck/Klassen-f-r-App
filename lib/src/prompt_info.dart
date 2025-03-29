class PromptInfo {
  final String userId;
  final int promptInfoNumber;
  final String promptId;
  final int teamNumber;
  final bool isSolved;

  PromptInfo(this.userId, this.promptInfoNumber, this.promptId, {required this.teamNumber, required this.isSolved});

  PromptInfo getModPromptInfo(int modTeamNumber, bool modIsSolved) {
    return PromptInfo(userId, promptInfoNumber, promptId, teamNumber: modTeamNumber, isSolved: modIsSolved);
  }
}
