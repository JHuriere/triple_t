import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:settings_domain/src/entity/settings/settings_entity.dart';
import 'package:settings_domain/src/repository/get_settings_repository.dart';
import 'package:settings_domain/src/use_case/get_locale_use_case.dart';
import 'package:settings_domain/src/use_case/get_settings_use_case.dart';

import '../repository/mock_settings_repository.mocks.dart';

void main() {
  group('GetLocaleUseCase', () {
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

    test('returns Locale from French locale code', () {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'fr'),
      );

      final result = container.read(getLocaleUseCaseProvider);

      expect(result, const Locale('fr'));
      expect(result.languageCode, 'fr');
    });

    test('returns Locale from English locale code', () {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'en'),
      );

      final result = container.read(getLocaleUseCaseProvider);

      expect(result, const Locale('en'));
      expect(result.languageCode, 'en');
    });

    test('returns Locale from Spanish locale code', () {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'es'),
      );

      final result = container.read(getLocaleUseCaseProvider);

      expect(result, const Locale('es'));
      expect(result.languageCode, 'es');
    });

    test('returns Locale from German locale code', () {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'de'),
      );

      final result = container.read(getLocaleUseCaseProvider);

      expect(result, const Locale('de'));
      expect(result.languageCode, 'de');
    });

    test('converts locale code string to Locale object', () {
      const localeCode = 'it';
      when(mockRepository.get()).thenReturn(
        SettingsEntity(locale: localeCode),
      );

      final result = container.read(getLocaleUseCaseProvider);

      expect(result.languageCode, localeCode);
      expect(result, isA<Locale>());
    });

    test('extracts locale from getSettingsUseCase', () {
      const localeCode = 'ja';
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(
          id: 'test-id',
          themeMode: ThemeMode.light,
          locale: localeCode,
        ),
      );

      // Verify that getLocaleUseCase correctly extracts locale
      final localeResult = container.read(getLocaleUseCaseProvider);
      // Also verify that getSettingsUseCase is used
      final fullSettings = container.read(getSettingsUseCaseProvider);

      expect(localeResult.languageCode, fullSettings.locale);
      expect(localeResult.languageCode, localeCode);
    });

    test('updates when underlying settings change', () {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'fr'),
      );

      var result = container.read(getLocaleUseCaseProvider);
      expect(result.languageCode, 'fr');

      // Simulate settings update
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'en'),
      );

      // Invalidate and read again
      container.invalidate(getSettingsUseCaseProvider);
      result = container.read(getLocaleUseCaseProvider);

      expect(result.languageCode, 'en');
    });

    test('returns Locale object with only language code set', () {
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'fr'),
      );

      final result = container.read(getLocaleUseCaseProvider);

      // Locale should have language code but no country code
      expect(result.languageCode, 'fr');
      expect(result.countryCode, isNull);
      expect(result.scriptCode, isNull);
    });
  });
}
