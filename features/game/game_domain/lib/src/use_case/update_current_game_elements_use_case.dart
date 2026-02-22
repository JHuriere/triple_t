import 'package:game_data/game_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_current_game_elements_use_case.g.dart';

@riverpod
Future<void> updateCurrentGameElementsUseCase(Ref ref, {required List<String> elements}) async {
  final repository = ref.watch(currentGameRepositoryProvider);
  final entity = repository.get();
  await repository.save(entity.copyWith(elements: elements, oTurn: !entity.oTurn, state: CurrentGameState.inProgress));
}
