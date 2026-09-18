import 'package:equatable/equatable.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:fintrack/features/home/domain/models/wallets_with_total.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class WatchHomeDataEvent extends HomeEvent {}

class UpdateHomeWalletsEvent extends HomeEvent {
  final WalletsWithTotal walletsData;

  const UpdateHomeWalletsEvent({required this.walletsData});

  @override
  List<Object?> get props => [walletsData];
}

class UpdateHomeBudgetsEvent extends HomeEvent {
  final List<BudgetWithSpending> budgets;

  const UpdateHomeBudgetsEvent({required this.budgets});

  @override
  List<Object?> get props => [budgets];
}

class UpdateHomeTransactionsEvent extends HomeEvent {
  final List<TransactionWithDetails> transactions;

  const UpdateHomeTransactionsEvent({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}
