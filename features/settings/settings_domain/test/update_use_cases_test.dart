import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_data/settings_data.dart';
import 'package:settings_domain/src/use_case/update_locale_use_case.dart';
import 'package:settings_domain/src/use_case/update_theme_mode_use_case.dart';
import 'package:tt_database/tt_database.dart';

void main() {
  setUp(() async {
    // inject an in-memory database for repository to use
    final db = await databaseFactoryMemory.openDatabase('test.db');
    TripleTDatabase.setTestDatabase(db);
  });

  test('updateLocaleUseCase saves new locale', () async {
    // use ProviderContainer normally and call the update use case

    final container = ProviderContainer();
    addTearDown(container.dispose);

    // ensure default settings exist
    final repo = container.read(settingsRepositoryProvider);
    await repo.saveSettings(SettingsEntity(id: 'settings', themeMode: 'system', locale: 'fr'));

    await container.read(updateLocaleUseCaseProvider(locale: 'en').future);

    final saved = repo.get();
    expect(saved.locale, 'en');
  });

  test('updateThemeModeUseCase saves new themeMode', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final repo = container.read(settingsRepositoryProvider);
    await repo.saveSettings(SettingsEntity(id: 'settings', themeMode: 'system', locale: 'fr'));

    await container.read(updateThemeModeUseCaseProvider(themeMode: ThemeMode.dark).future);

    final saved = repo.get();
    expect(saved.themeMode, 'dark');
  });
}
