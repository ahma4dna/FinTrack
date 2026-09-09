import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/domain/repository/transactions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategoryUseCase {
  final TransactionsRepository transactionsRepository;

  const GetCategoryUseCase(this.transactionsRepository);
  Future<List<CategoriesTableData>> getCategory() async {
    return await transactionsRepository.getCategory();
  }
}
