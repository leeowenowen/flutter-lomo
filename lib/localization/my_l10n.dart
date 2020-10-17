import 'dart:ui';

import 'package:flutter/cupertino.dart';

class MyLocalizations {
  final Locale locale;

  MyLocalizations(this.locale);

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'main.title': 'Oranda',

    },
    'zh': {
      'main.title': '合拍世界',
    }
  };

  String get(String key) {
    return _localizedValues[locale.languageCode][key] ?? key + ":UnSet";
  }
}