import 'package:drift/drift.dart';
import 'package:fintrack/features/accounts/data/dao/wallet_dao.dart';
import 'package:fintrack/features/accounts/data/tables/wallets_table.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    WalletsTable,
  ],
  daos: [
    WalletDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
