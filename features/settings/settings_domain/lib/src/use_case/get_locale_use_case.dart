import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_domain/src/use_case/get_settings_use_case.dart';

part 'get_locale_use_case.g.dart';

@riverpod
Locale getLocaleUseCase(Ref ref) {
  final localeCode = ref.watch(getSettingsUseCaseProvider).locale;
  return Locale(localeCode);
}
