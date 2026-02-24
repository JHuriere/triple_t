import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settings_domain/src/entity/settings/settings_entity.dart';

void main() {
  group('SettingsEntity', () {
    group('constructor', () {
      test('creates instance with default values', () {
        final entity = const SettingsEntity();

        expect(entity.id, '');
        expect(entity.themeMode, ThemeMode.system);
        expect(entity.locale, 'fr');
      });

      test('creates instance with custom values', () {
        const customId = 'test-id';
        const customTheme = ThemeMode.dark;
        const customLocale = 'en';

        final entity = const SettingsEntity(
          id: customId,
          themeMode: customTheme,
          locale: customLocale,
        );

        expect(entity.id, customId);
        expect(entity.themeMode, customTheme);
        expect(entity.locale, customLocale);
      });
    });

    group('copyWith', () {
      test('copies entity with updated id', () {
        const originalEntity = SettingsEntity(
          id: 'original-id',
          themeMode: ThemeMode.light,
          locale: 'fr',
        );

        final updatedEntity = originalEntity.copyWith(id: 'new-id');

        expect(updatedEntity.id, 'new-id');
        expect(updatedEntity.themeMode, ThemeMode.light);
        expect(updatedEntity.locale, 'fr');
        expect(originalEntity.id, 'original-id'); // Original unchanged
      });

      test('copies entity with updated themeMode', () {
        const originalEntity = SettingsEntity(
          id: 'test-id',
          themeMode: ThemeMode.light,
          locale: 'fr',
        );

        final updatedEntity = originalEntity.copyWith(themeMode: ThemeMode.dark);

        expect(updatedEntity.id, 'test-id');
        expect(updatedEntity.themeMode, ThemeMode.dark);
        expect(updatedEntity.locale, 'fr');
      });

      test('copies entity with updated locale', () {
        const originalEntity = SettingsEntity(
          id: 'test-id',
          themeMode: ThemeMode.system,
          locale: 'fr',
        );

        final updatedEntity = originalEntity.copyWith(locale: 'en');

        expect(updatedEntity.id, 'test-id');
        expect(updatedEntity.themeMode, ThemeMode.system);
        expect(updatedEntity.locale, 'en');
      });

      test('copies entity with multiple fields updated', () {
        const originalEntity = SettingsEntity(
          id: 'original-id',
          themeMode: ThemeMode.light,
          locale: 'fr',
        );

        final updatedEntity = originalEntity.copyWith(
          id: 'new-id',
          themeMode: ThemeMode.dark,
          locale: 'en',
        );

        expect(updatedEntity.id, 'new-id');
        expect(updatedEntity.themeMode, ThemeMode.dark);
        expect(updatedEntity.locale, 'en');
      });
    });

    group('JSON serialization', () {
      test('converts to JSON', () {
        const entity = SettingsEntity(
          id: 'test-id',
          themeMode: ThemeMode.dark,
          locale: 'en',
        );

        final json = entity.toJson();

        expect(json['id'], 'test-id');
        expect(json['themeMode'], 'dark');
        expect(json['locale'], 'en');
      });

      test('creates entity from JSON', () {
        final json = {
          'id': 'test-id',
          'themeMode': 'light',
          'locale': 'es',
        };

        final entity = SettingsEntity.fromJson(json);

        expect(entity.id, 'test-id');
        expect(entity.themeMode, ThemeMode.light);
        expect(entity.locale, 'es');
      });

      test('round-trips JSON serialization', () {
        const originalEntity = SettingsEntity(
          id: 'round-trip-id',
          themeMode: ThemeMode.system,
          locale: 'de',
        );

        final json = originalEntity.toJson();
        final deserializedEntity = SettingsEntity.fromJson(json);

        expect(deserializedEntity.id, originalEntity.id);
        expect(deserializedEntity.themeMode, originalEntity.themeMode);
        expect(deserializedEntity.locale, originalEntity.locale);
      });

      test('handles partial JSON with default values', () {
        final json = {'id': 'partial-id'};

        final entity = SettingsEntity.fromJson(json);

        expect(entity.id, 'partial-id');
        expect(entity.themeMode, ThemeMode.system);
        expect(entity.locale, 'fr');
      });
    });

    group('equality', () {
      test('entities with same values are equal', () {
        const entity1 = SettingsEntity(
          id: 'test',
          themeMode: ThemeMode.dark,
          locale: 'en',
        );
        const entity2 = SettingsEntity(
          id: 'test',
          themeMode: ThemeMode.dark,
          locale: 'en',
        );

        expect(entity1, entity2);
      });

      test('entities with different values are not equal', () {
        const entity1 = SettingsEntity(
          id: 'test1',
          themeMode: ThemeMode.dark,
          locale: 'en',
        );
        const entity2 = SettingsEntity(
          id: 'test2',
          themeMode: ThemeMode.dark,
          locale: 'en',
        );

        expect(entity1, isNot(entity2));
      });
    });
  });
}
