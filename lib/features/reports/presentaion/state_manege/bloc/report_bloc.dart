import 'dart:math';

import 'package:fintrack/features/reports/domain/use_case/get_category_spending_use_case.dart';
import 'package:fintrack/features/reports/domain/use_case/get_weekly_trend_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'report_event.dart';
import 'report_state.dart';

@lazySingleton
class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetCategorySpendingUseCase getCategorySpendingUseCase;
  final GetWeeklyTrendUseCase getWeeklyTrendUseCase;

  ReportBloc(
    this.getCategorySpendingUseCase,
    this.getWeeklyTrendUseCase,
  ) : super(const ReportState()) {
    on<GetCategorySpendingEvent>(_getCategorySpending);
    on<GetWeeklyTrendEvent>(_getWeeklyTrend);
  }

  Future<void> _getCategorySpending(
    GetCategorySpendingEvent event,
    Emitter<ReportState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final result = await getCategorySpendingUseCase();

      emit(
        state.copyWith(
          categorySpending: result,
          isLoading: false,
        ),
      );

      log(result.first.amount);
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _getWeeklyTrend(
    GetWeeklyTrendEvent event,
    Emitter<ReportState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final result = await getWeeklyTrendUseCase();

      emit(
        state.copyWith(
          weeklyTrend: result,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
