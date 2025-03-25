class Prompt {
  final String id;
  final String categoryId;
  final String text; // der zugehörige Text
  Prompt(this.id, this.categoryId, this.text);

  Prompt clone() {
    return Prompt(id, categoryId, text);
  }
}
