import 'package:fintrack/features/accounts/routes/accounts_route.dart';
import 'package:fintrack/features/budgets/routes/budgets_route.dart';
import 'package:fintrack/features/home/routes/home_route.dart';
import 'package:fintrack/features/main/routes/main_route.dart';
import 'package:fintrack/features/reports/routes/reports_route.dart';
import 'package:fintrack/features/splash/routes/splash_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [splasRoute, mainRoute, homeRoute, accountsRoute, budgetsRoute, reportsRoute],
);
