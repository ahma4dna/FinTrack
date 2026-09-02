import 'package:drift/drift.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/accounts/data/dao/wallet_dao.dart';
import 'package:fintrack/features/accounts/domain/mapper/wallet_table_mapper.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:fintrack/features/accounts/domain/repository/wellets_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WelletsRepository)
class WelletsRepositoryImp implements WelletsRepository {
  final WalletDao walletDao;

  WelletsRepositoryImp({required this.walletDao});
  @override
  Future<int> insertWallet(WalletModel wallet) async {
    return await walletDao.insertWallet(
      WalletsTableCompanion.insert(
        name: wallet.name,
        balance: Value(wallet.balance),
        type: Value(wallet.type),
        iconName: Value(wallet.iconName),
        sortOrder: Value(wallet.sortOrder),
        isArchived: Value(wallet.isArchived),
        createdAt: Value(wallet.createdAt ?? DateTime.now()),
        updatedAt: Value(wallet.updatedAt ?? DateTime.now()),
      ),
    );
  }

  @override
  Stream<List<WalletModel>> watchWallet() async* {
    yield* walletDao.watchWallet().map(
      (items) => items.map((item) => item.toModel()).toList(),
    );
  }
}
