import 'package:drift/drift.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/database/tables/category_table.dart';
import 'package:fintrack/core/database/tables/transactions_table.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:fintrack/features/budgets/data/table/budgets_table.dart';
import 'package:fintrack/features/home/domain/models/wallets_with_total.dart';
part 'home_dao.g.dart';

@DriftAccessor(tables: [BudgetsTable, TransactionsTable, CategoriesTable])
class HomeDao extends DatabaseAccessor<AppDatabase> with _$HomeDaoMixin {
  new(super.db);
  Stream<WalletsWithTotal> watchWalletsWithTotal() async* {
    final sum = walletsTable.balance.sum();
    final totalQuery = selectOnly(walletsTable)..addColumns([sum]);

    final walletsQuery = select(walletsTable)
      ..orderBy([
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ]);
    yield* walletsQuery.watch().asyncMap((wallets) async {
      final total = await totalQuery.map((row) => row.read(sum) ?? 0.0).getSingle();
      return WalletsWithTotal(wallets: wallets, totalBalance: total);
    });
  }

  Stream<List<TransactionWithDetails>> watchRecentTransactions({int limit = 5}) async* {
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
      ..orderBy([OrderingTerm.desc(transactionsTable.date)])
      ..limit(limit);

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
}
