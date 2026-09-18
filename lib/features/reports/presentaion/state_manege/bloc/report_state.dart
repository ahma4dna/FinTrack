import 'package:equatable/equatable.dart';
import 'package:fintrack/features/reports/domain/models/category_spending.dart';
import 'package:fintrack/features/reports/domain/models/daily_spending.dart';

class ReportState extends Equatable {
  final List<CategorySpending> categorySpending;
  final List<DailySpending> weeklyTrend;

  final bool isLoading;
  final String? errorMessage;

  const ReportState({
    this.categorySpending = const [],
    this.weeklyTrend = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ReportState copyWith({
    List<CategorySpending>? categorySpending,
    List<DailySpending>? weeklyTrend,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ReportState(
      categorySpending: categorySpending ?? this.categorySpending,
      weeklyTrend: weeklyTrend ?? this.weeklyTrend,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    categorySpending,
    weeklyTrend,
    isLoading,
    errorMessage,
  ];
}
