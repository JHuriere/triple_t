import 'package:game_data/game_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
