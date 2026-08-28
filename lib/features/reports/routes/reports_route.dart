import 'package:fintrack/features/budgets/presentaion/screens/budgets_screen.dart';
import 'package:fintrack/features/reports/routes/reports_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final reportsRoute = GoRoute(
  path: reportsPath,
  pageBuilder: (context, state) => CupertinoPage(
    child: BudgetsScreen(),
  ),
);
