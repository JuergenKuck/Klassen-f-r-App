class Catagory {
  // final properties:
  final String name; //          z.B. Gebrauchsgegenstände, Sportarten,...
  final bool isLocked; //        Die Kategorie kann nur verwendt werden, wenn
  //                            diese freigeschaltet ist (isLocked=false).
  final List<String> prompts; // Begriffe, die eine Person darstellen muss
  final String urlImage; //      Image zur Kategorie

  //additional properties:
  bool isSelected = false;

  // constructor:
  Catagory(this.name,
      {required this.isLocked, required this.prompts, required this.urlImage});
}
