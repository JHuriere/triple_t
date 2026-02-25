import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_domain/src/entity/user_entity.dart';

part 'global_user_statistics_entity.freezed.dart';

@freezed
abstract class GlobalUserStatisticsEntity with _$GlobalUserStatisticsEntity {
  const factory GlobalUserStatisticsEntity({
    required UserEntity user,
    @Default(0) int totalWins,
    @Default(0) int totalLosses,
    @Default(0) int totalDraws,
    @Default(0) int totalGames,
    @Default(0.0) double winRate,
  }) = _GlobalUserStatisticsEntity;
}
