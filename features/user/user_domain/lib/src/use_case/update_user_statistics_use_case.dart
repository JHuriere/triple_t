import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/src/entity/game_result.dart';
import 'package:user_domain/src/entity/statistics/statistics_entity.dart';
import 'package:user_domain/src/repository/get_user_repository.dart';

part 'update_user_statistics_use_case.g.dart';

@riverpod
Future<void> updateUserStatisticsUseCase(Ref ref, {required int currentPlayerId, required int opponentPlayerId, required GameResult result}) async {
  final userRepository = ref.watch(getUserRepositoryProvider);

  final userEntity = userRepository.get(currentPlayerId);

  if (userEntity == null) return;

  final win = result == GameResult.win ? 1 : 0;
  final loss = result == GameResult.lose ? 1 : 0;
  final draws = result == GameResult.draw ? 1 : 0;

  final updatedStatistics = Map<int, StatisticsEntity>.from(userEntity.statistics ?? {});

  final existingStats = updatedStatistics[opponentPlayerId];
  if (existingStats != null) {
    updatedStatistics[opponentPlayerId] = StatisticsEntity(
      wins: existingStats.wins + win,
      losses: existingStats.losses + loss,
      draws: existingStats.draws + draws,
    );
  } else {
    updatedStatistics[opponentPlayerId] = StatisticsEntity(
      wins: win,
      losses: loss,
      draws: draws,
    );
  }

  await userRepository.upsert(userEntity.copyWith(statistics: updatedStatistics));
}
