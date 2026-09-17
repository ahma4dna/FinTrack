import 'package:drift/drift.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/database/tables/category_table.dart';
import 'package:fintrack/core/database/tables/transactions_table.dart';
import 'package:fintrack/features/budgets/data/table/budgets_table.dart';
import 'package:fintrack/features/budgets/domain/models/available_category_with_spending.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';
part 'budgets_dao.g.dart';

@DriftAccessor(tables: [BudgetsTable, TransactionsTable, CategoriesTable])
class BudgetsDao extends DatabaseAccessor<AppDatabase> with _$BudgetsDaoMixin {
  BudgetsDao(super.db);

  Future<int> insertBudget(BudgetsTableCompanion budget) async {
    return await into(budgetsTable).insert(budget);
  }

  Stream<List<BudgetWithSpending>> watchAll() async* {
    final query = select(budgetsTable).join([
      innerJoin(
        categoriesTable,
        categoriesTable.id.equalsExp(budgetsTable.categoryId),
      ),
    ]);
    yield* query.watch().asyncMap((rows) async {
      final results = <BudgetWithSpending>[];
      for (final row in rows) {
        final budget = row.readTable(budgetsTable);
        final category = row.readTable(categoriesTable);
        final spent = await _getSpentThisMonth(budget.categoryId);
        results.add(
          BudgetWithSpending(
            budget: budget,
            categoryName: category.name,
            categoryIcon: category.iconName,
            categoryColor: category.categoryColor,
            spent: spent,
          ),
        );
      }
      return results;
    });
  }

  Future<double> _getSpentThisMonth(int categoryId) async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    final sum = transactionsTable.amount.sum();
    final query = selectOnly(transactionsTable)
      ..addColumns([sum])
      ..where(
        transactionsTable.type.equals('expense') &
            transactionsTable.categoryId.equals(categoryId) &
            transactionsTable.date.isBiggerOrEqualValue(startOfMonth) &
            transactionsTable.date.isSmallerOrEqualValue(endOfMonth),
      );
    return await query.map((row) => row.read(sum) ?? 0.0).getSingle();
  }

  Stream<List<AvailableCategoryWithSpending>> getAvailableCategories() async* {
    final query = select(categoriesTable)
      ..where((c) => c.type.equals('expense'))
      ..orderBy([(c) => OrderingTerm.asc(c.id)]);

    yield* query.watch().asyncMap((allExpenseCategories) async {
      final existingBudgets = await select(budgetsTable).get();

      final usedCategoryIds = existingBudgets.map((b) => b.categoryId).toSet();

      final available = allExpenseCategories.where((c) => !usedCategoryIds.contains(c.id)).toList();

      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(
        now.year,
        now.month + 1,
        0,
        23,
        59,
        59,
      );

      final results = <AvailableCategoryWithSpending>[];

      for (final cat in available) {
        final sum = transactionsTable.amount.sum();

        final query = selectOnly(transactionsTable)
          ..addColumns([sum])
          ..where(
            transactionsTable.type.equals('expense') &
                transactionsTable.categoryId.equals(cat.id) &
                transactionsTable.date.isBiggerOrEqualValue(startOfMonth) &
                transactionsTable.date.isSmallerOrEqualValue(endOfMonth),
          );

        final spent = await query.map((row) => row.read(sum) ?? 0.0).getSingle();

        results.add(
          AvailableCategoryWithSpending(
            categoryId: cat.id,
            name: cat.name,
            iconName: cat.iconName,
            colorHex: cat.categoryColor,
            spentThisMonth: spent,
          ),
        );
      }

      return results;
    });
  }
}
