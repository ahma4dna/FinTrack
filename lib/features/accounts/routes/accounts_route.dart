import 'package:fintrack/features/accounts/presentaion/screens/accounts_screen.dart';
import 'package:fintrack/features/accounts/presentaion/screens/add_new_accounts_screen.dart';
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
  ],
);
