import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_entity.freezed.dart';

@Freezed()
abstract class SettingsEntity with _$SettingsEntity {
  const factory SettingsEntity({
    @Default('') String id,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default('fr') String locale,
  }) = _SettingsEntity;
}
