import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';

abstract class TransactionsRepository {
  Future<int> insertTransaction(TransactionsTableCompanion txn);
  Stream<List<TransactionWithDetails>> watchByWallet(int walletId);
  Future<void> deleteTransaction(int transactionId);
  Future<List<CategoriesTableData>> getCategory();
}
