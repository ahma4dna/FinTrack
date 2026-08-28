import 'package:fintrack/features/home/presentaion/screens/home_screen.dart';
import 'package:fintrack/features/home/routes/home_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final homeRoute = GoRoute(
  path: homePath,
  pageBuilder: (context, state) => CupertinoPage(
    child: HomeScreen(),
  ),
);
