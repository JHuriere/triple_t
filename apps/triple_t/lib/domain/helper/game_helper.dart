const kGameEmoticons = [
  '🎮', '🎯', '🎲', '🎪', '🎨', '🎭', //
  '🎰', '🎸', '🎺', '🎹', '🚀', '🛸', //
  '🛹', '⚽', '🏀', '🏈', '⚾', '🎾', //
  '🏐', '🏉', '🎱', '🏓', '🏸', '🏒', //
  '🏑', '🥏', '🎿', '⛷️', '🏂', '🪂', //
  '🤿', '🎣', '🥊', '🤖', '⛳', '🎳', //
];

enum ResultType { winner, draw }

class GameHelper {
  static List<int>? getWinningCombination(List<String> elements) {
    const List<List<int>> winningCombinations = [
      // Rows
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      // Columns
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      // Diagonals
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final combination in winningCombinations) {
      final a = combination[0];
      final b = combination[1];
      final c = combination[2];

      if (elements[a].isNotEmpty && elements[a] == elements[b] && elements[a] == elements[c]) {
        return combination;
      }
    }

    return null;
  }

  /// Determines the best move for the AI by first checking if it can win in the next move, then checking if
  /// it needs to block the player from winning, and finally picking a random available spot if neither condition is met.
  /// [emoticon] is the player's emoticon, and [emoticon2] is the AI's emoticon.
  static int? getBestAIMove(List<String> elements, String emoticon, String emoticon2) {
    // Check if AI can win in the next move
    for (int i = 0; i < elements.length; i++) {
      if (elements[i] == '') {
        elements[i] = emoticon2;
        if (getWinningCombination(elements) != null) {
          return i;
        }
        elements[i] = '';
      }
    }

    // Check if player can win in the next move and block them
    for (int i = 0; i < elements.length; i++) {
      if (elements[i] == '') {
        elements[i] = emoticon;
        if (getWinningCombination(elements) != null) {
          return i;
        }
        elements[i] = '';
      }
    }

    // Otherwise, pick a random available spot
    final availableMoves = List<int>.generate(elements.length, (i) => i).where((i) => elements[i] == '').toList(growable: false);
    if (availableMoves.isNotEmpty) {
      availableMoves.shuffle();
      return availableMoves.first;
    }
    return null;
  }
}
