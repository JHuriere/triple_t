import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/data/entity/game/current_game_entity.dart';
import 'package:triple_t/domain/model/current_game/current_game_model.dart';
import 'package:triple_t/domain/model/user/user_model.dart';
import 'package:triple_t/domain/use_case/current_game/get_current_game_use_case.dart';
import 'package:triple_t/domain/use_case/current_game/update_current_game_player_use_case.dart';
import 'package:triple_t/domain/use_case/user/get_all_users_use_case.dart';
import 'package:triple_t/presentation/pages/game/widget/drowpdown_player.dart';
import 'package:triple_t_i18n/i18n.dart';

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
