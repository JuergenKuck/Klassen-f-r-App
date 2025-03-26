class GamePromptInfo {
  final String userId;
  final String promptId;
  bool isSolved; // Prompt wurde im aktuellen Spiel geschafft.

  GamePromptInfo(this.userId, this.promptId, {required this.isSolved});
}
