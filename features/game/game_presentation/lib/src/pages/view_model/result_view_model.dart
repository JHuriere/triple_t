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
    
    if (currentGame.state == CurrentGameState.playerOneWon || currentGame.state == CurrentGameState.playerTwoWon) {
      final gameService = ref.read(gameServiceProvider);
      final combination = gameService.getWinningCombination(currentGame.elements);
      final winner = currentGame.state == CurrentGameState.playerOneWon ? playerOne.name : playerTwo.name;
      
      state = WinnerResultState(winningLine: combination ?? [], winner: winner);
    } else if (currentGame.state == CurrentGameState.draw) {
      await Future<void>.delayed(const Duration(milliseconds: 500), () => showOverlay.value = true);
      state = DrawResultState();
    } else {
      state = NoResultState();
    }
  }
}
