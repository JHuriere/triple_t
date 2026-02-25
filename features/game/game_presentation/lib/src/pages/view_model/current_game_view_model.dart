import 'package:game_domain/game_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/user_domain.dart';

part 'current_game_view_model.g.dart';

typedef CurrentGameModel = ({CurrentGameEntity currentGame, UserEntity playerOne, UserEntity playerTwo});

@riverpod
class CurrentGameViewModel extends _$CurrentGameViewModel {
  @override
  CurrentGameModel build() {
    final currentGame = ref.watch(getCurrentGameUseCaseProvider);
    final playerOne = ref.watch(getUserByIdUseCaseProvider(currentGame.playerOneId)) ?? UserEntity.empty();
    final playerTwo = ref.watch(getUserByIdUseCaseProvider(currentGame.playerTwoId)) ?? UserEntity.empty();

    return (currentGame: currentGame, playerOne: playerOne, playerTwo: playerTwo);
  }

  Future<void> playNextMove(int index) async {
    final (:currentGame, :playerOne, :playerTwo) = state;

    final emoticon = currentGame.oTurn ? playerOne.emoticon : playerTwo.emoticon;
    final currentGameUpdated = await ref.read(playMoveUseCaseProvider(index: index, emoticon: emoticon).future);

    state = (currentGame: currentGameUpdated, playerOne: playerOne, playerTwo: playerTwo);
  }

  Future<bool> playNextAIMove() async {
    final (:currentGame, :playerOne, :playerTwo) = state;

    if (!currentGame.oTurn && currentGame.playerTwoId == 1) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (!ref.mounted) return false;
      final elements = List<String>.from(currentGame.elements);
      final aiMove = ref.read(gameServiceProvider).calculateBestMove(
            elements,
            playerOne.emoticon,
            playerTwo.emoticon,
          );
      if (aiMove != null) {
        await playNextMove(aiMove);
        return true;
      }
    }
    return false;
  }
}
