import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:fintrack/core/domain/repository/transactions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchByWalletUseCase {
  final TransactionsRepository transactionsRepository;

  const WatchByWalletUseCase(this.transactionsRepository);
  Stream<List<TransactionWithDetails>> watchByWallet(int walletId) async* {
    yield* transactionsRepository.watchByWallet(walletId);
  }
}
