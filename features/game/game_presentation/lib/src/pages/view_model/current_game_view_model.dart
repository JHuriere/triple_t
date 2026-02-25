import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/view_model/result_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/user_domain.dart';

part 'current_game_view_model.g.dart';

typedef CurrentGameModel = ({
  CurrentGameEntity currentGame,
  UserEntity playerOne,
  UserEntity playerTwo,
  bool actionInProgress,
});

@riverpod
class CurrentGameViewModel extends _$CurrentGameViewModel {
  @override
  CurrentGameModel build() {
    final currentGame = ref.watch(getCurrentGameUseCaseProvider);
    final playerOne = ref.watch(getUserByIdUseCaseProvider(currentGame.playerOneId)) ?? UserEntity.empty();
    final playerTwo = ref.watch(getUserByIdUseCaseProvider(currentGame.playerTwoId)) ?? UserEntity.empty();

    return (currentGame: currentGame, playerOne: playerOne, playerTwo: playerTwo, actionInProgress: false);
  }

  Future<void> playTurn(int index) async {
    if (state.actionInProgress) return;

    state = (currentGame: state.currentGame, playerOne: state.playerOne, playerTwo: state.playerTwo, actionInProgress: true);

    try {
      final emoticon = state.currentGame.oTurn ? state.playerOne.emoticon : state.playerTwo.emoticon;
      final gameUpdated = await ref.read(playMoveUseCaseProvider(index: index, emoticon: emoticon).future);
      state = (currentGame: gameUpdated, playerOne: state.playerOne, playerTwo: state.playerTwo, actionInProgress: true);

      await ref.read(resultViewModelProvider.notifier).checkResult();

      if (gameUpdated.state == CurrentGameState.inProgress) {
        if (!gameUpdated.oTurn && gameUpdated.playerTwoId == 1) {
          await Future<void>.delayed(const Duration(milliseconds: 500));
          if (!ref.mounted) return;

          final elements = List<String>.from(gameUpdated.elements);
          final aiMove = ref.read(gameServiceProvider).calculateBestMove(
                elements,
                state.playerOne.emoticon,
                state.playerTwo.emoticon,
              );

          if (aiMove != null) {
            final gameUpdatedAI = await ref.read(playMoveUseCaseProvider(index: aiMove, emoticon: state.playerTwo.emoticon).future);
            state = (currentGame: gameUpdatedAI, playerOne: state.playerOne, playerTwo: state.playerTwo, actionInProgress: true);
            await ref.read(resultViewModelProvider.notifier).checkResult();
          }
        }
      }
    } finally {
      if (ref.mounted) {
        state = (currentGame: state.currentGame, playerOne: state.playerOne, playerTwo: state.playerTwo, actionInProgress: false);
      }
    }
  }
}

