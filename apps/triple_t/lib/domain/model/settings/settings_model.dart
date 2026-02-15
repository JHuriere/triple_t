import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:triple_t/data/entity/settings/settings_entity.dart';

part 'settings_model.freezed.dart';

@Freezed()
abstract class SettingsModel with _$SettingsModel {
  const SettingsModel._();

  const factory SettingsModel({
    @Default('') String id,
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _Data;

  factory SettingsModel.fromEntity({
    required SettingsEntity entity,
  }) => SettingsModel(
    id: entity.id,
    themeMode: ThemeMode.values.firstWhere((element) => element.name == entity.themeMode, orElse: () => ThemeMode.system),
  );

  SettingsEntity toEntity() => SettingsEntity(
    id: id,
    themeMode: themeMode.name,
  );
}
