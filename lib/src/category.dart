// backEnd DB
class Category {
  // final properties:
  final String id;
  final String name; //          z.B. Gebrauchsgegenstände, Sportarten,...
  final List<String> prompts; // Begriffe, die eine Person darstellen muss
  final String urlImage; //      Image zur Kategorie

  // constructor:
  Category(this.id, this.name, {required this.prompts, required this.urlImage});
}
