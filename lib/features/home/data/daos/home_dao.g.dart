// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dao.dart';

// ignore_for_file: type=lint
mixin _$HomeDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriesTableTable get categoriesTable => attachedDatabase.categoriesTable;
  $BudgetsTableTable get budgetsTable => attachedDatabase.budgetsTable;
  $WalletsTableTable get walletsTable => attachedDatabase.walletsTable;
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
  HomeDaoManager get managers => HomeDaoManager(this);
}

class HomeDaoManager {
  final _$HomeDaoMixin _db;
  HomeDaoManager(this._db);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.categoriesTable,
      );
  $$BudgetsTableTableTableManager get budgetsTable =>
      $$BudgetsTableTableTableManager(_db.attachedDatabase, _db.budgetsTable);
  $$WalletsTableTableTableManager get walletsTable =>
      $$WalletsTableTableTableManager(_db.attachedDatabase, _db.walletsTable);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(
        _db.attachedDatabase,
        _db.transactionsTable,
      );
}
