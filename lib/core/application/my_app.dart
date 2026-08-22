import 'package:fintrack/core/application/themes/light_theme.dart';
import 'package:fintrack/l10n/app_localizations.dart';
import 'package:fintrack/routes/app_router.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: Locale("ar"),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      themeMode: ThemeMode.dark,
      theme: LightTheme.lightTheme(context: context),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
