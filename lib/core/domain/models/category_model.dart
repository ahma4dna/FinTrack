class CategoryModel {
  final int? id;
  final String name;
  final String type;
  final String iconName;
  final String categoryColor;

  const CategoryModel({
    this.id,
    required this.name,
    required this.type,
    required this.iconName,
    required this.categoryColor,
  });
}
