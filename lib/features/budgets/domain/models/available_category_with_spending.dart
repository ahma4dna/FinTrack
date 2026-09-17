class AvailableCategoryWithSpending {
  final int categoryId;
  final String name;
  final String iconName;
  final String colorHex;
  final double spentThisMonth;

  AvailableCategoryWithSpending({
    required this.categoryId,
    required this.name,
    required this.iconName,
    required this.colorHex,
    required this.spentThisMonth,
  });
}
