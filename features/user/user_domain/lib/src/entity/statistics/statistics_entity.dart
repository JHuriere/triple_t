import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics_entity.freezed.dart';
part 'statistics_entity.g.dart';

@Freezed()
abstract class StatisticsEntity with _$StatisticsEntity {
  @JsonSerializable(explicitToJson: true)
  const factory StatisticsEntity({
    @JsonKey(name: 'wins') @Default(0) int wins,
    @JsonKey(name: 'losses') @Default(0) int losses,
    @JsonKey(name: 'draws') @Default(0) int draws,
  }) = _StatisticsEntity;

  factory StatisticsEntity.fromJson(Map<String, dynamic> json) => _$StatisticsEntityFromJson(json);
}
