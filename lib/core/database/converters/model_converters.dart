// import 'package:fintrack/features/accounts/data/tables/wallets_table.dart';
// import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';

// class ModelConverters {
//   // ── Wallet ──
//   static WalletModel walletFromDb(WalletsTable row) {
//     return WalletModel(
//       id: row.id,
//       name: row.name,
//       type: row.type,
//       balance: row.balance,
//       iconName: row.iconName,
//       colorHex: row.colorHex,
//       sortOrder: row.sortOrder,
//       isArchived: row.isArchived,
//       createdAt: row.createdAt,
//       updatedAt: row.updatedAt,
//     );
//   }

//   static WalletsTableCompanion walletToDb(WalletModel model) {
//     return WalletsTableCompanion.insert(
//       name: model.name,
//       type: Value(model.type),
//       balance: Value(model.balance),
//       iconName: Value(model.iconName),
//       colorHex: Value(model.colorHex),
//       sortOrder: Value(model.sortOrder),
//       isArchived: Value(model.isArchived),
//     );
//   }
// }
