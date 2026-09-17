import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/budgets/domain/repository/budgets_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InsertBudgetUseCase {
  final BudgetsRepository budgetsRepository;

  const InsertBudgetUseCase(this.budgetsRepository);
  Future<int> insertBudget(BudgetsTableCompanion budget) async {
    return await budgetsRepository.insertBudget(budget);
  }
}
