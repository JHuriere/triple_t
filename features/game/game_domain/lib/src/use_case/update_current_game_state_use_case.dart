import 'package:game_domain/src/entity/current_game_entity.dart';
import 'package:game_domain/src/repository/get_current_game_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_current_game_state_use_case.g.dart';

@riverpod
Future<void> updateCurrentGameStateUseCase(Ref ref, {required CurrentGameState state}) async {
  final repository = ref.watch(getCurrentGameRepositoryProvider);

  final entity = repository.get();
  await repository.save(
    entity.copyWith(
      state: state,
      playerOneWins: entity.playerOneWins + (state == CurrentGameState.playerOneWon ? 1 : 0),
      playerTwoWins: entity.playerTwoWins + (state == CurrentGameState.playerTwoWon ? 1 : 0),
      draws: entity.draws + (state == CurrentGameState.draw ? 1 : 0),
    ),
  );
}
