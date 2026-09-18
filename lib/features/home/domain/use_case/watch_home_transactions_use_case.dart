import 'package:fintrack/features/home/domain/repository/home_repository.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchHomeTransactionsUseCase {
  final HomeRepository repository;
  WatchHomeTransactionsUseCase(this.repository);

  Stream<List<TransactionWithDetails>> call() => repository.watchRecentTransactions();
}
