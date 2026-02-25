import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:settings_domain/src/entity/settings/settings_entity.dart';
import 'package:settings_domain/src/repository/get_settings_repository.dart';
import 'package:settings_domain/src/use_case/update_locale_use_case.dart';

import '../repository/mock_settings_repository.mocks.dart';

void main() {
  group('UpdateLocaleUseCase', () {
    late ProviderContainer container;
    late MockSettingsRepository mockRepository;

    setUp(() {
      mockRepository = MockSettingsRepository();
      container = ProviderContainer(
        overrides: [
          getSettingsRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('updates locale to English', () async {
      const currentSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.dark,
        locale: 'fr',
      );
      const newLocale = 'en';
      final expectedSettings = currentSettings.copyWith(locale: newLocale);

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(expectedSettings)).thenAnswer((_) async => Future<void>.value());

      await container.read(
        updateLocaleUseCaseProvider(locale: newLocale).future,
      );

      verify(mockRepository.get()).called(1);
      verify(mockRepository.saveSettings(expectedSettings)).called(1);
    });

    test('updates locale to French', () async {
      const currentSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.light,
        locale: 'en',
      );
      const newLocale = 'fr';
      final expectedSettings = currentSettings.copyWith(locale: newLocale);

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(expectedSettings)).thenAnswer((_) async => Future<void>.value());

      await container.read(
        updateLocaleUseCaseProvider(locale: newLocale).future,
      );

      verify(mockRepository.saveSettings(expectedSettings)).called(1);
    });

    test('updates locale to Spanish', () async {
      const currentSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.system,
        locale: 'en',
      );
      const newLocale = 'es';
      final expectedSettings = currentSettings.copyWith(locale: newLocale);

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(expectedSettings)).thenAnswer((_) async => Future<void>.value());

      await container.read(
        updateLocaleUseCaseProvider(locale: newLocale).future,
      );

      verify(mockRepository.saveSettings(expectedSettings)).called(1);
    });

    test('updates locale to German', () async {
      const currentSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.dark,
        locale: 'fr',
      );
      const newLocale = 'de';
      final expectedSettings = currentSettings.copyWith(locale: newLocale);

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(expectedSettings)).thenAnswer((_) async => Future<void>.value());

      await container.read(
        updateLocaleUseCaseProvider(locale: newLocale).future,
      );

      verify(mockRepository.saveSettings(expectedSettings)).called(1);
    });

    test('preserves other settings when updating locale', () async {
      const originalId = 'original-id';
      const originalTheme = ThemeMode.light;
      const currentSettings = SettingsEntity(
        id: originalId,
        themeMode: originalTheme,
        locale: 'fr',
      );
      const newLocale = 'en';
      final expectedSettings = currentSettings.copyWith(locale: newLocale);

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(expectedSettings)).thenAnswer((_) async => Future<void>.value());

      await container.read(
        updateLocaleUseCaseProvider(locale: newLocale).future,
      );

      verify(mockRepository.saveSettings(expectedSettings)).called(1);

      // Verify that the saved settings has the expected properties
      expect(expectedSettings.id, originalId);
      expect(expectedSettings.themeMode, originalTheme);
      expect(expectedSettings.locale, newLocale);
    });

    test('calls get() before saveSettings()', () async {
      const currentSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.light,
        locale: 'fr',
      );
      final expectedSettings = currentSettings.copyWith(locale: 'en');

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(expectedSettings)).thenAnswer((_) async => Future<void>.value());

      await container.read(
        updateLocaleUseCaseProvider(locale: 'en').future,
      );

      // Verify both methods were called
      verify(mockRepository.get()).called(1);
      verify(mockRepository.saveSettings(expectedSettings)).called(1);
    });

    test('returns Future that completes successfully', () async {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'fr'),
      );
      when(mockRepository.saveSettings(const SettingsEntity(locale: 'en'))).thenAnswer((_) async => Future<void>.value());

      final future = container.read(
        updateLocaleUseCaseProvider(locale: 'en').future,
      );

      expect(future, completes);

      await future;
    });

    test('allows switching between different locales sequentially', () async {
      const initialSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.light,
        locale: 'fr',
      );
      final expectedSettings1 = initialSettings.copyWith(locale: 'en');
      final expectedSettings2 = expectedSettings1.copyWith(locale: 'es');

      when(mockRepository.get()).thenReturn(initialSettings);
      when(mockRepository.saveSettings(expectedSettings1)).thenAnswer((_) async => Future<void>.value());

      // Switch to English
      await container.read(
        updateLocaleUseCaseProvider(locale: 'en').future,
      );

      verify(mockRepository.saveSettings(expectedSettings1)).called(1);

      // Switch to Spanish
      when(mockRepository.get()).thenReturn(expectedSettings1);
      when(mockRepository.saveSettings(expectedSettings2)).thenAnswer((_) async => Future<void>.value());

      await container.read(
        updateLocaleUseCaseProvider(locale: 'es').future,
      );

      verify(mockRepository.saveSettings(expectedSettings2)).called(1);
    });
  });
}
