import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_domain/src/use_case/get_settings_use_case.dart';

part 'get_theme_mode_use_case.g.dart';

@riverpod
ThemeMode getThemeModeUseCase(Ref ref) {
  return ref.watch(getSettingsUseCaseProvider.select((data) => data.themeMode));
}
