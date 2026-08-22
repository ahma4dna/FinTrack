import 'package:fintrack/features/splash/presentaion/screens/splash_screen.dart';
import 'package:fintrack/features/splash/routes/pathe_route_splsh.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final splasRoute = GoRoute(
  path: pathplah,
  pageBuilder: (context, state) {
    return CupertinoPage(
      child: SplashScreen(),
    );
  },
);
