class Category {
  // final properties:
  final String id;
  final String name; //          z.B. Gebrauchsgegenstände, Sportarten,...
  final List<String> prompts; // Begriffe, die eine Person darstellen muss
  final String urlImage; //      Image zur Kategorie
  final bool isLocked; //        Kategorie, die in UI angezeigt wird, aber
  //                            nicht selecktiert werden können, weil die hierzu
  //                            benötigte Lizenz noch nicht erworben wurde.

  // constructor:
  Category(
    this.id,
    this.name, {
    required this.prompts,
    required this.urlImage,
    required this.isLocked,
  });
}
