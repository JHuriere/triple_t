import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:settings_domain/settings_domain.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
abstract class SettingsModel with _$SettingsModel {
  const SettingsModel._();

  @JsonSerializable(explicitToJson: true)
  const factory SettingsModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'themeMode') @Default(ThemeMode.system) ThemeMode themeMode,
    @JsonKey(name: 'locale') @Default('fr') String locale,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);

  SettingsEntity toEntity() => SettingsEntity(
    id: id,
    themeMode: themeMode,
    locale: locale,
  );

  factory SettingsModel.fromEntity(SettingsEntity entity) => SettingsModel(
    id: entity.id,
    themeMode: entity.themeMode,
    locale: entity.locale,
  );
}
