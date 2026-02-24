import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_game_entity.freezed.dart';
part 'current_game_entity.g.dart';

@Freezed()
abstract class CurrentGameEntity with _$CurrentGameEntity {
  @JsonSerializable(explicitToJson: true)
  const factory CurrentGameEntity({
    @JsonKey(name: 'elements') @Default(['', '', '', '', '', '', '', '', '']) List<String> elements,
    @JsonKey(name: 'state') @Default(CurrentGameState.initial) CurrentGameState state,
    @JsonKey(name: 'oTurn') @Default(true) bool oTurn,
    @JsonKey(name: 'playerOneId') @Default(2) int playerOneId,
    @JsonKey(name: 'playerTwoId') @Default(1) int playerTwoId,
    @JsonKey(name: 'playerOneWins') @Default(0) int playerOneWins,
    @JsonKey(name: 'playerTwoWins') @Default(0) int playerTwoWins,
    @JsonKey(name: 'draws') @Default(0) int draws,
  }) = _CurrentGameEntity;

  factory CurrentGameEntity.fromJson(Map<String, dynamic> json) => _$CurrentGameEntityFromJson(json);
}

enum CurrentGameState {
  initial,
  inProgress,
  playerOneWon,
  playerTwoWon,
  draw,
}
