import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:triple_t/data/entity/statistics/statistics_entity.dart';

part 'statistics_model.freezed.dart';

@Freezed()
abstract class StatisticsModel with _$StatisticsModel {
  const StatisticsModel._();

  const factory StatisticsModel({
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0) int draws,
  }) = _Data;

  factory StatisticsModel.fromEntity({
    required StatisticsEntity entity,
  }) => StatisticsModel(
    wins: entity.wins,
    losses: entity.losses,
    draws: entity.draws,
  );

  StatisticsEntity toEntity() => StatisticsEntity(
    wins: wins,
    losses: losses,
    draws: draws,
  );
}
