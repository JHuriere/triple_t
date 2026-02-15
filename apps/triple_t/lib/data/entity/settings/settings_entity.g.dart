// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsEntity _$SettingsEntityFromJson(Map<String, dynamic> json) =>
    SettingsEntity(
      id: json['id'] as String? ?? '',
      themeMode: json['themeMode'] as String? ?? 'system',
      locale: json['locale'] as String? ?? 'fr',
    );

Map<String, dynamic> _$SettingsEntityToJson(SettingsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'themeMode': instance.themeMode,
      'locale': instance.locale,
    };
