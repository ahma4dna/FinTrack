import 'package:equatable/equatable.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:fintrack/features/home/domain/models/wallets_with_total.dart';

class HomeState extends Equatable {
  final WalletsWithTotal? walletsData;
  final List<BudgetWithSpending> budgets;
  final List<TransactionWithDetails> recentTransactions;

  const HomeState({
    this.walletsData,
    this.budgets = const [],
    this.recentTransactions = const [],
  });

  HomeState copyWith({
    WalletsWithTotal? walletsData,
    List<BudgetWithSpending>? budgets,
    List<TransactionWithDetails>? recentTransactions,
  }) {
    return HomeState(
      walletsData: walletsData ?? this.walletsData,
      budgets: budgets ?? this.budgets,
      recentTransactions: recentTransactions ?? this.recentTransactions,
    );
  }

  @override
  List<Object?> get props => [walletsData, budgets, recentTransactions];
}
