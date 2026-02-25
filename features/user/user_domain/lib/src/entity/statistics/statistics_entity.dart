import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics_entity.freezed.dart';

@Freezed()
abstract class StatisticsEntity with _$StatisticsEntity {
  const factory StatisticsEntity({
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0) int draws,
  }) = _StatisticsEntity;
}
