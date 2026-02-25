import 'package:game_domain/game_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_move_use_case.g.dart';

@riverpod
Future<CurrentGameEntity> playMoveUseCase(Ref ref, {required int index, required String emoticon}) async {
  final repository = ref.watch(getCurrentGameRepositoryProvider);
  final gameService = ref.read(gameServiceProvider);
  
  final entity = repository.get();
  
  // 1. Validation: check if game is already finished or square is occupied
  if (entity.state != CurrentGameState.initial && entity.state != CurrentGameState.inProgress) {
    return entity;
  }
  if (entity.elements[index].isNotEmpty) {
    return entity;
  }

  // 2. Update grid
  final newElements = List<String>.from(entity.elements);
  newElements[index] = emoticon;

  // 3. Evaluate new state
  final newState = gameService.evaluateState(newElements, entity.oTurn);

  // 4. Update entity based on new state
  CurrentGameEntity updatedEntity = entity.copyWith(
    elements: newElements,
    state: newState,
  );

  if (newState == CurrentGameState.playerOneWon) {
    updatedEntity = updatedEntity.copyWith(playerOneWins: entity.playerOneWins + 1);
  } else if (newState == CurrentGameState.playerTwoWon) {
    updatedEntity = updatedEntity.copyWith(playerTwoWins: entity.playerTwoWins + 1);
  } else if (newState == CurrentGameState.draw) {
    updatedEntity = updatedEntity.copyWith(draws: entity.draws + 1);
  } else {
    // Game still in progress, flip turn
    updatedEntity = updatedEntity.copyWith(oTurn: !entity.oTurn, state: CurrentGameState.inProgress);
  }

  // 5. Save updated game
  final savedEntity = await repository.save(updatedEntity);

  // 6. Update user statistics if game finished
  if (newState != CurrentGameState.inProgress) {
    await ref.read(notifyGameResultUseCaseProvider(
      playerOneId: entity.playerOneId,
      playerTwoId: entity.playerTwoId,
      state: newState,
    ).future);
  }

  return savedEntity;
}
