import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:triple_t/data/entity/game/current_game_entity.dart';
import 'package:triple_t/domain/model/user/user_model.dart';

part 'current_game_model.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
abstract class CurrentGameModel with _$CurrentGameModel {
  const CurrentGameModel._();

  const factory CurrentGameModel({
    @Default(['', '', '', '', '', '', '', '', '']) List<String> elements,
    @Default(true) bool oTurn,
    @Default(CurrentGameState.initial) CurrentGameState state,
    required UserModel playerOne,
    required UserModel playerTwo,
    @Default(0) int playerOneWins,
    @Default(0) int playerTwoWins,
    @Default(0) int draws,
  }) = _Data;

  factory CurrentGameModel.fromEntity({
    required CurrentGameEntity entity,
    required UserModel playerOne,
    required UserModel playerTwo,
  }) => CurrentGameModel(
    elements: entity.elements,
    oTurn: entity.oTurn,
    state: entity.state,
    playerOne: playerOne,
    playerTwo: playerTwo,
    playerOneWins: entity.playerOneWins,
    playerTwoWins: entity.playerTwoWins,
    draws: entity.draws,
  );

  CurrentGameEntity toEntity() => CurrentGameEntity(
    elements: elements,
    oTurn: oTurn,
    state: state,
    playerOneId: playerOne.id,
    playerTwoId: playerTwo.id,
    playerOneWins: playerOneWins,
    playerTwoWins: playerTwoWins,
    draws: draws,
  );
}
