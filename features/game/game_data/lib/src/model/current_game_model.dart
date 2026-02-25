import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_domain/game_domain.dart';

part 'current_game_model.freezed.dart';
part 'current_game_model.g.dart';

@freezed
abstract class CurrentGameModel with _$CurrentGameModel {
  const CurrentGameModel._();

  @JsonSerializable(explicitToJson: true)
  const factory CurrentGameModel({
    @JsonKey(name: 'elements') @Default(['', '', '', '', '', '', '', '', '']) List<String> elements,
    @JsonKey(name: 'state') @Default(CurrentGameState.initial) CurrentGameState state,
    @JsonKey(name: 'oTurn') @Default(true) bool oTurn,
    @JsonKey(name: 'playerOneId') @Default(2) int playerOneId,
    @JsonKey(name: 'playerTwoId') @Default(1) int playerTwoId,
    @JsonKey(name: 'playerOneWins') @Default(0) int playerOneWins,
    @JsonKey(name: 'playerTwoWins') @Default(0) int playerTwoWins,
    @JsonKey(name: 'draws') @Default(0) int draws,
  }) = _CurrentGameModel;

  factory CurrentGameModel.fromJson(Map<String, dynamic> json) => _$CurrentGameModelFromJson(json);

  CurrentGameEntity toEntity() => CurrentGameEntity(
    elements: elements,
    state: state,
    oTurn: oTurn,
    playerOneId: playerOneId,
    playerTwoId: playerTwoId,
    playerOneWins: playerOneWins,
    playerTwoWins: playerTwoWins,
    draws: draws,
  );

  factory CurrentGameModel.fromEntity(CurrentGameEntity entity) => CurrentGameModel(
    elements: entity.elements,
    state: entity.state,
    oTurn: entity.oTurn,
    playerOneId: entity.playerOneId,
    playerTwoId: entity.playerTwoId,
    playerOneWins: entity.playerOneWins,
    playerTwoWins: entity.playerTwoWins,
    draws: entity.draws,
  );
}
