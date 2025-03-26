class GamePromptInfo {
  final String userId;
  final String promptId;
  int teamNumber = 0;
  bool isSolved = false; // Prompt wurde im aktuellen Spiel geschafft.

  GamePromptInfo(this.userId, this.promptId);
}
