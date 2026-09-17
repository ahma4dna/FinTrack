import 'dart:async';

import 'package:fintrack/features/budgets/domain/use_case/get_available_categories_use_case.dart';
import 'package:fintrack/features/budgets/domain/use_case/insert_budget_use_case.dart';
import 'package:fintrack/features/budgets/domain/use_case/watch_all_budget_use_case.dart';
import 'package:fintrack/features/budgets/presentaion/state_manege/bloc/budgets_event.dart';
import 'package:fintrack/features/budgets/presentaion/state_manege/bloc/budgets_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BudgetsBloc extends Bloc<BudgetsEvent, BudgetsState> {
  final InsertBudgetUseCase insertBudgetUseCase;
  final WatchAllBudgetUseCase watchAllBudgetUseCase;
  final GetAvailableCategoriesUseCase getAvailableCategoriesUseCase;
  StreamSubscription? _streamSubscription;
  StreamSubscription? _streamSubscriptioAvalableCat;
  BudgetsBloc({
    required this.insertBudgetUseCase,
    required this.watchAllBudgetUseCase,
    required this.getAvailableCategoriesUseCase,
  }) : super(BudgetsState()) {
    on<InsertBudgetsEvent>(_insertBudgets);
    on<WatchBudgetsEvent>(_watchBudgets);
    on<UpdateBudgetsEvent>(_updateBudgets);
    on<GetAvailableCategoriesEvent>(_getAvailableCategories);
    on<UpdateAvailableCategoriesEvent>(_updatAvailableCategories);
  }

  Future<void> _getAvailableCategories(
    GetAvailableCategoriesEvent event,
    Emitter<BudgetsState> emit,
  ) async {
    await _streamSubscriptioAvalableCat?.cancel();
    _streamSubscriptioAvalableCat = getAvailableCategoriesUseCase.getAvailableCategories().listen(
      (availableCategoryWithSpending) {
        add(
          UpdateAvailableCategoriesEvent(availableCategoryWithSpending: availableCategoryWithSpending),
        );
      },
    );
  }

  Future<void> _updatAvailableCategories(
    UpdateAvailableCategoriesEvent event,
    Emitter<BudgetsState> emit,
  ) async {
    emit(state.copyWith(availableCategoryWithSpending: event.availableCategoryWithSpending));
  }

  Future<int> _insertBudgets(InsertBudgetsEvent event, Emitter<BudgetsState> emit) async {
    return await insertBudgetUseCase.insertBudget(event.budget);
  }

  Future<void> _watchBudgets(WatchBudgetsEvent event, Emitter<BudgetsState> emit) async {
    await _streamSubscription?.cancel();
    _streamSubscription = watchAllBudgetUseCase.watchAll().listen(
      (budgetWithSpending) {
        add(UpdateBudgetsEvent(budgetWithSpending: budgetWithSpending));
      },
    );
  }

  Future<void> _updateBudgets(UpdateBudgetsEvent event, Emitter<BudgetsState> emit) async {
    emit(state.copyWith(budgetWithSpending: event.budgetWithSpending));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _streamSubscriptioAvalableCat?.cancel();
    return super.close();
  }
}
