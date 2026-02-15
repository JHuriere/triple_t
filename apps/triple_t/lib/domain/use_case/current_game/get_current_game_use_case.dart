import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/data/entity/user/user_entity.dart';
import 'package:triple_t/data/repository/current_game_repository.dart';
import 'package:triple_t/data/repository/user_repository.dart';
import 'package:triple_t/domain/model/current_game/current_game_model.dart';
import 'package:triple_t/domain/model/user/user_model.dart';
import 'package:tt_database/tt_database.dart';

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
