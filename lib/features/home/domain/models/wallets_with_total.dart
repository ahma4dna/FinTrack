import 'package:fintrack/core/database/app_database.dart';

class WalletsWithTotal {
  final List<WalletsTableData> wallets;
  final double totalBalance;

  WalletsWithTotal({required this.wallets, required this.totalBalance});
}
