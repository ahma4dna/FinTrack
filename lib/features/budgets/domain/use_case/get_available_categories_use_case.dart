import 'package:fintrack/features/budgets/domain/models/available_category_with_spending.dart';
import 'package:fintrack/features/budgets/domain/repository/budgets_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAvailableCategoriesUseCase {
  final BudgetsRepository budgetsRepository;

  const GetAvailableCategoriesUseCase(this.budgetsRepository);
  Stream<List<AvailableCategoryWithSpending>> getAvailableCategories() async* {
    yield* budgetsRepository.getAvailableCategories();
  }
}
