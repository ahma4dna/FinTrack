import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';

extension WalletTableMapper on WalletsTableData {
  WalletModel toModel() {
    return WalletModel(
      id: id,
      name: name,
      balance: balance,
      type: type,
      iconName: iconName,
      sortOrder: sortOrder,
      isArchived: isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
