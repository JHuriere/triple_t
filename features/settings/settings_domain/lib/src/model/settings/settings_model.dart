import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:settings_data/settings_data.dart';

part 'settings_model.freezed.dart';

@Freezed()
abstract class SettingsModel with _$SettingsModel {
  const SettingsModel._();

  const factory SettingsModel({
    @Default('') String id,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default('fr') String locale,
  }) = _Data;

  factory SettingsModel.fromEntity({required SettingsEntity entity}) => SettingsModel(
    id: entity.id,
    themeMode: ThemeMode.values.firstWhere((element) => element.name == entity.themeMode, orElse: () => ThemeMode.system),
    locale: entity.locale,
  );

  SettingsEntity toEntity() => SettingsEntity(id: id, themeMode: themeMode.name, locale: locale);
}
