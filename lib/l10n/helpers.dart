import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const supportedLocales = [
  Locale('en', null),
  Locale('es', null),
];

const localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

Locale? localeResolutionCallback (locale, supportedLocales) {
  if (locale == null) {
    Intl.defaultLocale = supportedLocales.first.toLanguageTag();
    return supportedLocales.first;
  }
  for (var supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode) {
      Intl.defaultLocale = supportedLocale.toLanguageTag();
      return supportedLocale;
    }
  }
  Intl.defaultLocale = supportedLocales.first.toLanguageTag();
  return supportedLocales.first;
}