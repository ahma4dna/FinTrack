import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fintrack/core/data/dao/transactions_daos.dart';
import 'package:fintrack/core/database/tables/category_table.dart';
import 'package:fintrack/core/database/tables/transactions_table.dart';
import 'package:fintrack/features/accounts/data/dao/wallet_dao.dart';
import 'package:fintrack/features/accounts/data/tables/wallets_table.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    WalletsTable,
    CategoriesTable,
    TransactionsTable,
  ],
  daos: [
    WalletDao,
    TransactionsDaos,
  ],
)
@lazySingleton
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await _insertDefaultCategories();
    },
  );

  Future<void> _insertDefaultCategories() async {
    await batch((batch) {
      batch.insertAll(
        categoriesTable,
        [
          CategoriesTableCompanion.insert(
            name: 'الطعام',
            type: 'expense',
            iconName: 'food',
            categoryColor: '0XFFC98A2C',
          ),
          CategoriesTableCompanion.insert(
            name: 'التسوق',
            type: 'expense',
            iconName: 'shopping',
            categoryColor: '0XFF0D5C56',
          ),
          CategoriesTableCompanion.insert(
            name: 'المواصلات',
            type: 'expense',
            iconName: 'transport',
            categoryColor: '0XFF0D5C56',
          ),
          CategoriesTableCompanion.insert(
            name: 'أخرى',
            type: 'expense',
            iconName: 'other',
            categoryColor: '0XFF121820',
          ),
        ],
      );
    });
  }
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

  @lazySingleton
  TransactionsDaos transactionsDaos(AppDatabase database) {
    return database.transactionsDaos;
  }
}
