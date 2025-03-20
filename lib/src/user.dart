import 'category.dart';

class User {
  final String id;
  final String name;
  final String eMail;
  final List<Category> categories;

  User(String this.id, String this.name, String this.eMail, this.categories);
}
