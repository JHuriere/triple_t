sealed class ResultState {}

class InitialResultState extends ResultState {}

class WinnerResultState extends ResultState {
  WinnerResultState({
    required this.winningLine,
    required this.winner,
  });

  final List<int> winningLine;
  final String winner;
}

class DrawResultState extends ResultState {}

class NoResultState extends ResultState {}
