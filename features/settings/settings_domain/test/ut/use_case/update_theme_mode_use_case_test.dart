import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_domain/src/entity/settings/settings_entity.dart';
import 'package:settings_domain/src/repository/get_settings_repository.dart';
import 'package:settings_domain/src/use_case/update_theme_mode_use_case.dart';

import '../repository/mock_settings_repository.mocks.dart';

void main() {
  group('UpdateThemeModeUseCase', () {
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

    test('updates theme mode to light', () async {
      const currentSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.dark,
        locale: 'en',
      );
      const newThemeMode = ThemeMode.light;

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(any)).thenAnswer((_) async => Future.value());

      await container.read(
        updateThemeModeUseCaseProvider(themeMode: newThemeMode).future,
      );

      final expectedSettings = currentSettings.copyWith(themeMode: newThemeMode);

      verify(mockRepository.get()).called(1);
      verify(mockRepository.saveSettings(expectedSettings)).called(1);
    });

    test('updates theme mode to dark', () async {
      const currentSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.light,
        locale: 'fr',
      );
      const newThemeMode = ThemeMode.dark;

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(any)).thenAnswer((_) async => Future.value());

      await container.read(
        updateThemeModeUseCaseProvider(themeMode: newThemeMode).future,
      );

      final expectedSettings = currentSettings.copyWith(themeMode: newThemeMode);

      verify(mockRepository.saveSettings(expectedSettings)).called(1);
    });

    test('updates theme mode to system', () async {
      const currentSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.dark,
        locale: 'en',
      );
      const newThemeMode = ThemeMode.system;

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(any)).thenAnswer((_) async => Future.value());

      await container.read(
        updateThemeModeUseCaseProvider(themeMode: newThemeMode).future,
      );

      final expectedSettings = currentSettings.copyWith(themeMode: newThemeMode);

      verify(mockRepository.saveSettings(expectedSettings)).called(1);
    });

    test('preserves other settings when updating theme mode', () async {
      const originalId = 'original-id';
      const originalLocale = 'es';
      const currentSettings = SettingsEntity(
        id: originalId,
        themeMode: ThemeMode.light,
        locale: originalLocale,
      );
      const newThemeMode = ThemeMode.dark;

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(any)).thenAnswer((_) async => Future.value());

      await container.read(
        updateThemeModeUseCaseProvider(themeMode: newThemeMode).future,
      );

      final captured = <SettingsEntity>[];
      for (var v in verify(mockRepository.saveSettings(captureAny)).captured) {
        captured.add(v as SettingsEntity);
      }
      final savedSettings = captured.single;

      expect(savedSettings.id, originalId);
      expect(savedSettings.locale, originalLocale);
      expect(savedSettings.themeMode, newThemeMode);
    });

    test('calls get() before saveSettings()', () async {
      const currentSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.light,
        locale: 'en',
      );

      when(mockRepository.get()).thenReturn(currentSettings);
      when(mockRepository.saveSettings(any)).thenAnswer((_) async => Future.value());

      await container.read(
        updateThemeModeUseCaseProvider(themeMode: ThemeMode.dark).future,
      );

      // Verify both methods were called
      verify(mockRepository.get()).called(1);
      verify(mockRepository.saveSettings(any)).called(1);
    });

    test('returns Future that completes successfully', () async {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(themeMode: ThemeMode.light),
      );
      when(mockRepository.saveSettings(any)).thenAnswer((_) async => Future.value());

      final future = container.read(
        updateThemeModeUseCaseProvider(themeMode: ThemeMode.dark).future,
      );

      expect(future, completes);

      await future;
    });

    test('handles repository saveSettings exception', () async {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(themeMode: ThemeMode.light),
      );
      when(mockRepository.saveSettings(any)).thenThrow(Exception('Save failed'));

      final future = container.read(
        updateThemeModeUseCaseProvider(themeMode: ThemeMode.dark).future,
      );

      expect(future, throwsException);
    });

    test('allows switching between different theme modes sequentially', () async {
      const initialSettings = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.light,
        locale: 'en',
      );

      when(mockRepository.get()).thenReturn(initialSettings);
      when(mockRepository.saveSettings(any)).thenAnswer((_) async => Future.value());

      // Switch to dark
      await container.read(
        updateThemeModeUseCaseProvider(themeMode: ThemeMode.dark).future,
      );

      final capturedList1 = <SettingsEntity>[];
      for (var v in verify(mockRepository.saveSettings(captureAny)).captured) {
        capturedList1.add(v as SettingsEntity);
      }
      var savedSettings = capturedList1.last;
      expect(savedSettings.themeMode, ThemeMode.dark);

      // Switch to system
      when(mockRepository.get()).thenReturn(savedSettings);
      await container.read(
        updateThemeModeUseCaseProvider(themeMode: ThemeMode.system).future,
      );

      final capturedList2 = <SettingsEntity>[];
      for (var v in verify(mockRepository.saveSettings(captureAny)).captured) {
        capturedList2.add(v as SettingsEntity);
      }
      savedSettings = capturedList2.last;
      expect(savedSettings.themeMode, ThemeMode.system);
    });
  });
}
