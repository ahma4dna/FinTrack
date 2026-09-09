// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_daos.dart';

// ignore_for_file: type=lint
mixin _$TransactionsDaosMixin on DatabaseAccessor<AppDatabase> {
  $WalletsTableTable get walletsTable => attachedDatabase.walletsTable;
  $CategoriesTableTable get categoriesTable => attachedDatabase.categoriesTable;
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
  TransactionsDaosManager get managers => TransactionsDaosManager(this);
}

class TransactionsDaosManager {
  final _$TransactionsDaosMixin _db;
  TransactionsDaosManager(this._db);
  $$WalletsTableTableTableManager get walletsTable =>
      $$WalletsTableTableTableManager(_db.attachedDatabase, _db.walletsTable);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.categoriesTable,
      );
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(
        _db.attachedDatabase,
        _db.transactionsTable,
      );
}
