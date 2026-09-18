import 'package:drift/drift.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/database/tables/category_table.dart';
import 'package:fintrack/core/database/tables/transactions_table.dart';
import 'package:fintrack/features/reports/domain/models/category_spending.dart';
import 'package:fintrack/features/reports/domain/models/daily_spending.dart';

part 'report_daos.g.dart';

@DriftAccessor(tables: [TransactionsTable, CategoriesTable])
class ReportDaos extends DatabaseAccessor<AppDatabase> with _$ReportDaosMixin {
  new(super.db);
  Future<List<CategorySpending>> getCategorySpending() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    final sum = transactionsTable.amount.sum();

    final query = selectOnly(transactionsTable)
      ..join([
        innerJoin(
          categoriesTable,
          categoriesTable.id.equalsExp(transactionsTable.categoryId),
        ),
      ])
      ..addColumns([categoriesTable.name, categoriesTable.categoryColor, sum])
      ..where(
        transactionsTable.type.equals('expense') &
            transactionsTable.date.isBiggerOrEqualValue(startOfMonth) &
            transactionsTable.date.isSmallerOrEqualValue(endOfMonth),
      )
      ..groupBy([categoriesTable.id]);

    final rows = await query.get();

    return rows.map((row) {
      return CategorySpending(
        name: row.read(categoriesTable.name)!,
        colorHex: row.read(categoriesTable.categoryColor)!,
        amount: row.read(sum) ?? 0.0,
      );
    }).toList();
  }

  Future<List<DailySpending>> getWeeklyTrend() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final weekAgo = DateTime(now.year, now.month, now.day - 6);

    const dayLabels = ['', 'ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'];

    final rows =
        await (select(transactionsTable)..where(
              (t) =>
                  t.type.equals('expense') & t.date.isBiggerOrEqualValue(weekAgo) & t.date.isSmallerOrEqualValue(today),
            ))
            .get();

    final Map<DateTime, double> dailyTotals = {};
    for (final row in rows) {
      final day = DateTime(row.date.year, row.date.month, row.date.day);
      dailyTotals[day] = (dailyTotals[day] ?? 0) + row.amount;
    }

    final results = <DailySpending>[];
    for (int i = 6; i >= 0; i--) {
      final date = DateTime(now.year, now.month, now.day - i);
      final dayKey = DateTime(date.year, date.month, date.day);

      results.add(
        DailySpending(
          date: dayKey,
          label: dayLabels[date.weekday],
          amount: dailyTotals[dayKey] ?? 0,
        ),
      );
    }

    return results;
  }
}
