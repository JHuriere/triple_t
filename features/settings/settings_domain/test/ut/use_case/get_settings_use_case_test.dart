import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:settings_domain/src/entity/settings/settings_entity.dart';
import 'package:settings_domain/src/repository/get_settings_repository.dart';
import 'package:settings_domain/src/use_case/get_settings_use_case.dart';

import '../repository/mock_settings_repository.mocks.dart';

void main() {
  group('GetSettingsUseCase', () {
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

    test('returns settings entity from repository', () {
      const expectedEntity = SettingsEntity(
        id: 'test-id',
        themeMode: ThemeMode.dark,
        locale: 'en',
      );

      when(mockRepository.get()).thenReturn(expectedEntity);

      final result = container.read(getSettingsUseCaseProvider);

      expect(result, expectedEntity);
      verify(mockRepository.get()).called(1);
    });

    test('returns settings entity with default values', () {
      const expectedEntity = SettingsEntity();

      when(mockRepository.get()).thenReturn(expectedEntity);

      final result = container.read(getSettingsUseCaseProvider);

      expect(result.id, '');
      expect(result.themeMode, ThemeMode.system);
      expect(result.locale, 'fr');
    });

    test('calls repository.get() exactly once', () {
      const testEntity = SettingsEntity(
        id: 'test',
        themeMode: ThemeMode.light,
        locale: 'fr',
      );

      when(mockRepository.get()).thenReturn(testEntity);

      container.read(getSettingsUseCaseProvider);

      verify(mockRepository.get()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('handles repository returning different theme modes', () {
      // Test with ThemeMode.light
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(themeMode: ThemeMode.light),
      );
      var result = container.read(getSettingsUseCaseProvider);
      expect(result.themeMode, ThemeMode.light);

      // Test with ThemeMode.dark
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(themeMode: ThemeMode.dark),
      );
      result = container.read(getSettingsUseCaseProvider);
      expect(result.themeMode, ThemeMode.dark);

      // Test with ThemeMode.system
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(themeMode: ThemeMode.system),
      );
      result = container.read(getSettingsUseCaseProvider);
      expect(result.themeMode, ThemeMode.system);
    });

    test('handles repository returning different locales', () {
      // Test with French locale
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'fr'),
      );
      var result = container.read(getSettingsUseCaseProvider);
      expect(result.locale, 'fr');

      // Test with English locale
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'en'),
      );
      result = container.read(getSettingsUseCaseProvider);
      expect(result.locale, 'en');

      // Test with Spanish locale
      when(mockRepository.get()).thenReturn(
        const SettingsEntity(locale: 'es'),
      );
      result = container.read(getSettingsUseCaseProvider);
      expect(result.locale, 'es');
    });
  });
}
