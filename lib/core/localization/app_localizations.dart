import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppLocalizations {
  static const supportedLocales = [Locale('en'), Locale('ar')];

  static LocaleResolutionCallback get localeResolutionCallback =>
      (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      };
}

extension LocalizationExtension on BuildContext {
  String tr(String key) => key.tr();
}
