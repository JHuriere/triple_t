import 'package:game_domain/src/entity/current_game_entity.dart';
import 'package:game_domain/src/repository/get_current_game_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_current_game_player_use_case.g.dart';

@riverpod
Future<void> updateCurrentGamePlayerUseCase(Ref ref, {int? playerOneId, int? playerTwoId}) async {
  final repository = ref.watch(getCurrentGameRepositoryProvider);

  CurrentGameEntity entity = repository.get();

  if (playerOneId != null) entity = entity.copyWith(playerOneId: playerOneId);
  if (playerTwoId != null) entity = entity.copyWith(playerTwoId: playerTwoId);

  await repository.save(
    entity.copyWith(playerOneWins: 0, playerTwoWins: 0, draws: 0),
  );
}
