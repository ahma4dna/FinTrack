import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/budgets/data/dao/budgets_dao.dart';
import 'package:fintrack/features/budgets/data/repository/budgets_repository_imp.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'budgets_repository_imp_test.mocks.dart';

@GenerateMocks([BudgetsDao])
void main() async {
  late BudgetsDao budgetsDao;
  late BudgetsRepositoryImp budgetsRepositoryImp;
  setUp(
    () {
      budgetsDao = MockBudgetsDao();
      budgetsRepositoryImp = BudgetsRepositoryImp(
        budgetsDao: budgetsDao,
      );
    },
  );
  test(
    "should insert budgets and return genrater id",
    () async {
      final budget = BudgetsTableCompanion.insert(
        categoryId: 1,
        limitAmount: 500,
      );
      when(budgetsDao.insertBudget(budget)).thenAnswer((_) async => 1);
      final result = await budgetsRepositoryImp.insertBudget(budget);
      expect(result, 1);
      verify(budgetsDao.insertBudget(budget)).called(1);
    },
  );

  test(
    "should return as BudgetWithSpendings stream",
    () async {
      final budgetWithSpending = BudgetWithSpending(
        budget: BudgetsTableData(
          id: 1,
          categoryId: 1,
          limitAmount: 500,
          createdAt: DateTime.now(),
        ),
        categoryName: "طعام",
        categoryIcon: "food",
        categoryColor: "OXFF092837",
        spent: 55,
      );
      when(budgetsDao.watchAll()).thenAnswer(
        (_) async* {
          yield* Stream.value([budgetWithSpending]);
        },
      );
      final result = await budgetsRepositoryImp.watchAll().first;
      expect(result.length, 1);
      expect(result.first.budget.id, budgetWithSpending.budget.id);
      expect(result.first.budget.categoryId, budgetWithSpending.budget.categoryId);
      expect(result.first.categoryName, budgetWithSpending.categoryName);
      verify(budgetsDao.watchAll()).called(1);
    },
  );
}
