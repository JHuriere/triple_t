import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settings_data/src/repository/settings_repository_impl.dart';
import 'package:settings_domain/settings_domain.dart';
import 'package:tt_database/tt_database.dart';

void main() {
  setUpAll(() async {
    final db = await databaseFactoryMemory.openDatabase('test.db');
    TripleTDatabase.setTestDatabase(db);
  });

  group('SettingsRepositoryImpl', () {
    late SettingsRepositoryImpl settingsRepository;
    late Database testDatabase;

    setUp(() async {
      testDatabase = TripleTDatabase.instance.db;
      settingsRepository = SettingsRepositoryImpl();
    });

    tearDown(() async {
      await settingsRepository.clearAll();
    });

    group('get', () {
      test('should return default settings when none exist', () {
        // Act
        final result = settingsRepository.get();

        // Assert
        expect(result, isA<SettingsEntity>());
        expect(result.id, equals(SettingsRepository.settingsKey));
        expect(result.themeMode, equals(ThemeMode.system));
        expect(result.locale, equals('fr'));
      });

      test('should return SettingsEntity when settings exist', () async {
        // Arrange
        final settings = SettingsEntity(
          id: SettingsRepository.settingsKey,
          themeMode: ThemeMode.dark,
          locale: 'en',
        );

        final store = stringMapStoreFactory.store(SettingsRepository.storeName);
        await store.record(SettingsRepository.settingsKey).put(testDatabase, settings.toJson());

        // Act
        final result = settingsRepository.get();

        // Assert
        expect(result, equals(settings));
        expect(result.themeMode, equals(ThemeMode.dark));
        expect(result.locale, equals('en'));
      });

      test('should return settings with light theme mode', () async {
        // Arrange
        final settings = SettingsEntity(
          id: SettingsRepository.settingsKey,
          themeMode: ThemeMode.light,
          locale: 'fr',
        );

        final store = stringMapStoreFactory.store(SettingsRepository.storeName);
        await store.record(SettingsRepository.settingsKey).put(testDatabase, settings.toJson());

        // Act
        final result = settingsRepository.get();

        // Assert
        expect(result, equals(settings));
        expect(result.themeMode, equals(ThemeMode.light));
      });
    });

    group('saveSettings', () {
      test('should persist and return updated settings', () async {
        // Arrange
        final settings = SettingsEntity(
          id: SettingsRepository.settingsKey,
          themeMode: ThemeMode.dark,
          locale: 'es',
        );

        // Act
        await settingsRepository.saveSettings(settings);

        // Assert
        final store = stringMapStoreFactory.store(SettingsRepository.storeName);
        final stored = await store.record(SettingsRepository.settingsKey).get(testDatabase);
        expect(stored, isNotNull);
        expect(SettingsEntity.fromJson(stored!.cast<String, dynamic>()), equals(settings));
      });

      test('should update existing settings', () async {
        // Arrange
        final initialSettings = SettingsEntity(
          id: SettingsRepository.settingsKey,
          themeMode: ThemeMode.light,
          locale: 'fr',
        );

        final updatedSettings = SettingsEntity(
          id: SettingsRepository.settingsKey,
          themeMode: ThemeMode.dark,
          locale: 'en',
        );

        final store = stringMapStoreFactory.store(SettingsRepository.storeName);
        await store.record(SettingsRepository.settingsKey).put(testDatabase, initialSettings.toJson());

        // Act
        await settingsRepository.saveSettings(updatedSettings);

        // Assert
        final result = settingsRepository.get();
        expect(result, equals(updatedSettings));
        expect(result.themeMode, equals(ThemeMode.dark));
        expect(result.locale, equals('en'));
      });

      test('should save settings with system theme mode', () async {
        // Arrange
        final settings = SettingsEntity(
          id: SettingsRepository.settingsKey,
          themeMode: ThemeMode.system,
          locale: 'de',
        );

        // Act
        await settingsRepository.saveSettings(settings);

        // Assert
        final result = settingsRepository.get();
        expect(result.themeMode, equals(ThemeMode.system));
        expect(result.locale, equals('de'));
      });
    });

    group('clearAll', () {
      test('should clear all settings', () async {
        // Arrange
        final settings = SettingsEntity(
          id: SettingsRepository.settingsKey,
          themeMode: ThemeMode.dark,
          locale: 'en',
        );

        final store = stringMapStoreFactory.store(SettingsRepository.storeName);
        await store.record(SettingsRepository.settingsKey).put(testDatabase, settings.toJson());

        // Verify data exists
        expect(settingsRepository.get().locale, equals('en'));

        // Act
        await settingsRepository.clearAll();

        // Assert
        final result = settingsRepository.get();
        expect(result.id, equals(SettingsRepository.settingsKey));
        expect(result.themeMode, equals(ThemeMode.system));
        expect(result.locale, equals('fr'));
      });

      test('should clear multiple settings entries if they exist', () async {
        // Arrange
        final settings = SettingsEntity(
          id: SettingsRepository.settingsKey,
          themeMode: ThemeMode.light,
          locale: 'it',
        );

        final store = stringMapStoreFactory.store(SettingsRepository.storeName);
        await store.record(SettingsRepository.settingsKey).put(testDatabase, settings.toJson());

        // Act
        await settingsRepository.clearAll();

        // Assert
        final stored = await store.record(SettingsRepository.settingsKey).get(testDatabase);
        expect(stored, isNull);
      });
    });
  });
}
