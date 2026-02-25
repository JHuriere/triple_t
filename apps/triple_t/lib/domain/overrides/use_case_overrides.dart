import 'package:game_domain/game_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/domain/use_case/sync_game_user_use_case.dart';

sealed class UseCaseOverrides {
  static List<Override> get() => [
        notifyGameResultUseCaseProvider.overrideWith((ref, argument) {
          return ref.read(syncGameUserUseCaseProvider(
            playerOneId: argument.playerOneId,
            playerTwoId: argument.playerTwoId,
            state: argument.state,
          ).future);
        }),
      ];
}
