import 'package:game_domain/src/entity/current_game_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_service.g.dart';

@riverpod
GameService gameService(Ref ref) => GameService();

class GameService {
  /// Possible winning combinations for Tic-Tac-Toe.
  static const List<List<int>> _winningCombinations = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
    [0, 4, 8], [2, 4, 6], // Diagonals
  ];

  /// Analyzes the board and returns the winning combination if it exists.
  List<int>? getWinningCombination(List<String> elements) {
    for (final combination in _winningCombinations) {
      final a = elements[combination[0]];
      final b = elements[combination[1]];
      final c = elements[combination[2]];

      if (a.isNotEmpty && a == b && a == c) {
        return combination;
      }
    }
    return null;
  }

  /// Determines the new state of the game after a move.
  CurrentGameState evaluateState(List<String> elements, bool isPlayerOneTurn) {
    if (getWinningCombination(elements) != null) {
      return isPlayerOneTurn ? CurrentGameState.playerOneWon : CurrentGameState.playerTwoWon;
    }
    if (!elements.contains('')) {
      return CurrentGameState.draw;
    }
    return CurrentGameState.inProgress;
  }

  /// Calculates the best move for the AI.
  int? calculateBestMove(List<String> elements, String playerEmoticon, String aiEmoticon) {
    // 1. Try to win
    for (int i = 0; i < elements.length; i++) {
      if (elements[i].isEmpty) {
        final mockBoard = List<String>.from(elements)..[i] = aiEmoticon;
        if (getWinningCombination(mockBoard) != null) return i;
      }
    }

    // 2. Block player from winning
    for (int i = 0; i < elements.length; i++) {
      if (elements[i].isEmpty) {
        final mockBoard = List<String>.from(elements)..[i] = playerEmoticon;
        if (getWinningCombination(mockBoard) != null) return i;
      }
    }

    // 3. Pick random available spot
    final available = [
      for (var i = 0; i < elements.length; i++)
        if (elements[i].isEmpty) i,
    ];
    if (available.isEmpty) return null;

    final shuffled = List<int>.from(available)..shuffle();
    return shuffled.first;
  }
}
