import 'package:drift/drift.dart';

class WalletsTable extends Table {
  @override
  String get tableName => 'wallets';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text().withDefault(const Constant('cash'))();
  RealColumn get balance => real().withDefault(const Constant(0.0))();
  TextColumn get iconName => text().withDefault(const Constant('wallet'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
