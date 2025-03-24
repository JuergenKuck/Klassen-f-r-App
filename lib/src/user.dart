enum License { free, packageA, packageB, packageC, packageD, packageE }

class User {
  final String id;
  final String name;
  final String eMail;

  User(String this.id, String this.name, String this.eMail, Enum license);
}
