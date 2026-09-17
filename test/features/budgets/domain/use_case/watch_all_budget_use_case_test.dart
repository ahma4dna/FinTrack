import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';
import 'package:fintrack/features/budgets/domain/repository/budgets_repository.dart';
import 'package:fintrack/features/budgets/domain/use_case/watch_all_budget_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watch_all_budget_use_case_test.mocks.dart';

@GenerateMocks([BudgetsRepository])
void main() {
  late BudgetsRepository budgetsRepository;
  late WatchAllBudgetUseCase watchAllBudgetUseCase;
  setUp(
    () {
      budgetsRepository = MockBudgetsRepository();
      watchAllBudgetUseCase = WatchAllBudgetUseCase(budgetsRepository);
    },
  );

  test(
    "should return as BudgetWithSpendings stream ",
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
      when(budgetsRepository.watchAll()).thenAnswer((_) => Stream.value([budgetWithSpending]));
      final results = await watchAllBudgetUseCase.watchAll().first;
      expect(results.length, 1);
      expect(results.first.budget.id, budgetWithSpending.budget.id);
      expect(results.first.budget.categoryId, budgetWithSpending.budget.categoryId);
      expect(results.first.categoryName, budgetWithSpending.categoryName);
      verify(budgetsRepository.watchAll()).called(1);
    },
  );
}
