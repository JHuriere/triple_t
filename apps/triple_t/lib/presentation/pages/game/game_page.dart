import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/data/entity/game/current_game_entity.dart';
import 'package:triple_t/domain/helper/game_helper.dart';
import 'package:triple_t/domain/model/current_game/current_game_model.dart';
import 'package:triple_t/domain/use_case/current_game/get_current_game_use_case.dart';
import 'package:triple_t/domain/use_case/current_game/reset_current_game_use_case.dart';
import 'package:triple_t/domain/use_case/current_game/update_current_game_elements_use_case.dart';
import 'package:triple_t/domain/use_case/current_game/update_current_game_state_use_case.dart';
import 'package:triple_t/domain/use_case/user/update_user_statistics_use_case.dart';
import 'package:triple_t/domain/use_case/user/update_user_use_case.dart';
import 'package:triple_t/presentation/pages/game/widget/draw_overlay.dart';
import 'package:triple_t/presentation/pages/game/widget/game_grid.dart';
import 'package:triple_t/presentation/pages/game/widget/game_statistics.dart';
import 'package:triple_t/presentation/pages/game/widget/select_players.dart';
import 'package:triple_t/presentation/pages/game/widget/winner_overlay.dart';
import 'package:tt_i18n/i18n.dart';

typedef ResultState = ({ResultType type, String? winner});

class GamePage extends HookConsumerWidget {
  const GamePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = ref.watch(getCurrentGameUseCaseProvider);

    final canPlay = useState<bool>(true);
    final winningLine = useState<List<int>?>(null);
    final lineAnimation = useAnimationController(duration: const Duration(milliseconds: 450));
    final resultState = useState<ResultState?>(null);
    final showOverlay = useState<bool>(false);

    useEffect(() {
      if (winningLine.value != null) lineAnimation.forward(from: 0);
      return null;
    }, [winningLine.value]);

    useEffect(() {
      void listener(AnimationStatus status) {
        if (status == AnimationStatus.completed && resultState.value != null) {
          Future.delayed(const Duration(milliseconds: 500), () => showOverlay.value = true);
        }
      }

      lineAnimation.addStatusListener(listener);
      return () => lineAnimation.removeStatusListener(listener);
    }, [resultState.value]);

    void resetGame() async {
      canPlay.value = true;
      winningLine.value = null;
      resultState.value = null;
      showOverlay.value = false;
      lineAnimation.reset();
      await ref.read(resetCurrentGameUseCaseProvider.future);
      ref.invalidate(getCurrentGameUseCaseProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.ticTacToe),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetGame,
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: .symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SelectPlayers(),

                const SizedBox(height: 10),
                GameStatistics(currentGame: currentGame),

                const SizedBox(height: 20),
                Text(
                  context.l10n.turn(currentGame.oTurn ? currentGame.playerOne.name : currentGame.playerTwo.name),
                  textAlign: .center,
                ),
                const SizedBox(height: 20),

                GameGrid(
                  currentGame: currentGame,
                  winningLineValue: winningLine.value,
                  lineAnimation: lineAnimation,
                  onTap: (index) => canPlay.value ? _onTap(ref, currentGame, index, winningLine, resultState, canPlay, showOverlay) : null,
                ),
              ],
            ),
          ),

          // Overlays for winner and draw
          if (showOverlay.value && resultState.value != null)
            if (resultState.value!.type == ResultType.winner)
              WinnerOverlay(winner: resultState.value!.winner ?? '', onDismiss: resetGame)
            else if (resultState.value!.type == ResultType.draw)
              DrawOverlay(onDismiss: resetGame),
        ],
      ),
    );
  }

  Future<void> _onTap(
    WidgetRef ref,
    CurrentGameModel currentGame,
    int index,
    ValueNotifier<List<int>?> winningLine,
    ValueNotifier<ResultState?> resultState,
    ValueNotifier<bool> canPlay,
    ValueNotifier<bool> showOverlay,
  ) async {
    if (currentGame.elements[index].isNotEmpty) return;

    canPlay.value = false;
    final elements = List<String>.from(currentGame.elements);
    elements[index] = currentGame.oTurn ? currentGame.playerOne.emoticon : currentGame.playerTwo.emoticon;

    await ref.read(updateCurrentGameElementsUseCaseProvider(elements: elements).future);
    final currentGameUpdated = ref.refresh(getCurrentGameUseCaseProvider);

    resultState.value = await _handleResult(ref, currentGameUpdated, elements, winningLine);

    if (resultState.value != null) {
      if (resultState.value!.type == ResultType.draw) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        showOverlay.value = true;
      }
      return;
    }

    if (!currentGameUpdated.oTurn && currentGameUpdated.playerTwo.id == 1) {
      // AI move
      await Future<void>.delayed(const Duration(milliseconds: 500));
      final aiMove = GameHelper.getBestAIMove(elements, currentGameUpdated.playerOne.emoticon, currentGameUpdated.playerTwo.emoticon);
      if (aiMove != null) {
        await _onTap(ref, currentGameUpdated, aiMove, winningLine, resultState, canPlay, showOverlay);
      }
    }
    canPlay.value = true;
  }

  Future<ResultState?> _handleResult(
    WidgetRef ref,
    CurrentGameModel currentGame,
    List<String> elements,
    ValueNotifier<List<int>?> winningLine,
  ) async {
    final combination = GameHelper.getWinningCombination(elements);

    if (combination != null) {
      winningLine.value = combination;
      final winner = currentGame.oTurn ? currentGame.playerTwo.name : currentGame.playerOne.name;
      await ref.read(updateCurrentGameStateUseCaseProvider(state: currentGame.oTurn ? CurrentGameState.playerTwoWon : CurrentGameState.playerOneWon).future);
      await ref.read(updateUserUseCaseProvider(user: currentGame.playerOne).future);

      await ref.read(updateUserStatisticsUseCaseProvider(id: currentGame.playerOne.id).future);
      await ref.read(updateUserStatisticsUseCaseProvider(id: currentGame.playerTwo.id).future);

      return (type: ResultType.winner, winner: winner);
    }

    if (elements.every((element) => element.isNotEmpty)) {
      await ref.read(updateCurrentGameStateUseCaseProvider(state: CurrentGameState.draw).future);

      await ref.read(updateUserStatisticsUseCaseProvider(id: currentGame.playerOne.id).future);
      await ref.read(updateUserStatisticsUseCaseProvider(id: currentGame.playerTwo.id).future);

      return (type: ResultType.draw, winner: null);
    }
    return null;
  }
}
