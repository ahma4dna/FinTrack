import 'package:fintrack/features/reports/domain/models/daily_spending.dart';
import 'package:fintrack/features/reports/domain/repository/report_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWeeklyTrendUseCase {
  final ReportRepository repository;

  GetWeeklyTrendUseCase(this.repository);

  Future<List<DailySpending>> call() async {
    return await repository.getWeeklyTrend();
  }
}
