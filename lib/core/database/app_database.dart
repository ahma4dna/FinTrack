import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fintrack/core/data/dao/transactions_daos.dart';
import 'package:fintrack/core/database/tables/category_table.dart';
import 'package:fintrack/core/database/tables/transactions_table.dart';
import 'package:fintrack/features/accounts/data/dao/wallet_dao.dart';
import 'package:fintrack/features/accounts/data/tables/wallets_table.dart';
import 'package:fintrack/features/budgets/data/dao/budgets_dao.dart';
import 'package:fintrack/features/budgets/data/table/budgets_table.dart';
import 'package:fintrack/features/home/data/daos/home_dao.dart';
import 'package:fintrack/features/reports/data/daos/report_daos.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    WalletsTable,
    CategoriesTable,
    TransactionsTable,
    BudgetsTable,
  ],
  daos: [
    WalletDao,
    TransactionsDaos,
    BudgetsDao,
    ReportDaos,
    HomeDao,
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
            categoryColor: '0xFFC98A2C',
          ),
          CategoriesTableCompanion.insert(
            name: 'التسوق',
            type: 'expense',
            iconName: 'shopping',
            categoryColor: '0xFF0D5C56',
          ),
          CategoriesTableCompanion.insert(
            name: 'المواصلات',
            type: 'expense',
            iconName: 'transport',
            categoryColor: '0xFF4C9A6A',
          ),
          CategoriesTableCompanion.insert(
            name: 'أخرى',
            type: 'expense',
            iconName: 'other',
            categoryColor: '0xFF121820',
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

  @lazySingleton
  BudgetsDao budgetsDao(AppDatabase database) {
    return database.budgetsDao;
  }

  @lazySingleton
  ReportDaos reportDaos(AppDatabase database) {
    return database.reportDaos;
  }

  @lazySingleton
  HomeDao hmeDao(AppDatabase database) {
    return database.homeDao;
  }
}
