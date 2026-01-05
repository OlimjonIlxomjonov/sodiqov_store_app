import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageStorage {
  static const _key = 'selected_language';

  static Future<void> save(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }

  static Future<Locale> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? "uz";
    return Locale(code);
  }
}
