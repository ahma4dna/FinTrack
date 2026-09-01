import 'package:drift/drift.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/accounts/data/tables/wallets_table.dart';
import 'package:injectable/injectable.dart';
part 'wallet_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [WalletsTable])
class WalletDao extends DatabaseAccessor<AppDatabase> with _$WalletDaoMixin {
  WalletDao(super.db);
  Future<int> insertWallet(WalletsTableCompanion wallet) {
    return into(walletsTable).insert(wallet);
  }

  Stream<List<WalletsTableData>> watchWallet() {
    return select(walletsTable).watch();
  }
}
