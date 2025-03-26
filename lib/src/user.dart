enum License { free, packageA, packageB }

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String eMail;
  final License license;
  User(
    this.id, {
    required this.firstName,
    required this.lastName,
    required this.eMail,
    required this.license,
  });
}
