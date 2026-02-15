// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsEntity _$StatisticsEntityFromJson(Map<String, dynamic> json) =>
    StatisticsEntity(
      wins: (json['wins'] as num?)?.toInt() ?? 0,
      losses: (json['losses'] as num?)?.toInt() ?? 0,
      draws: (json['draws'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$StatisticsEntityToJson(StatisticsEntity instance) =>
    <String, dynamic>{
      'wins': instance.wins,
      'losses': instance.losses,
      'draws': instance.draws,
    };
