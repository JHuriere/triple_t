import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/src/model/current_game_model.dart';
import 'package:game_domain/game_domain.dart';

void main() {
  group('CurrentGameModel', () {
    test('should serialize to JSON', () {
      const model = CurrentGameModel(
        elements: ['X', 'O', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
        playerOneId: 5,
        playerTwoId: 3,
        playerOneWins: 1,
        playerTwoWins: 2,
        draws: 3,
      );

      final json = model.toJson();

      expect(json['elements'], ['X', 'O', '', '', '', '', '', '', '']);
      expect(json['state'], 'inProgress');
      expect(json['oTurn'], false);
      expect(json['playerOneId'], 5);
      expect(json['playerTwoId'], 3);
      expect(json['playerOneWins'], 1);
      expect(json['playerTwoWins'], 2);
      expect(json['draws'], 3);
    });

    test('should deserialize from JSON', () {
      final json = {
        'elements': ['X', 'O', '', '', '', '', '', '', ''],
        'state': 'inProgress',
        'oTurn': false,
        'playerOneId': 5,
        'playerTwoId': 3,
        'playerOneWins': 1,
        'playerTwoWins': 2,
        'draws': 3,
      };

      final model = CurrentGameModel.fromJson(json);

      expect(model.elements, ['X', 'O', '', '', '', '', '', '', '']);
      expect(model.state, CurrentGameState.inProgress);
      expect(model.oTurn, false);
      expect(model.playerOneId, 5);
      expect(model.playerTwoId, 3);
      expect(model.playerOneWins, 1);
      expect(model.playerTwoWins, 2);
      expect(model.draws, 3);
    });

    test('should convert to Entity', () {
      const model = CurrentGameModel(
        elements: ['X', 'O', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        playerOneId: 5,
      );

      final entity = model.toEntity();

      expect(entity.elements, model.elements);
      expect(entity.state, model.state);
      expect(entity.playerOneId, model.playerOneId);
    });

    test('should create from Entity', () {
      const entity = CurrentGameEntity(
        elements: ['X', 'O', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        playerOneId: 5,
      );

      final model = CurrentGameModel.fromEntity(entity);

      expect(model.elements, entity.elements);
      expect(model.state, entity.state);
      expect(model.playerOneId, entity.playerOneId);
    });
  });
}
