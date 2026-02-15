import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/data/entity/game/current_game_entity.dart';
import 'package:triple_t/data/repository/current_game_repository.dart';

part 'update_current_game_elements_use_case.g.dart';

@riverpod
Future<void> updateCurrentGameElementsUseCase(Ref ref, {required List<String> elements}) async {
  final repository = ref.watch(currentGameRepositoryProvider);
  final entity = repository.get();
  await repository.save(entity.copyWith(elements: elements, oTurn: !entity.oTurn, state: CurrentGameState.inProgress));
}
