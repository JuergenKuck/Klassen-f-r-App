class Prompt {
  final String id;
  final String prompt; // Ein Prompt aus irgend einer Category
  final bool isSolved; // Wurde der Prompt gelöst

  Prompt(this.id, this.prompt, this.isSolved);
}
