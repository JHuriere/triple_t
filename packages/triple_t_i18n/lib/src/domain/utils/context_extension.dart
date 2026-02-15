import 'package:flutter/material.dart';
import 'package:triple_t_i18n/l10n/generated/app_localizations.g.dart';

extension BuildContextLocale on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
