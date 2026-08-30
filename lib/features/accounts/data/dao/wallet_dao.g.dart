// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_dao.dart';

// ignore_for_file: type=lint
mixin _$WalletDaoMixin on DatabaseAccessor<AppDatabase> {
  $WalletsTableTable get walletsTable => attachedDatabase.walletsTable;
  WalletDaoManager get managers => WalletDaoManager(this);
}

class WalletDaoManager {
  final _$WalletDaoMixin _db;
  WalletDaoManager(this._db);
  $$WalletsTableTableTableManager get walletsTable =>
      $$WalletsTableTableTableManager(_db.attachedDatabase, _db.walletsTable);
}
