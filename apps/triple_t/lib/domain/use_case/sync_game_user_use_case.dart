import 'package:game_domain/game_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/user_domain.dart';

part 'sync_game_user_use_case.g.dart';

@riverpod
Future<void> syncGameUserUseCase(
  Ref ref, {
  required int playerOneId,
  required int playerTwoId,
  required CurrentGameState state,
}) async {
  if (state == CurrentGameState.playerOneWon) {
    await _updateUserStats(ref, playerOneId, playerTwoId, GameResult.win);
    await _updateUserStats(ref, playerTwoId, playerOneId, GameResult.lose);
  } else if (state == CurrentGameState.playerTwoWon) {
    await _updateUserStats(ref, playerOneId, playerTwoId, GameResult.lose);
    await _updateUserStats(ref, playerTwoId, playerOneId, GameResult.win);
  } else if (state == CurrentGameState.draw) {
    await _updateUserStats(ref, playerOneId, playerTwoId, GameResult.draw);
    await _updateUserStats(ref, playerTwoId, playerOneId, GameResult.draw);
  }
}

Future<void> _updateUserStats(Ref ref, int currentPlayerId, int opponentPlayerId, GameResult result) async {
  await ref.read(updateUserStatisticsUseCaseProvider(
    currentPlayerId: currentPlayerId,
    opponentPlayerId: opponentPlayerId,
    result: result,
  ).future);
}
