import 'package:fintrack/features/home/data/daos/home_dao.dart';
import 'package:fintrack/features/home/domain/models/wallets_with_total.dart';
import 'package:fintrack/features/home/domain/repository/home_repository.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeDao homeDao;

  HomeRepositoryImpl({
    required this.homeDao,
  });

  @override
  Stream<WalletsWithTotal> watchWalletsWithTotal() {
    return homeDao.watchWalletsWithTotal();
  }

  @override
  Stream<List<TransactionWithDetails>> watchRecentTransactions() {
    return homeDao.watchRecentTransactions(limit: 5);
  }
}
