import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/domain/use_case/settings/get_settings_use_case.dart';

part 'get_locale_use_case.g.dart';

@riverpod
Locale getLocaleUseCase(Ref ref) {
  final localeCode = ref.watch(getSettingsUseCaseProvider).locale;
  return Locale(localeCode);
}
