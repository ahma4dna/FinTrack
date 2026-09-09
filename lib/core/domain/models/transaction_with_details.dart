import 'package:fintrack/core/database/app_database.dart';

class TransactionWithDetails {
  final TransactionsTableData transaction;
  final String walletName;
  final String categoryName;
  final String categoryIcon;
  final String categoryColor;
  TransactionWithDetails({
    required this.transaction,
    required this.walletName,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
  });
}
