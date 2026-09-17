import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/budgets/domain/models/available_category_with_spending.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';

abstract class BudgetsRepository {
  Future<int> insertBudget(BudgetsTableCompanion budget);
  Stream<List<BudgetWithSpending>> watchAll();
  Stream<List<AvailableCategoryWithSpending>> getAvailableCategories();
}
