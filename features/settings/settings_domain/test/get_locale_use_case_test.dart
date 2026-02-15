import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_data/settings_data.dart';
import 'package:settings_domain/settings_domain.dart';

void main() {
  test('getLocaleUseCase returns locale Locale from settings', () {
    final fakeEntity = SettingsEntity(id: 'settings', themeMode: 'system', locale: 'en');
    final fakeModel = SettingsModel.fromEntity(entity: fakeEntity);

    final container = ProviderContainer(
      overrides: [
        getSettingsUseCaseProvider.overrideWithValue(fakeModel),
      ],
    );
    addTearDown(container.dispose);

    final locale = container.read(getLocaleUseCaseProvider);

    expect(locale, isA<Locale>());
    expect(locale.languageCode, 'en');
  });
}
