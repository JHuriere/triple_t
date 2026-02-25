import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_domain/game_domain.dart';

part 'current_game_model.freezed.dart';
part 'current_game_model.g.dart';

@freezed
abstract class CurrentGameModel with _$CurrentGameModel {
  const factory CurrentGameModel({
    @Default(['', '', '', '', '', '', '', '', '']) List<String> elements,
    @Default(CurrentGameState.initial) CurrentGameState state,
    @Default(true) bool oTurn,
    @Default(2) int playerOneId,
    @Default(1) int playerTwoId,
    @Default(0) int playerOneWins,
    @Default(0) int playerTwoWins,
    @Default(0) int draws,
  }) = _CurrentGameModel;

  factory CurrentGameModel.fromJson(Map<String, dynamic> json) => _$CurrentGameModelFromJson(json);

  const CurrentGameModel._();

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
