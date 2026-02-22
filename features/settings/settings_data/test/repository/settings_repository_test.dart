import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_data/src/entity/settings/settings_entity.dart';
import 'package:settings_data/src/repository/settings_repository.dart';
import 'package:tt_database/tt_database.dart';

void main() {
  setUpAll(() async {
    // Initialize test database in memory
    final db = await databaseFactoryMemory.openDatabase('test.db');
    TripleTDatabase.setTestDatabase(db);
  });

  group('_SettingsRepository', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('get', () {
      test('returns default SettingsEntity when nothing saved', () {
        // Arrange
        final repo = container.read(settingsRepositoryProvider);

        // Act
        final settings = repo.get();

        // Assert
        expect(settings, isA<SettingsEntity>());
        expect(settings.id, equals('settings'));
        expect(settings.themeMode, equals('system'));
        expect(settings.locale, equals('fr'));
      });

      test('returns SettingsEntity with expected structure', () {
        // Arrange
        final repo = container.read(settingsRepositoryProvider);

        // Act
        final settings = repo.get();

        // Assert
        expect(settings.id, isNotNull);
        expect(settings.themeMode, isNotNull);
        expect(settings.locale, isNotNull);
      });
    });

    group('saveSettings', () {
      test('saves SettingsEntity without error', () async {
        // Arrange
        final repo = container.read(settingsRepositoryProvider);
        final entity = SettingsEntity(
          id: 'settings',
          themeMode: 'dark',
          locale: 'en',
        );

        // Act & Assert - should not throw
        await expectLater(
          repo.saveSettings(entity),
          completes,
        );
      });

      test('persists and get returns stored entity', () async {
        // Arrange
        final repo = container.read(settingsRepositoryProvider);
        final toSave = SettingsEntity(
          id: 'settings',
          themeMode: 'dark',
          locale: 'en',
        );

        // Act
        await repo.saveSettings(toSave);
        final loaded = repo.get();

        // Assert
        expect(loaded.id, equals('settings'));
        expect(loaded.themeMode, equals('dark'));
        expect(loaded.locale, equals('en'));
      });

      test('saves entity with all fields', () async {
        // Arrange
        final repo = container.read(settingsRepositoryProvider);
        final entity = SettingsEntity(
          id: 'settings',
          themeMode: 'light',
          locale: 'es',
        );

        // Act & Assert - should not throw
        await expectLater(
          repo.saveSettings(entity),
          completes,
        );
      });
    });

    group('clearAll', () {
      test('clears all data from store without error', () async {
        // Arrange
        final repo = container.read(settingsRepositoryProvider);

        // Act & Assert - should not throw
        await expectLater(
          repo.clearAll(),
          completes,
        );
      });

      test('removes stored settings and get returns default', () async {
        // Arrange
        final repo = container.read(settingsRepositoryProvider);
        final toSave = SettingsEntity(
          id: 'settings',
          themeMode: 'dark',
          locale: 'en',
        );

        // Act - Save first
        await repo.saveSettings(toSave);
        var loaded = repo.get();
        expect(loaded.themeMode, equals('dark'));

        // Act - Then clear
        await repo.clearAll();
        loaded = repo.get();

        // Assert
        expect(loaded.id, equals('settings'));
        expect(loaded.themeMode, equals('system'));
        expect(loaded.locale, equals('fr'));
      });
    });
  });
}
