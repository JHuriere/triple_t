import 'package:game_data/game_data.dart' show CurrentGameEntity, currentGameRepositoryProvider;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/user_domain.dart' show UserModel;

part 'update_current_game_player_use_case.g.dart';

@riverpod
Future<void> updateCurrentGamePlayerUseCase(Ref ref, {UserModel? playerOne, UserModel? playerTwo}) async {
  final repository = ref.watch(currentGameRepositoryProvider);
  CurrentGameEntity entity = repository.get();

  if (playerOne != null) entity = entity.copyWith(playerOneId: playerOne.id);
  if (playerTwo != null) entity = entity.copyWith(playerTwoId: playerTwo.id);

  await repository.save(
    entity.copyWith(
      playerOneWins: 0,
      playerTwoWins: 0,
      draws: 0,
    ),
  );
}
