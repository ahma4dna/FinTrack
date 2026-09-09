import 'package:drift/drift.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/database/tables/category_table.dart';
import 'package:fintrack/core/database/tables/transactions_table.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:fintrack/features/accounts/data/tables/wallets_table.dart';
part 'transactions_daos.g.dart';

@DriftAccessor(tables: [TransactionsTable, WalletsTable, CategoriesTable])
class TransactionsDaos extends DatabaseAccessor<AppDatabase> with _$TransactionsDaosMixin {
  TransactionsDaos(super.db);

  Future<List<CategoriesTableData>> getCategory() async {
    return await select(categoriesTable).get();
  }

  Future<int> insertTransaction(TransactionsTableCompanion txn) async {
    return await transaction(
      () async {
        final id = await into(transactionsTable).insert(txn);
        final wallet = await (select(walletsTable)..where((w) => w.id.equals(txn.walletId.value))).getSingle();
        final double newBalance;
        if (txn.type.value == 'expense') {
          newBalance = wallet.balance - txn.amount.value;
        } else {
          newBalance = wallet.balance + txn.amount.value;
        }
        await (update(walletsTable)..where((w) => w.id.equals(txn.walletId.value))).write(
          WalletsTableCompanion(
            balance: Value(newBalance),
            updatedAt: Value(DateTime.now()),
          ),
        );
        return id;
      },
    );
  }

  Stream<List<TransactionWithDetails>> watchByWallet(int walletId) async* {
    final query = select(transactionsTable).join([
      innerJoin(
        walletsTable,
        walletsTable.id.equalsExp(transactionsTable.walletId),
      ),
      innerJoin(
        categoriesTable,
        categoriesTable.id.equalsExp(transactionsTable.categoryId),
      ),
    ]);

    query
      ..where(transactionsTable.walletId.equals(walletId))
      ..orderBy([OrderingTerm.desc(transactionsTable.date)]);

    yield* query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithDetails(
          transaction: row.readTable(transactionsTable),
          walletName: row.readTable(walletsTable).name,
          categoryName: row.readTable(categoriesTable).name,
          categoryIcon: row.readTable(categoriesTable).iconName,
          categoryColor: row.readTable(categoriesTable).categoryColor,
        );
      }).toList();
    });
  }

  Future<void> deleteTransaction(int transactionId) async {
    await transaction(() async {
      final txn = await (select(transactionsTable)..where((t) => t.id.equals(transactionId))).getSingle();

      final wallet = await (select(walletsTable)..where((w) => w.id.equals(txn.walletId))).getSingle();

      final double newBalance;

      if (txn.type == 'expense') {
        newBalance = wallet.balance + txn.amount;
      } else {
        newBalance = wallet.balance - txn.amount;
      }

      await (update(walletsTable)..where((w) => w.id.equals(txn.walletId))).write(
        WalletsTableCompanion(
          balance: Value(newBalance),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await (delete(transactionsTable)..where((t) => t.id.equals(transactionId))).go();
    });
  }
}
