class CategoryUserInfo {
  final String userId;
  final String categoryId;
  final bool isLocked; //   isLocke= false, wenn die Lizens der users dies
  //                       nicht zulässt. Wenn er die Kategorie verwenden
  //                       will, muss er die entsprechende Lizenz erwerben.
  final bool isSelected; // IsSelected= true bedeutet, das der user zu Letzt
  //                       mit dieser Kategorie gespielt hat.

  CategoryUserInfo(
    this.userId, {
    required this.categoryId,
    required this.isLocked,
    required this.isSelected,
  });
}
