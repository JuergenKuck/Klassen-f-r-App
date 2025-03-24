class Team {
  // final properties:
  final String id;
  final String name; //     Team-Name
  final String color; //    Team-Farbe (Todo)
  final String urlImage; // Team-Image
  final int points; //  Punkte, die im Speil erworben werden

  // Constructor
  Team(
    this.id,
    this.name, {
    required this.color,
    required this.urlImage,
    required this.points,
  });
}
