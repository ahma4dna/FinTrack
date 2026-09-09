import 'package:fintrack/core/data/dao/transactions_daos.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:fintrack/core/domain/repository/transactions_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TransactionsRepository)
class TransactionsRepositoryImp implements TransactionsRepository {
  final TransactionsDaos transactionsDaos;
  const TransactionsRepositoryImp({required this.transactionsDaos});
  @override
  Future<void> deleteTransaction(int transactionId) async {
    return await transactionsDaos.deleteTransaction(transactionId);
  }

  @override
  Future<int> insertTransaction(TransactionsTableCompanion txn) async {
    return await transactionsDaos.insertTransaction(txn);
  }

  @override
  Stream<List<TransactionWithDetails>> watchByWallet(int walletId) async* {
    yield* transactionsDaos.watchByWallet(walletId);
  }

  @override
  Future<List<CategoriesTableData>> getCategory() async {
    return await transactionsDaos.getCategory();
  }
}
