import 'package:equatable/equatable.dart';
import 'package:fintrack/features/budgets/domain/models/available_category_with_spending.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';

final class BudgetsState extends Equatable {
  final List<BudgetWithSpending> budgetWithSpending;
  final List<AvailableCategoryWithSpending> availableCategoryWithSpending;
  const BudgetsState({
    this.budgetWithSpending = const [],
    this.availableCategoryWithSpending = const [],
  });
  BudgetsState copyWith({
    List<BudgetWithSpending>? budgetWithSpending,
    List<AvailableCategoryWithSpending>? availableCategoryWithSpending,
  }) => BudgetsState(
    budgetWithSpending: budgetWithSpending ?? this.budgetWithSpending,
    availableCategoryWithSpending: availableCategoryWithSpending ?? this.availableCategoryWithSpending,
  );
  @override
  List<Object> get props => [budgetWithSpending, availableCategoryWithSpending];
}
