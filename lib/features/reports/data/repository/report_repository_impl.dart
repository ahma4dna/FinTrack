import 'package:fintrack/features/reports/data/daos/report_daos.dart';
import 'package:fintrack/features/reports/domain/models/category_spending.dart';
import 'package:fintrack/features/reports/domain/models/daily_spending.dart';
import 'package:fintrack/features/reports/domain/repository/report_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ReportRepository)
class ReportRepositoryImpl implements ReportRepository {
  final ReportDaos reportDaos;

  ReportRepositoryImpl(this.reportDaos);

  @override
  Future<List<CategorySpending>> getCategorySpending() async {
    return await reportDaos.getCategorySpending();
  }

  @override
  Future<List<DailySpending>> getWeeklyTrend() async {
    return await reportDaos.getWeeklyTrend();
  }
}
