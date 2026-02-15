import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/data/entity/game/current_game_entity.dart';
import 'package:triple_t/data/repository/current_game_repository.dart';

part 'reset_current_game_use_case.g.dart';

@riverpod
Future<void> resetCurrentGameUseCase(Ref ref) async {
  final repository = ref.watch(currentGameRepositoryProvider);
  final currentGame = repository.get();
  await repository.save(
    currentGame.copyWith(
      state: CurrentGameState.initial,
      oTurn: true,
      elements: ['', '', '', '', '', '', '', '', ''],
    ),
  );
}
