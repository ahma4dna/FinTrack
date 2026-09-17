import 'package:fintrack/core/database/app_database.dart';

class BudgetWithSpending {
  final BudgetsTableData budget;
  final String categoryName;
  final String categoryIcon;
  final String categoryColor;
  final double spent;
  BudgetWithSpending({
    required this.budget,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
    required this.spent,
  });
  double get limitAmount => budget.limitAmount;
  double get remaining => limitAmount - spent;
  int get percentage => limitAmount > 0 ? ((spent / limitAmount) * 100).round().clamp(0, 999) : 0;
  bool get isOverBudget => spent > limitAmount;
}
