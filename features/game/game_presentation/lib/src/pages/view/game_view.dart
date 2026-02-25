import 'package:flutter/material.dart';
import 'package:game_presentation/src/pages/view_model/current_game_view_model.dart';
import 'package:game_presentation/src/pages/widget/game_grid.dart';
import 'package:game_presentation/src/pages/widget/game_statistics.dart';
import 'package:game_presentation/src/pages/widget/select_players.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_i18n/i18n.dart';

class GameView extends HookConsumerWidget {
  final ValueChanged<int> onTap;

  const GameView({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(currentGameViewModelProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const SelectPlayers(),

          const SizedBox(height: 10),
          const GameStatistics(),

          const SizedBox(height: 20),
          Text(
            context.l10n.turn(viewModel.currentGame.oTurn ? viewModel.playerOne.name : viewModel.playerTwo.name),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          GameGrid(
            currentGame: viewModel.currentGame,
            playerOneEmoticon: viewModel.playerOne.emoticon,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
