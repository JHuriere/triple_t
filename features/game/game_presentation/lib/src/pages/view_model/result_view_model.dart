import 'package:flutter/foundation.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/view_model/current_game_view_model.dart';
import 'package:game_presentation/src/pages/view_model/state/result_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/user_domain.dart';

part 'result_view_model.g.dart';

@riverpod
class ResultViewModel extends _$ResultViewModel {
  @override
  ResultState build() {
    return InitialResultState();
  }

  Future<void> checkResult(ValueNotifier<bool> showOverlay) async {
    final (:currentGame, :playerOne, :playerTwo) = ref.read(currentGameViewModelProvider);
    final gameService = ref.read(gameServiceProvider);
    final combination = gameService.getWinningCombination(currentGame.elements);

    if (combination != null) {
      final winner = currentGame.oTurn ? playerTwo.name : playerOne.name;

      await ref.read(updateCurrentGameStateUseCaseProvider(state: currentGame.oTurn ? CurrentGameState.playerTwoWon : CurrentGameState.playerOneWon).future);
      await ref.read(
        updateUserStatisticsUseCaseProvider(
          currentPlayerId: currentGame.playerOneId,
          opponentPlayerId: currentGame.playerTwoId,
          result: currentGame.oTurn ? GameResult.lose : GameResult.win,
        ).future,
      );
      await ref.read(
        updateUserStatisticsUseCaseProvider(
          currentPlayerId: currentGame.playerTwoId,
          opponentPlayerId: currentGame.playerOneId,
          result: currentGame.oTurn ? GameResult.lose : GameResult.lose,
        ).future,
      );

      state = WinnerResultState(winningLine: combination, winner: winner);
    } else if (currentGame.elements.every((element) => element.isNotEmpty)) {
      await ref.read(updateCurrentGameStateUseCaseProvider(state: CurrentGameState.draw).future);
      await ref.read(updateUserStatisticsUseCaseProvider(currentPlayerId: currentGame.playerOneId, opponentPlayerId: currentGame.playerTwoId, result: GameResult.draw).future);
      await ref.read(updateUserStatisticsUseCaseProvider(currentPlayerId: currentGame.playerTwoId, opponentPlayerId: currentGame.playerOneId, result: GameResult.draw).future);

      await Future<void>.delayed(const Duration(milliseconds: 500), () => showOverlay.value = true);
      state = DrawResultState();
    } else {
      state = NoResultState();
    }
  }
}
