// frontEnd DB
class GamePrompt {
  final String id;
  final String prompt; // Ein Prompt aus irgend einer Category
  final bool isSolved; // Wurde der Prompt gelöst

  GamePrompt(this.id, this.prompt, this.isSolved);
}
