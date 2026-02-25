import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settings_data/src/model/settings_model.dart';
import 'package:settings_domain/settings_domain.dart';

void main() {
  group('SettingsModel', () {
    test('should serialize to JSON', () {
      const model = SettingsModel(
        id: 'test-id',
        themeMode: ThemeMode.dark,
        locale: 'en',
      );

      final json = model.toJson();

      expect(json['id'], 'test-id');
      expect(json['themeMode'], 'dark');
      expect(json['locale'], 'en');
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'test-id',
        'themeMode': 'light',
        'locale': 'es',
      };

      final model = SettingsModel.fromJson(json);

      expect(model.id, 'test-id');
      expect(model.themeMode, ThemeMode.light);
      expect(model.locale, 'es');
    });

    test('should convert to Entity', () {
      const model = SettingsModel(
        id: 'test-id',
        themeMode: ThemeMode.dark,
        locale: 'en',
      );

      final entity = model.toEntity();

      expect(entity.id, model.id);
      expect(entity.themeMode, model.themeMode);
      expect(entity.locale, model.locale);
    });

    test('should create from Entity', () {
      const entity = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.dark,
        locale: 'en',
      );

      final model = SettingsModel.fromEntity(entity);

      expect(model.id, entity.id);
      expect(model.themeMode, entity.themeMode);
      expect(model.locale, entity.locale);
    });
  });
}
