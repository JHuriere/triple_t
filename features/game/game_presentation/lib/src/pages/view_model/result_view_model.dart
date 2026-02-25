import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/view_model/current_game_view_model.dart';
import 'package:game_presentation/src/pages/view_model/state/result_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'result_view_model.g.dart';

@riverpod
class ResultViewModel extends _$ResultViewModel {
  @override
  ResultState build() {
    return const InitialResultState();
  }

  Future<void> checkResult() async {
    final (:currentGame, :playerOne, :playerTwo, :actionInProgress) = ref.read(currentGameViewModelProvider);
    
    if (currentGame.state == CurrentGameState.playerOneWon || currentGame.state == CurrentGameState.playerTwoWon) {
      final gameService = ref.read(gameServiceProvider);
      final combination = gameService.getWinningCombination(currentGame.elements);
      final winner = currentGame.state == CurrentGameState.playerOneWon ? playerOne.name : playerTwo.name;
      
      state = WinnerResultState(winningLine: combination ?? [], winner: winner);
    } else if (currentGame.state == CurrentGameState.draw) {
      state = const DrawResultState();
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (!ref.mounted) return;
      state = const DrawResultState(showOverlay: true);
    } else {
      state = const NoResultState();
    }
  }

  void setShowOverlay(bool show) {
    if (state is WinnerResultState) {
      state = (state as WinnerResultState).copyWith(showOverlay: show);
    } else if (state is DrawResultState) {
      state = DrawResultState(showOverlay: show);
    }
  }
}
