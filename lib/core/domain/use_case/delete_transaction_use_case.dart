import 'package:fintrack/core/domain/repository/transactions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteTransactionUseCase {
  final TransactionsRepository transactionsRepository;

  const DeleteTransactionUseCase(this.transactionsRepository);
  Future<void> deleteTransaction(int transactionId) async {
    return await transactionsRepository.deleteTransaction(transactionId);
  }
}
