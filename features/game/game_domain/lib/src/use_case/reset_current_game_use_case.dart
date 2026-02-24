import 'package:game_domain/src/entity/current_game_entity.dart';
import 'package:game_domain/src/repository/get_current_game_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_current_game_use_case.g.dart';

@riverpod
Future<void> resetCurrentGameUseCase(Ref ref) async {
  final repository = ref.watch(getCurrentGameRepositoryProvider);

  final currentGame = repository.get();
  await repository.save(
    currentGame.copyWith(
      state: CurrentGameState.initial,
      oTurn: true,
      elements: ['', '', '', '', '', '', '', '', ''],
    ),
  );
}
