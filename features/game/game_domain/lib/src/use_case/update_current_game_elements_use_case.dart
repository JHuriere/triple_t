import 'package:game_domain/src/entity/current_game_entity.dart';
import 'package:game_domain/src/repository/get_current_game_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_current_game_elements_use_case.g.dart';

@riverpod
Future<CurrentGameEntity> updateCurrentGameElementsUseCase(Ref ref, {required List<String> elements}) async {
  final repository = ref.watch(getCurrentGameRepositoryProvider);

  final entity = repository.get();
  return await repository.save(
    entity.copyWith(elements: elements, oTurn: !entity.oTurn, state: CurrentGameState.inProgress),
  );
}
