import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics_entity.freezed.dart';
part 'statistics_entity.g.dart';

@Freezed()
abstract class Statistics with _$Statistics {
  @JsonSerializable(explicitToJson: true)
  const factory Statistics.entity({
    @JsonKey(name: 'wins') @Default(0) int wins,
    @JsonKey(name: 'losses') @Default(0) int losses,
    @JsonKey(name: 'draws') @Default(0) int draws,
  }) = StatisticsEntity;

  factory Statistics.fromJson(Map<String, dynamic> json) => _$StatisticsFromJson(json);
}
