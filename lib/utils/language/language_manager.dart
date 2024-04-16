import 'package:flutter/material.dart';
import 'package:tech_control/utils/language/russian.dart';
import 'package:tech_control/utils/language/uzbek.dart';

import '../../data/database/cache.dart';
import 'english.dart';
import 'language.dart';

class LanguageManager {
  final BuildContext context;
  List<Language> languages = [];
  final String languageKey = 'language';

  LanguageManager(this.context) {
    languages = [
      Uzbek(),
      Russian(),
      English(),
    ];
  }

  Language get currentLanguage => findLanguageById(
    (cache.getInt(cache.language) as int?) ?? 0,
  );


  set currentLanguage(Language value) => cache.setInt(cache.language, value.id);

  Language findLanguageById(int id) {
    for (var language in languages) {
      if (language.id == id) {
        return language;
      }
    }
    return languages[0];
  }

  String isNull(String? string) => string ?? "";
}
