import 'package:fintrack/features/budgets/domain/models/budget_model.dart';
import 'package:fintrack/features/budgets/domain/repository/budgets_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchAllBudgetUseCase {
  final BudgetsRepository budgetsRepository;

  const WatchAllBudgetUseCase(this.budgetsRepository);
  Stream<List<BudgetWithSpending>> watchAll() async* {
    yield* budgetsRepository.watchAll();
  }
}
