import 'prompt.dart';
import 'user.dart';

class Category {
  // final properties:
  final String id;
  final String name; //          z.B. Gebrauchsgegenstände, Sportarten,...
  final String urlImage; //      Image zur Kategorie
  final License license; //      benötigte Lizenz, damit dies Kategorie im Spiel
  //                            verwendet werden kann

  // constructor:
  Category(this.id, this.name, {required this.urlImage, required this.license});
}
