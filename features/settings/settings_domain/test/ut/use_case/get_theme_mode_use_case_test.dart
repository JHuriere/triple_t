import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:settings_domain/settings_domain.dart';

import '../repository/mock_settings_repository.mocks.dart';

void main() {
  group('GetThemeModeUseCase', () {
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

    test('returns ThemeMode.light from settings', () {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(themeMode: ThemeMode.light),
      );

      final result = container.read(getThemeModeUseCaseProvider);

      expect(result, ThemeMode.light);
    });

    test('returns ThemeMode.dark from settings', () {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(themeMode: ThemeMode.dark),
      );

      final result = container.read(getThemeModeUseCaseProvider);

      expect(result, ThemeMode.dark);
    });

    test('returns ThemeMode.system from settings', () {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(themeMode: ThemeMode.system),
      );

      final result = container.read(getThemeModeUseCaseProvider);

      expect(result, ThemeMode.system);
    });

    test('extracts themeMode from getSettingsUseCase', () {
      const themeMode = ThemeMode.dark;
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(
          id: 'test-id',
          themeMode: themeMode,
          locale: 'en',
        ),
      );

      // Verify that getThemeModeUseCase correctly extracts themeMode
      final themeModeResult = container.read(getThemeModeUseCaseProvider);
      // Also verify that getSettingsUseCase is used
      final fullSettings = container.read(getSettingsUseCaseProvider);

      expect(themeModeResult, fullSettings.themeMode);
      expect(themeModeResult, themeMode);
    });

    test('updates when underlying settings change', () {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(themeMode: ThemeMode.light),
      );

      var result = container.read(getThemeModeUseCaseProvider);
      expect(result, ThemeMode.light);

      // Simulate settings update
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(themeMode: ThemeMode.dark),
      );

      // Invalidate and read again
      container.invalidate(getSettingsUseCaseProvider);
      result = container.read(getThemeModeUseCaseProvider);

      expect(result, ThemeMode.dark);
    });

    test('only returns themeMode without other settings properties', () {
      const expectedThemeMode = ThemeMode.dark;
      const expectedId = 'test-id';
      const expectedLocale = 'en';

      when(mockRepository.get()).thenReturn(
        const SettingsEntity(
          id: expectedId,
          themeMode: expectedThemeMode,
          locale: expectedLocale,
        ),
      );

      final result = container.read(getThemeModeUseCaseProvider);

      // Result should be just the ThemeMode, not the full entity
      expect(result, expectedThemeMode);
    });
  });
}
