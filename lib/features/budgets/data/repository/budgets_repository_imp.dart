import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/budgets/data/dao/budgets_dao.dart';
import 'package:fintrack/features/budgets/domain/models/available_category_with_spending.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';
import 'package:fintrack/features/budgets/domain/repository/budgets_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BudgetsRepository)
class BudgetsRepositoryImp implements BudgetsRepository {
  final BudgetsDao budgetsDao;

  BudgetsRepositoryImp({required this.budgetsDao});
  @override
  Future<int> insertBudget(BudgetsTableCompanion budget) async {
    return await budgetsDao.insertBudget(budget);
  }

  @override
  Stream<List<BudgetWithSpending>> watchAll() async* {
    yield* budgetsDao.watchAll();
  }

  @override
  Stream<List<AvailableCategoryWithSpending>> getAvailableCategories() async* {
    yield* budgetsDao.getAvailableCategories();
  }
}
