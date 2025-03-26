class Team {
  // final properties:
  final String userId;
  final int number; //      1-3; es gibt mindestens ein Team und maximal 3
  final String name; //     Team-Name
  final String color; //    Team-Farbe (Todo)
  final String urlImage; // Team-Image
  final int points; //      Punkte, die das Team im Spiel erwirbt

  // Constructor
  Team(
    this.userId,
    this.number,
    this.name, {
    required this.color,
    required this.urlImage,
    required this.points,
  });
}
