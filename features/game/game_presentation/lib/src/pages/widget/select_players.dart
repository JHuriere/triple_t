import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/widget/dropdown_player.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_i18n/i18n.dart';
import 'package:user_domain/user_domain.dart';

class SelectPlayers extends HookConsumerWidget {
  const SelectPlayers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(getAllUsersUseCaseProvider);
    final currentGame = ref.watch(getCurrentGameUseCaseProvider);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownPlayer(
                label: context.l10n.player1,
                users: users,
                value: currentGame.playerOne.id == 0 ? null : currentGame.playerOne.id,
                excludedUserIds: [1, currentGame.playerTwo.id],
                enabled: currentGame.state == CurrentGameState.initial,
                onChanged: (playerId) async => await _changePlayerOne(ref, users, currentGame, playerId),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: DropdownPlayer(
                label: context.l10n.player2,
                users: users,
                value: currentGame.playerTwo.id == 0 ? null : currentGame.playerTwo.id,
                excludedUserIds: [currentGame.playerOne.id],
                enabled: currentGame.state == CurrentGameState.initial,
                onChanged: (playerId) async => await _changePlayerTwo(ref, users, currentGame, playerId),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _changePlayerOne(WidgetRef ref, List<UserModel> users, CurrentGameModel currentGame, int playerId) async {
    if (currentGame.playerOne.id == playerId) return;

    await ref.read(updateCurrentGamePlayerUseCaseProvider(playerOne: users.firstWhere((user) => user.id == playerId)).future);
    ref.invalidate(getCurrentGameUseCaseProvider);
  }

  Future<void> _changePlayerTwo(WidgetRef ref, List<UserModel> users, CurrentGameModel currentGame, int playerId) async {
    if (currentGame.playerTwo.id == playerId) return;

    await ref.read(updateCurrentGamePlayerUseCaseProvider(playerTwo: users.firstWhere((user) => user.id == playerId)).future);
    ref.invalidate(getCurrentGameUseCaseProvider);
  }
}
