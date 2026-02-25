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
  late Future<void> req1;
  late Future<void> req2;

  if (state == CurrentGameState.playerOneWon) {
    req1 = ref.read(updateUserStatisticsUseCaseProvider(currentPlayerId: playerOneId, opponentPlayerId: playerTwoId, result: GameResult.win).future);
    req2 = ref.read(updateUserStatisticsUseCaseProvider(currentPlayerId: playerTwoId, opponentPlayerId: playerOneId, result: GameResult.lose).future);
  } else if (state == CurrentGameState.playerTwoWon) {
    req1 = ref.read(updateUserStatisticsUseCaseProvider(currentPlayerId: playerOneId, opponentPlayerId: playerTwoId, result: GameResult.lose).future);
    req2 = ref.read(updateUserStatisticsUseCaseProvider(currentPlayerId: playerTwoId, opponentPlayerId: playerOneId, result: GameResult.win).future);
  } else if (state == CurrentGameState.draw) {
    req1 = ref.read(updateUserStatisticsUseCaseProvider(currentPlayerId: playerOneId, opponentPlayerId: playerTwoId, result: GameResult.draw).future);
    req2 = ref.read(updateUserStatisticsUseCaseProvider(currentPlayerId: playerTwoId, opponentPlayerId: playerOneId, result: GameResult.draw).future);
  } else {
    return;
  }

  await Future.wait([req1, req2]);
}
