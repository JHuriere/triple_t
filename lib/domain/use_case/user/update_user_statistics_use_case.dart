// create user use case
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/data/repository/current_game_repository.dart';
import 'package:triple_t/data/repository/user_repository.dart';
import 'package:triple_t/domain/model/statistics/statistics_model.dart';
import 'package:triple_t/domain/model/user/user_model.dart';

part 'update_user_statistics_use_case.g.dart';

@riverpod
Future<void> updateUserStatisticsUseCase(Ref ref, {required int id}) async {
  final currentGameEntity = ref.watch(currentGameRepositoryProvider).get();
  final repository = ref.watch(userRepositoryProvider);
  final userEntity = repository.get(id);

  if (userEntity == null) return;

  final user = UserModel.fromEntity(entity: userEntity);

  final opponentId = id == currentGameEntity.playerOneId ? currentGameEntity.playerTwoId : currentGameEntity.playerOneId;

  final isPlayerOne = id == currentGameEntity.playerOneId;
  final userWins = isPlayerOne ? currentGameEntity.playerOneWins : currentGameEntity.playerTwoWins;
  final userLosses = isPlayerOne ? currentGameEntity.playerTwoWins : currentGameEntity.playerOneWins;
  final draws = currentGameEntity.draws;

  final currentStatistics = user.statistics ?? {};
  final updatedStatistics = Map<int, StatisticsModel>.from(currentStatistics);

  final existingStats = updatedStatistics[opponentId];
  if (existingStats != null) {
    updatedStatistics[opponentId] = StatisticsModel(
      wins: existingStats.wins + userWins,
      losses: existingStats.losses + userLosses,
      draws: existingStats.draws + draws,
    );
  } else {
    updatedStatistics[opponentId] = StatisticsModel(
      wins: userWins,
      losses: userLosses,
      draws: draws,
    );
  }

  await repository.upsert(user.copyWith(statistics: updatedStatistics).toEntity());
}
