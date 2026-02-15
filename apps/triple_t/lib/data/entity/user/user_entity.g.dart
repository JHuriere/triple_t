// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
  name: json['name'] as String? ?? '',
  emoticon: json['emoticon'] as String? ?? '',
  statistics:
      (json['statistics'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          int.parse(k),
          StatisticsEntity.fromJson(e as Map<String, dynamic>),
        ),
      ) ??
      const {},
);

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'emoticon': instance.emoticon,
      'statistics': instance.statistics?.map(
        (k, e) => MapEntry(k.toString(), e.toJson()),
      ),
    };
