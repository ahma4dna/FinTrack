class TransactionModel {
  final int? id;
  final int walletId;
  final int categoryId;
  final String type;
  final double amount;
  final String title;
  final String? note;
  final DateTime date;

  final String? walletName;
  final String? categoryName;
  final String? categoryIcon;
  final String? categoryColor;

  TransactionModel({
    required this.id,
    required this.walletId,
    required this.categoryId,
    required this.type,
    required this.amount,
    required this.title,
    required this.note,
    required this.date,
    required this.walletName,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
  }); // لون التصنيف

  bool get isIncome => type == 'income';
  bool get isExpense => type == 'expense';
}
