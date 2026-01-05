import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}

extension LocaleX on BuildContext {
  Locale get locale => Localizations.localeOf(this);
}
