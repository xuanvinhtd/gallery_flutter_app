import 'package:gallery_app/src/helper/localization/localization_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;

  static Future<AppLocalization> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return AppLocalization(locale);
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // Tab
  String get home => Intl.message(
        'Home',
        name: 'home',
        args: [],
        locale: locale.toString(),
      );

  String get search => Intl.message(
        'Search',
        name: 'search',
        args: [],
        locale: locale.toString(),
      );

  String get favorite => Intl.message(
        'Favorite',
        name: 'favorite',
        args: [],
        locale: locale.toString(),
      );
}

class AppBlocLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalization> {
  Locale forceLocale;

  @override
  Future<AppLocalization> load(Locale locale) {
    if (forceLocale != null) {
      return AppLocalization.load(forceLocale);
    }
    return AppLocalization.load(locale);
  }

  @override
  bool shouldReload(AppBlocLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) => ['vi', 'en'].contains(locale.languageCode);
}
