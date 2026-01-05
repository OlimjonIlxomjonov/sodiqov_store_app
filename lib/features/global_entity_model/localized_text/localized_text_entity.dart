import 'dart:ui';

class LocalizedTextEntity {
  final String ru;
  final String uz;

  LocalizedTextEntity({required this.ru, required this.uz});

  String byLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'ru':
        return ru;
      case 'uz':
      default:
        return uz;
    }
  }
}
