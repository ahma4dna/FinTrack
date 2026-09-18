import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:fintrack/features/home/domain/models/wallets_with_total.dart';

abstract class HomeRepository {
  Stream<WalletsWithTotal> watchWalletsWithTotal();
  Stream<List<TransactionWithDetails>> watchRecentTransactions();
}
