import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_domain/src/repository/get_settings_repository.dart';

part 'update_theme_mode_use_case.g.dart';

@riverpod
Future<void> updateThemeModeUseCase(Ref ref, {required ThemeMode themeMode}) async {
  final repository = ref.watch(getSettingsRepositoryProvider);

  final entity = repository.get();
  await repository.saveSettings(entity.copyWith(themeMode: themeMode));
}
