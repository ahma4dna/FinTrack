import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/budgets/domain/repository/budgets_repository.dart';
import 'package:fintrack/features/budgets/domain/use_case/insert_budget_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'insert_budget_use_case_test.mocks.dart';

@GenerateMocks([BudgetsRepository])
void main() {
  late MockBudgetsRepository mockBudgetsRepository;
  late InsertBudgetUseCase insertBudgetUseCase;
  setUp(
    () {
      mockBudgetsRepository = MockBudgetsRepository();
      insertBudgetUseCase = InsertBudgetUseCase(mockBudgetsRepository);
    },
  );

  test(
    "should insert budgets and return genrated id",
    () async {
      final budget = BudgetsTableCompanion.insert(
        categoryId: 1,
        limitAmount: 500,
      );
      when(mockBudgetsRepository.insertBudget(budget)).thenAnswer((_) async => 1);
      final results = await insertBudgetUseCase.insertBudget(budget);
      expect(results, 1);
      verify(mockBudgetsRepository.insertBudget(budget)).called(1);
    },
  );
}
