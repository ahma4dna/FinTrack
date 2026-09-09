import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:fintrack/features/accounts/presentaion/screens/accounts_screen.dart';
import 'package:fintrack/features/accounts/presentaion/screens/add_new_accounts_screen.dart';
import 'package:fintrack/features/accounts/presentaion/screens/transaction_wallet_screen.dart';
import 'package:fintrack/features/accounts/routes/accounts_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final accountsRoute = GoRoute(
  path: accountsPath,
  pageBuilder: (context, state) => CupertinoPage(
    child: AccountsScreen(),
  ),
  routes: [
    GoRoute(
      path: addNewaccountPathe,
      pageBuilder: (context, state) {
        return CupertinoPage(
          child: AddNewAccountsScreen(),
        );
      },
    ),
    GoRoute(
      path: tranactionWallet,
      name: "tranaction-Wallet",
      pageBuilder: (context, state) {
        final WalletModel extra = state.extra as WalletModel;
        return CupertinoPage(
          child: TransactionWalletScreen(walletModel: extra),
        );
      },
    ),
  ],
);
