import 'package:drift/drift.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/accounts/data/tables/wallets_table.dart';
part 'wallet_dao.g.dart';

@DriftAccessor(tables: [WalletsTable])
class WalletDao extends DatabaseAccessor<AppDatabase> with _$WalletDaoMixin {
  WalletDao(super.db);
  Future<int> insertWallet(WalletsTableCompanion wallet) async {
    return await into(walletsTable).insert(wallet);
  }

  Stream<List<WalletsTableData>> watchWallet() {
    return (select(walletsTable)..orderBy([
          (t) => OrderingTerm(
            expression: t.id,
            mode: OrderingMode.desc,
          ),
        ]))
        .watch();
  }
}
