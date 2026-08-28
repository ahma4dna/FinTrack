import 'package:fintrack/features/budgets/routes/budgets_path.dart';
import 'package:fintrack/features/budgets/presentaion/screens/budgets_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final budgetsRoute = GoRoute(
  path: budgetsPath,
  pageBuilder: (context, state) => CupertinoPage(
    child: BudgetsScreen(),
  ),
);
