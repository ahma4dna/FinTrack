import 'dart:async';

import 'package:fintrack/features/budgets/domain/use_case/watch_all_budget_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_event.dart';
import 'home_state.dart';

import 'package:fintrack/features/home/domain/use_case/watch_home_wallets_use_case.dart';
import 'package:fintrack/features/home/domain/use_case/watch_home_transactions_use_case.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WatchHomeWalletsUseCase watchHomeWalletsUseCase;
  final WatchAllBudgetUseCase watchAllBudgetUseCase;
  final WatchHomeTransactionsUseCase watchHomeTransactionsUseCase;

  StreamSubscription? _walletsSubscription;
  StreamSubscription? _budgetsSubscription;
  StreamSubscription? _transactionsSubscription;

  HomeBloc({
    required this.watchHomeWalletsUseCase,
    required this.watchAllBudgetUseCase,
    required this.watchHomeTransactionsUseCase,
  }) : super(HomeState()) {
    on<WatchHomeDataEvent>(_watchHomeData);
    on<UpdateHomeWalletsEvent>(_updateWallets);
    on<UpdateHomeBudgetsEvent>(_updateBudgets);
    on<UpdateHomeTransactionsEvent>(_updateTransactions);
  }

  Future<void> _watchHomeData(WatchHomeDataEvent event, Emitter<HomeState> emit) async {
    await _walletsSubscription?.cancel();
    _walletsSubscription = watchHomeWalletsUseCase.call().listen((data) {
      add(UpdateHomeWalletsEvent(walletsData: data));
    });

    await _budgetsSubscription?.cancel();
    _budgetsSubscription = watchAllBudgetUseCase.watchAll().listen((data) {
      add(UpdateHomeBudgetsEvent(budgets: data));
    });

    await _transactionsSubscription?.cancel();
    _transactionsSubscription = watchHomeTransactionsUseCase.call().listen((data) {
      add(UpdateHomeTransactionsEvent(transactions: data));
    });
  }

  void _updateWallets(UpdateHomeWalletsEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(walletsData: event.walletsData));
  }

  void _updateBudgets(UpdateHomeBudgetsEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(budgets: event.budgets));
  }

  void _updateTransactions(UpdateHomeTransactionsEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(recentTransactions: event.transactions));
  }

  @override
  Future<void> close() {
    _walletsSubscription?.cancel();
    _budgetsSubscription?.cancel();
    _transactionsSubscription?.cancel();
    return super.close();
  }
}
