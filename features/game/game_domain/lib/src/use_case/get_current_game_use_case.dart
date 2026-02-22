import 'package:game_data/game_data.dart' show currentGameRepositoryProvider;
import 'package:game_domain/src/model/current_game_model.dart' show CurrentGameModel;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tt_database/tt_database.dart';
import 'package:user_data/user_data.dart' show userRepositoryProvider, UserEntity;
import 'package:user_domain/user_domain.dart' show UserModel;

part 'get_current_game_use_case.g.dart';

@riverpod
CurrentGameModel getCurrentGameUseCase(Ref ref) {
  final entity = ref.watch(currentGameRepositoryProvider).get();
  final playerOne = ref.watch(userRepositoryProvider).get(entity.playerOneId);
  final playerTwo = ref.watch(userRepositoryProvider).get(entity.playerTwoId);
  final emptyUser = Entity<UserEntity>(id: 0, data: UserEntity());

  return CurrentGameModel.fromEntity(
    entity: entity,
    playerOne: UserModel.fromEntity(entity: playerOne ?? emptyUser),
    playerTwo: UserModel.fromEntity(entity: playerTwo ?? emptyUser),
  );
}
