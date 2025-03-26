class CategoryUserInfo {
  final String userId;
  final String categoryId;
  final bool isLocked;
  final bool isSelected;

  CategoryUserInfo(
    this.userId, {
    required this.categoryId,
    required this.isLocked,
    required this.isSelected,
  });
}
