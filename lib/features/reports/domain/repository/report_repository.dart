import 'package:fintrack/features/reports/domain/models/category_spending.dart';
import 'package:fintrack/features/reports/domain/models/daily_spending.dart';

abstract class ReportRepository {
  Future<List<CategorySpending>> getCategorySpending();
  Future<List<DailySpending>> getWeeklyTrend();
}
