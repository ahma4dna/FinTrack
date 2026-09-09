import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/domain/repository/transactions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InsertTransactionUseCase {
  final TransactionsRepository transactionsRepository;

  const InsertTransactionUseCase(this.transactionsRepository);
  Future<int> insertTransaction(TransactionsTableCompanion txn) async {
    return await transactionsRepository.insertTransaction(txn);
  }
}
