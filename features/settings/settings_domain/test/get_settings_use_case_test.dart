import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_data/settings_data.dart';
import 'package:settings_domain/src/model/settings/settings_model.dart';
import 'package:settings_domain/src/use_case/get_settings_use_case.dart';

void main() {
  test('getSettingsUseCase returns mapped SettingsModel from repository entity', () {
    final fakeEntity = SettingsEntity(id: 'settings', themeMode: 'dark', locale: 'en');
    final fakeModel = SettingsModel.fromEntity(entity: fakeEntity);

    final container = ProviderContainer(
      overrides: [
        getSettingsUseCaseProvider.overrideWithValue(fakeModel),
      ],
    );

    addTearDown(container.dispose);

    final model = container.read(getSettingsUseCaseProvider);

    expect(model, isA<SettingsModel>());
    expect(model.locale, 'en');
    expect(model.themeMode, ThemeMode.dark);
  });
}
