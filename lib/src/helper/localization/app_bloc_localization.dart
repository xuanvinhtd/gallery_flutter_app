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
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  // Tab
  String get photos => Intl.message(
        'Photos',
        name: 'photos',
        args: [],
        locale: locale.toString(),
      );

  String get videos => Intl.message(
        'Videos',
        name: 'videos',
        args: [],
        locale: locale.toString(),
      );

  String get cloud => Intl.message(
        'Cloud',
        name: 'cloud',
        args: [],
        locale: locale.toString(),
      );
  String get album => Intl.message(
        'Album',
        name: 'album',
        args: [],
        locale: locale.toString(),
      );
  String get allMedia => Intl.message(
        'All',
        name: 'allMedia',
        args: [],
        locale: locale.toString(),
      );
  String get gallery => Intl.message(
        'Gallery',
        name: 'gallery',
        args: [],
        locale: locale.toString(),
      );
  String get items => Intl.message(
        'Items',
        name: 'items',
        args: [],
        locale: locale.toString(),
      );
}

class AppBlocLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalization> {
  late Locale? forceLocale;

  @override
  Future<AppLocalization> load(Locale locale) {
    if (forceLocale != null) {
      return AppLocalization.load(forceLocale!);
    }
    return AppLocalization.load(locale);
  }

  @override
  bool shouldReload(AppBlocLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) => ['vi', 'en'].contains(locale.languageCode);
}
