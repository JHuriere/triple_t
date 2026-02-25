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
  });
}
