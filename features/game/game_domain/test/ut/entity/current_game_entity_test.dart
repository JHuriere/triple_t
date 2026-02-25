import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/src/entity/current_game_entity.dart';

void main() {
  group('CurrentGameEntity', () {
    test('should create entity with default values', () {
      // Arrange & Act
      const entity = CurrentGameEntity();

      // Assert
      expect(entity.elements, ['', '', '', '', '', '', '', '', '']);
      expect(entity.state, CurrentGameState.initial);
      expect(entity.oTurn, true);
      expect(entity.playerOneId, 2);
      expect(entity.playerTwoId, 1);
      expect(entity.playerOneWins, 0);
      expect(entity.playerTwoWins, 0);
      expect(entity.draws, 0);
    });

    test('should create entity with custom values', () {
      // Arrange & Act
      const entity = CurrentGameEntity(
        elements: ['X', 'O', 'X', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
        playerOneId: 5,
        playerTwoId: 3,
        playerOneWins: 2,
        playerTwoWins: 1,
        draws: 1,
      );

      // Assert
      expect(entity.elements, ['X', 'O', 'X', '', '', '', '', '', '']);
      expect(entity.state, CurrentGameState.inProgress);
      expect(entity.oTurn, false);
      expect(entity.playerOneId, 5);
      expect(entity.playerTwoId, 3);
      expect(entity.playerOneWins, 2);
      expect(entity.playerTwoWins, 1);
      expect(entity.draws, 1);
    });

    test('should copy entity with updated values', () {
      // Arrange
      const entity = CurrentGameEntity();

      // Act
      final updated = entity.copyWith(
        elements: ['X', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
      );

      // Assert
      expect(updated.elements, ['X', '', '', '', '', '', '', '', '']);
      expect(updated.state, CurrentGameState.inProgress);
      expect(updated.oTurn, false);
      expect(updated.playerOneId, 2);
      expect(updated.playerTwoId, 1);
    });

    test('should be equal when values are the same', () {
      // Arrange
      const entity1 = CurrentGameEntity(
        elements: ['X', '', '', '', '', '', '', '', ''],
        playerOneId: 5,
      );
      const entity2 = CurrentGameEntity(
        elements: ['X', '', '', '', '', '', '', '', ''],
        playerOneId: 5,
      );

      // Assert
      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
    });
  });

  group('CurrentGameState', () {
    test('should have all states defined', () {
      expect(CurrentGameState.values, [
        CurrentGameState.initial,
        CurrentGameState.inProgress,
        CurrentGameState.playerOneWon,
        CurrentGameState.playerTwoWon,
        CurrentGameState.draw,
      ]);
    });
  });
}
