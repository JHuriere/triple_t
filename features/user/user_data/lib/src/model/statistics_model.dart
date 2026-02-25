import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_domain/user_domain.dart';

part 'statistics_model.freezed.dart';
part 'statistics_model.g.dart';

@freezed
abstract class StatisticsModel with _$StatisticsModel {
  const factory StatisticsModel({
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0) int draws,
  }) = _StatisticsModel;

  factory StatisticsModel.fromJson(Map<String, dynamic> json) => _$StatisticsModelFromJson(json);

  const StatisticsModel._();

  StatisticsEntity toEntity() => StatisticsEntity(
        wins: wins,
        losses: losses,
        draws: draws,
      );

  factory StatisticsModel.fromEntity(StatisticsEntity entity) => StatisticsModel(
        wins: entity.wins,
        losses: entity.losses,
        draws: entity.draws,
      );
}
