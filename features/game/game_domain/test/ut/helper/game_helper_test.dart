import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/src/helper/game_helper.dart';

void main() {
  group('GameHelper', () {
    group('getWinningCombination', () {
      test('should return null when no winning combination exists', () {
        // Arrange
        final elements = ['', '', '', '', '', '', '', '', ''];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, isNull);
      });

      test('should return null when game is in progress with no winner', () {
        // Arrange
        final elements = ['X', 'O', 'X', 'O', 'X', '', '', '', ''];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, isNull);
      });

      test('should detect horizontal winning combination - first row', () {
        // Arrange
        final elements = ['X', 'X', 'X', '', '', '', '', '', ''];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, [0, 1, 2]);
      });

      test('should detect horizontal winning combination - second row', () {
        // Arrange
        final elements = ['', '', '', 'O', 'O', 'O', '', '', ''];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, [3, 4, 5]);
      });

      test('should detect horizontal winning combination - third row', () {
        // Arrange
        final elements = ['', '', '', '', '', '', 'X', 'X', 'X'];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, [6, 7, 8]);
      });

      test('should detect vertical winning combination - first column', () {
        // Arrange
        final elements = ['O', '', '', 'O', '', '', 'O', '', ''];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, [0, 3, 6]);
      });

      test('should detect vertical winning combination - second column', () {
        // Arrange
        final elements = ['', 'X', '', '', 'X', '', '', 'X', ''];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, [1, 4, 7]);
      });

      test('should detect vertical winning combination - third column', () {
        // Arrange
        final elements = ['', '', 'O', '', '', 'O', '', '', 'O'];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, [2, 5, 8]);
      });

      test('should detect diagonal winning combination - top-left to bottom-right', () {
        // Arrange
        final elements = ['X', '', '', '', 'X', '', '', '', 'X'];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, [0, 4, 8]);
      });

      test('should detect diagonal winning combination - top-right to bottom-left', () {
        // Arrange
        final elements = ['', '', 'O', '', 'O', '', 'O', '', ''];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, [2, 4, 6]);
      });

      test('should detect winning combination with emoticons', () {
        // Arrange
        final elements = ['😀', '😢', '', '', '😀', '😢', '', '', '😀'];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, [0, 4, 8]);
      });

      test('should return first winning combination when multiple exist', () {
        // Arrange - both first row and first column win
        final elements = ['X', 'X', 'X', 'X', '', '', 'X', '', ''];

        // Act
        final result = GameHelper.getWinningCombination(elements);

        // Assert
        expect(result, [0, 1, 2]); // First row is checked first
      });
    });

    group('getBestAIMove', () {
      test('should return null when board is full', () {
        // Arrange
        final elements = ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'O'];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, isNull);
      });

      test('should win when AI can win in next move - horizontal', () {
        // Arrange
        final elements = ['O', 'O', '', 'X', '', '', '', '', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, 2); // Complete first row
      });

      test('should win when AI can win in next move - vertical', () {
        // Arrange
        final elements = ['X', 'O', '', '', 'O', '', '', '', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, 7); // Complete second column
      });

      test('should win when AI can win in next move - diagonal', () {
        // Arrange
        final elements = ['O', '', '', '', 'O', '', '', '', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, 8); // Complete diagonal
      });

      test('should block player when player can win in next move - horizontal', () {
        // Arrange
        final elements = ['X', 'X', '', 'O', '', '', '', '', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, 2); // Block first row
      });

      test('should block player when player can win in next move - vertical', () {
        // Arrange
        final elements = ['X', '', 'O', 'X', '', 'O', '', '', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, 8); // Block third column
      });

      test('should block player when player can win in next move - diagonal', () {
        // Arrange
        final elements = ['X', '', '', '', 'X', '', '', '', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, 8); // Block diagonal
      });

      test('should prioritize winning over blocking', () {
        // Arrange - AI can win at position 2, player can win at position 8
        final elements = ['O', 'O', '', '', '', '', 'X', 'X', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, 2); // Win instead of blocking
      });

      test('should make random move when no immediate win or block needed', () {
        // Arrange
        final elements = ['X', '', '', '', 'O', '', '', '', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, isNotNull);
        expect(result! >= 0 && result < 9, isTrue);
        expect(elements[result], ''); // Should be an empty spot
      });

      test('should work with emoticons', () {
        // Arrange
        final elements = ['😀', '😀', '', '😢', '', '', '', '', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, '😀', '😢');

        // Assert
        expect(result, 2); // Block player from winning
      });

      test('should return available spot when only one spot left', () {
        // Arrange
        final elements = ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, 8);
      });

      test('should make a valid move when checking winning positions', () {
        // Arrange - Player can win at position 2
        final elements = ['X', 'X', '', 'O', '', '', '', '', ''];

        // Act
        final result = GameHelper.getBestAIMove(elements, 'X', 'O');

        // Assert
        expect(result, 2); // Should block the winning move
        // Note: getBestAIMove modifies the list during processing as part of its algorithm
        // The final state will have the move tested, which is expected behavior
      });
    });
  });
}
