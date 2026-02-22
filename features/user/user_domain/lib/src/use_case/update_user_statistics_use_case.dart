import 'package:game_data/game_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tt_database/tt_database.dart';
import 'package:user_data/user_data.dart';

part 'update_user_statistics_use_case.g.dart';

@riverpod
Future<void> updateUserStatisticsUseCase(Ref ref, {required int id}) async {
  final repository = ref.watch(userRepositoryProvider);
  final currentGame = ref.watch(currentGameRepositoryProvider).get();
  final userEntity = repository.get(id);

  if (userEntity == null) return;

  final user = userEntity.data;
  final opponentId = id == currentGame.playerOneId ? currentGame.playerTwoId : currentGame.playerOneId;

  final isPlayerOne = id == currentGame.playerOneId;
  final isPlayerTwo = id == currentGame.playerTwoId;
  final win = (isPlayerOne && currentGame.state == CurrentGameState.playerOneWon) || (isPlayerTwo && currentGame.state == CurrentGameState.playerTwoWon) ? 1 : 0;
  final loss = (isPlayerOne && currentGame.state == CurrentGameState.playerTwoWon) || (isPlayerTwo && currentGame.state == CurrentGameState.playerOneWon) ? 1 : 0;
  final draws = currentGame.state == CurrentGameState.draw ? 1 : 0;

  final updatedStatistics = Map<int, StatisticsEntity>.from(user.statistics ?? {});

  final existingStats = updatedStatistics[opponentId];
  if (existingStats != null) {
    updatedStatistics[opponentId] = StatisticsEntity(
      wins: existingStats.wins + win,
      losses: existingStats.losses + loss,
      draws: existingStats.draws + draws,
    );
  } else {
    updatedStatistics[opponentId] = StatisticsEntity(
      wins: win,
      losses: loss,
      draws: draws,
    );
  }

  await repository.upsert(
    Entity(
      id: userEntity.id,
      data: user.copyWith(statistics: updatedStatistics),
    ),
  );
}
