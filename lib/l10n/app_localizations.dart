import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ar')];

  /// No description provided for @test.
  ///
  /// In ar, this message translates to:
  /// **'test '**
  String get test;

  /// No description provided for @fin_track.
  ///
  /// In ar, this message translates to:
  /// **'FinTrack '**
  String get fin_track;

  /// No description provided for @org_mony_smart.
  ///
  /// In ar, this message translates to:
  /// **'نظم أموالك بذكاء '**
  String get org_mony_smart;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @account.
  ///
  /// In ar, this message translates to:
  /// **'الحسابات'**
  String get account;

  /// No description provided for @budget.
  ///
  /// In ar, this message translates to:
  /// **'الميزانيات'**
  String get budget;

  /// No description provided for @report.
  ///
  /// In ar, this message translates to:
  /// **'التقارير'**
  String get report;

  /// No description provided for @add_new_account.
  ///
  /// In ar, this message translates to:
  /// **'إضافة حساب جديد'**
  String get add_new_account;

  /// No description provided for @add_account.
  ///
  /// In ar, this message translates to:
  /// **'إضافة حساب'**
  String get add_account;

  /// No description provided for @account_name.
  ///
  /// In ar, this message translates to:
  /// **'اسم الحساب'**
  String get account_name;

  /// No description provided for @ex_wallet_day.
  ///
  /// In ar, this message translates to:
  /// **'مثال: محفظة اليومية'**
  String get ex_wallet_day;

  /// No description provided for @type_account.
  ///
  /// In ar, this message translates to:
  /// **'نوع الحساب'**
  String get type_account;

  /// No description provided for @cash.
  ///
  /// In ar, this message translates to:
  /// **'نقدي'**
  String get cash;

  /// No description provided for @bank.
  ///
  /// In ar, this message translates to:
  /// **'بنكي'**
  String get bank;

  /// No description provided for @cridit.
  ///
  /// In ar, this message translates to:
  /// **'ائتمان'**
  String get cridit;

  /// No description provided for @balance_first.
  ///
  /// In ar, this message translates to:
  /// **'الرصيد الافتتاحي'**
  String get balance_first;

  /// No description provided for @save_account.
  ///
  /// In ar, this message translates to:
  /// **'حفظ الحساب'**
  String get save_account;

  /// No description provided for @not_add_account.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم إضافة حساب '**
  String get not_add_account;

  /// No description provided for @this_fiald_requaird.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get this_fiald_requaird;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
