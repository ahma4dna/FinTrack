import 'package:drift/drift.dart';
import 'package:fintrack/core/database/tables/category_table.dart';

class BudgetsTable extends Table {
  @override
  String get tableName => 'budgets';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().unique().references(CategoriesTable, #id)();
  RealColumn get limitAmount => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
