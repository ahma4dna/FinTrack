import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fintrack/features/accounts/data/dao/wallet_dao.dart';
import 'package:fintrack/features/accounts/data/tables/wallets_table.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    WalletsTable,
  ],
  daos: [
    WalletDao,
  ],
)
@lazySingleton
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);
  @override
  int get schemaVersion => 1;
}

@module
abstract class DatabaseModule {
  @preResolve
  Future<QueryExecutor> get databaseConnection async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File(
      '${directory.path}/fintrack.sqlite',
    );
    return NativeDatabase.createInBackground(file);
  }

  @lazySingleton
  WalletDao walletDao(AppDatabase database) {
    return database.walletDao;
  }
}
