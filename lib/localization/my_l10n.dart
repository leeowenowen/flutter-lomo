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
      'main.title': 'Orangda',
      'smail_wall.title':'Smile Wall',
      'take_a_photo': 'Take a Photo',
      'select_images': 'Select Images',
      'share.title':'Share Photos',
      'share.title':'Me',
      'common.photo_the_world':'Photo the World!',


    },
    'zh': {
      'main.title': 'Orangda',
      'smail_wall.title':'Smile Wall',
      'take_a_photo': 'Take a Photo',
      'select_images': 'Select Images',
      'share.title':'Share Photos',
      'share.title':'Me',
      'common.photo_the_world':'Photo the World!',
    }
  };

  String get(String key) {
    return _localizedValues[locale.languageCode][key] ?? key + ":UnSet";
  }
}
