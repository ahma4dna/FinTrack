import 'package:equatable/equatable.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/budgets/domain/models/available_category_with_spending.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';

sealed class BudgetsEvent extends Equatable {
  const BudgetsEvent();

  @override
  List<Object> get props => [];
}

final class InsertBudgetsEvent extends BudgetsEvent {
  final BudgetsTableCompanion budget;
  const InsertBudgetsEvent({required this.budget});

  @override
  List<Object> get props => [budget];
}

final class WatchBudgetsEvent extends BudgetsEvent {
  const WatchBudgetsEvent();
  @override
  List<Object> get props => [];
}

final class UpdateBudgetsEvent extends BudgetsEvent {
  final List<BudgetWithSpending> budgetWithSpending;
  const UpdateBudgetsEvent({required this.budgetWithSpending});
  @override
  List<Object> get props => [budgetWithSpending];
}

final class GetAvailableCategoriesEvent extends BudgetsEvent {
  const GetAvailableCategoriesEvent();
  @override
  List<Object> get props => [];
}

final class UpdateAvailableCategoriesEvent extends BudgetsEvent {
  final List<AvailableCategoryWithSpending> availableCategoryWithSpending;
  const UpdateAvailableCategoriesEvent({required this.availableCategoryWithSpending});
  @override
  List<Object> get props => [availableCategoryWithSpending];
}
