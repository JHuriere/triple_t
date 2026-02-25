import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_game_entity.freezed.dart';

@Freezed()
abstract class CurrentGameEntity with _$CurrentGameEntity {
  const factory CurrentGameEntity({
    @Default(['', '', '', '', '', '', '', '', '']) List<String> elements,
    @Default(CurrentGameState.initial) CurrentGameState state,
    @Default(true) bool oTurn,
    @Default(2) int playerOneId,
    @Default(1) int playerTwoId,
    @Default(0) int playerOneWins,
    @Default(0) int playerTwoWins,
    @Default(0) int draws,
  }) = _CurrentGameEntity;
}

enum CurrentGameState {
  initial,
  inProgress,
  playerOneWon,
  playerTwoWon,
  draw,
}
