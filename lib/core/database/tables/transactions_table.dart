import 'package:drift/drift.dart';
import 'package:fintrack/core/database/tables/category_table.dart';
import 'package:fintrack/features/accounts/data/tables/wallets_table.dart';

class TransactionsTable extends Table {
  @override
  String get tableName => 'transactions';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get walletId => integer().references(WalletsTable, #id)();
  IntColumn get categoryId => integer().references(CategoriesTable, #id)();
  TextColumn get type => text()();
  RealColumn get amount => real()();
  TextColumn get title => text().withLength(min: 1, max: 200)(); // العنوان
  TextColumn get note => text().nullable()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
