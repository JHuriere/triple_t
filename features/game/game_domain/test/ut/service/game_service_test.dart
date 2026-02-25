import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/src/service/game_service.dart';
import 'package:game_domain/src/entity/current_game_entity.dart';

void main() {
  late GameService gameService;

  setUp(() {
    gameService = GameService();
  });

  group('GameService', () {
    group('getWinningCombination', () {
      test('should return null when no winning combination exists', () {
        final elements = ['', '', '', '', '', '', '', '', ''];
        expect(gameService.getWinningCombination(elements), isNull);
      });

      test('should detect horizontal winning combination', () {
        final elements = ['X', 'X', 'X', '', '', '', '', '', ''];
        expect(gameService.getWinningCombination(elements), [0, 1, 2]);
      });

      test('should detect vertical winning combination', () {
        final elements = ['O', '', '', 'O', '', '', 'O', '', ''];
        expect(gameService.getWinningCombination(elements), [0, 3, 6]);
      });

      test('should detect diagonal winning combination', () {
        final elements = ['X', '', '', '', 'X', '', '', '', 'X'];
        expect(gameService.getWinningCombination(elements), [0, 4, 8]);
      });
    });

    group('evaluateState', () {
      test('should return playerOneWon when player one wins', () {
        final elements = ['O', 'O', 'O', '', '', '', '', '', ''];
        expect(gameService.evaluateState(elements, true), CurrentGameState.playerOneWon);
      });

      test('should return playerTwoWon when player two wins', () {
        final elements = ['X', 'X', 'X', '', '', '', '', '', ''];
        expect(gameService.evaluateState(elements, false), CurrentGameState.playerTwoWon);
      });

      test('should return draw when board is full', () {
        final elements = ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'O'];
        expect(gameService.evaluateState(elements, true), CurrentGameState.draw);
      });

      test('should return inProgress when game is not finished', () {
        final elements = ['X', 'O', '', '', '', '', '', '', ''];
        expect(gameService.evaluateState(elements, true), CurrentGameState.inProgress);
      });
    });

    group('calculateBestMove', () {
      test('should return null when board is full', () {
        final elements = ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'O'];
        expect(gameService.calculateBestMove(elements, 'X', 'O'), isNull);
      });

      test('should win when AI can win next move', () {
        final elements = ['O', 'O', '', 'X', '', '', '', '', ''];
        // AI is O
        expect(gameService.calculateBestMove(elements, 'X', 'O'), 2);
      });

      test('should block player when player can win next move', () {
        final elements = ['X', 'X', '', 'O', '', '', '', '', ''];
        // AI is O, Player is X
        expect(gameService.calculateBestMove(elements, 'X', 'O'), 2);
      });

      test('should prioritize winning over blocking', () {
        final elements = ['O', 'O', '', 'X', 'X', '', '', '', ''];
        // AI can win at 2, player can win at 5
        expect(gameService.calculateBestMove(elements, 'X', 'O'), 2);
      });
    });
  });
}
