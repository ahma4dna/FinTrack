import 'package:fintrack/features/reports/domain/models/category_spending.dart';
import 'package:fintrack/features/reports/domain/repository/report_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategorySpendingUseCase {
  final ReportRepository repository;

  GetCategorySpendingUseCase(this.repository);

  Future<List<CategorySpending>> call() async {
    return await repository.getCategorySpending();
  }
}
