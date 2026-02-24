import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_entity.freezed.dart';
part 'settings_entity.g.dart';

@Freezed()
abstract class SettingsEntity with _$SettingsEntity {
  @JsonSerializable(explicitToJson: true)
  const factory SettingsEntity({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'themeMode') @Default(ThemeMode.system) ThemeMode themeMode,
    @JsonKey(name: 'locale') @Default('fr') String locale,
  }) = _SettingsEntity;

  factory SettingsEntity.fromJson(Map<String, dynamic> json) => _$SettingsEntityFromJson(json);
}
